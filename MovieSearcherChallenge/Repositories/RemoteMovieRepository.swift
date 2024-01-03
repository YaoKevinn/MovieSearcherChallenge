//
//  MovieRepository.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case Connectivity
    case NoDataReceived
    case DecodingError
    case InvalidURL
    case InvalidImage
}

protocol MovieRepositoryProtocol {
    func getMovies(searchText: String, page: Int, completion: @escaping ([MovieDTO], Int, Int) -> Void, errorHandler: @escaping ((NetworkError) -> Void))
}

class RemoteMovieRepository: MovieRepositoryProtocol {
    
    let baseUrl: String = "https://api.themoviedb.org/3/"
    let token: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZWUzOTk4NjQwYjU0MTFlMGZkODRkMDU3MTA1MmVjYiIsInN1YiI6IjVmZjljYWFkZGQ4M2ZhMDAzZDZlYjMxMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LQ2pFTi0T-mI4goHmTE5TvAgflk-cBcBlajskn-OscM"
    //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let coreDataManager = CoreDataManager()
    
    func getMovies(searchText: String, page: Int = 1, completion: @escaping ([MovieDTO], Int, Int) -> Void, errorHandler: @escaping ((NetworkError) -> Void)) {
        
        let urlString = baseUrl + "search/movie?query=\(searchText)&include_adult=false&language=en-US&page=\(page)".replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let _ = error {
                    errorHandler(NetworkError.Connectivity)
                    return
                }
                
                guard let responseData = data else {
                    errorHandler(NetworkError.NoDataReceived)
                    return
                }
                
                
                do {
                    let res = try JSONDecoder().decode(MovieResponse.self, from: responseData)
                    
                    // Download images with type "Data"
                    self.downloadImages(for: res.results) { result in
                        switch result {
                        case .success(let moviesWithImages):
                            // Save fetched data to core data
                            self.coreDataManager.insertMoviesIfNeeded(movieDTOs: moviesWithImages)
                            self.coreDataManager.getMovies()
                            completion(moviesWithImages, res.page, res.totalPages)
                        case .failure(let error):
                            print("Error downloading images: \(error)")
                        }
                    }
                } catch(let error) {
                    print("ERROR: \(error)")
                    errorHandler(NetworkError.DecodingError)
                }
            }
            task.resume()
        } else {
            errorHandler(NetworkError.InvalidURL)
        }
    }
    
    private func downloadImages(for movies: [MovieDTO], completion: @escaping (Result<[MovieDTO], Error>) -> Void) {
        var moviesWithImages: [MovieDTO] = []
        let group = DispatchGroup()
        
        for movie in movies {
            group.enter()
            
            if let posterPath = movie.posterPath {
                downloadImage(for: posterPath) { result in
                    switch result {
                    case .success(let imageData):
                        var movieWithImage = movie
                        movieWithImage.image = imageData
                        moviesWithImages.append(movieWithImage)
                    case .failure(_):
                        var movieWithImage = movie
                        movieWithImage.image = nil
                        moviesWithImages.append(movieWithImage)
                    }
                    
                    group.leave()
                }
            } else {
                moviesWithImages.append(movie)
                group.leave()
            }
        }
        
        group.notify(queue: .global()) {
            completion(.success(moviesWithImages.sorted(by: { self.sortedMovies($0, $1) })))
        }
    }
    
    private func downloadImage(for imagePath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w400" + imagePath) else {
            completion(.failure(NetworkError.InvalidImage))
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            
            if let data = data, error == nil {
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.InvalidImage))
            }
        }.resume()
    }
        
    private func sortedMovies(_ movie1: MovieDTO, _ movie2: MovieDTO) -> Bool {
        if movie1.image == nil && movie2.image == nil {
            return false
        } else if movie1.image == nil {
            return false
        } else if movie2.image == nil {
            return true
        } else {
            return false
        }
    }
}
