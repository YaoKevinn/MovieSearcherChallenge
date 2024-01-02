//
//  MovieDetailDTO.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//

import Foundation

struct MovieDTO: Codable {
    let id: String
    let overview: String
    let posterPath: String
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

