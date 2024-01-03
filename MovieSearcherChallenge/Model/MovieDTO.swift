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
    var image: Data? = nil
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
    
    init(id: Int, overview: String, posterPath: String? = nil, releaseDate: String, title: String, image: Data? = nil, isFavorite: Bool = false) {
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.image = image
        self.isFavorite = isFavorite
    }
    
    init(dataObject: Movie) {
        self.id = Int(dataObject.id)
        self.overview = dataObject.overview ?? "-"
        self.posterPath = dataObject.posterPath
        self.releaseDate = dataObject.releaseDate ?? "-"
        self.title = dataObject.title
        self.image = dataObject.image
        self.isFavorite = dataObject.isFavorite
    }
    
    static func dummy() -> MovieDTO {
        MovieDTO(
            id: 10091722,
            overview: "A police squad on a mission… A football match… Tension rises on both sides… The shooting starts and the team must face the pressure. When rivalry and betrayal slide onto the field, the team spirit and trust fly to bits.",
            posterPath: "/t57HRefWpqIztScbQAVRdHm7v9V.jpg",
            releaseDate: "2020-09-05",
            title: "Flash",
            isFavorite: false
        )
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
