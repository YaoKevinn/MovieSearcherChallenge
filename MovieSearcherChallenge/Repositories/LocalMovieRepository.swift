//
//  LocalMovieRepository.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import Foundation

class LocalMovieRepository: MovieRepositoryProtocol {
    
    let coreDataManager = CoreDataManager()
    
    func getMovies(searchText: String, page: Int, completion: @escaping ([MovieDTO], Int, Int) -> Void, errorHandler: @escaping ((NetworkError) -> Void)) {
        let moviesRes = coreDataManager.searchMoviesByPage(searchText: searchText, page: page)
        completion(moviesRes.0, moviesRes.1, moviesRes.2)
    }
}
