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
}

protocol MovieRepositoryProtocol {
    func getMovies(searchText: String, page: Int, completion: @escaping ([Movie], Int, Int) -> Void, errorHandler: @escaping ((NetworkError) -> Void))
}

class RemoteMovieRepository: MovieRepositoryProtocol {
    
    let baseUrl: String = "https://api.themoviedb.org/3/"
    let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getMovies(searchText: String, page: Int = 1, completion: @escaping ([Movie], Int, Int) -> Void, errorHandler: @escaping ((NetworkError) -> Void)) {
        
        let urlString = baseUrl + "search/movie?query=\(searchText)&include_adult=false&language=en-US&page=\(page)".replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZWUzOTk4NjQwYjU0MTFlMGZkODRkMDU3MTA1MmVjYiIsInN1YiI6IjVmZjljYWFkZGQ4M2ZhMDAzZDZlYjMxMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LQ2pFTi0T-mI4goHmTE5TvAgflk-cBcBlajskn-OscM",
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
                    var movies: [Movie] = []
                    for movieObj in res.results {
                        let movie = Movie(context: self.context)
                        movie.id = "\(movieObj.id)"
                        movie.title = movieObj.title
                        movie.overview = movieObj.overview
                        movie.releaseDate = movieObj.releaseDate
                        movie.posterPath = (movieObj.posterPath != nil) ? self.imageBaseUrl + (movieObj.posterPath ?? "") : nil
                        movie.isFavorite = false
                        movies.append(movie)
                    }
                    completion(movies, res.page, res.totalPages)
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
}
