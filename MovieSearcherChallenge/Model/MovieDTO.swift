//
//  MovieDetailDTO.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//

import Foundation

struct MovieDTO: Codable {
    let id: Int
    let overview: String
    var posterPath: String? = nil
    let releaseDate: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

struct MovieResponse: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
