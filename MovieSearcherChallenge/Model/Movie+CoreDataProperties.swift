//
//  Movie+CoreDataProperties.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 02/01/2024.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?

}

extension Movie : Identifiable {}
