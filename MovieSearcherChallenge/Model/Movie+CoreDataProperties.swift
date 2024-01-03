//
//  Movie+CoreDataProperties.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isFavorite: Bool
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String
    @NSManaged public var image: Data?

}

extension Movie : Identifiable {

}
