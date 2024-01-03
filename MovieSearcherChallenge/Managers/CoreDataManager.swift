//
//  CoreDataManager.swift
//  MovieSearcherChallenge
//
//  Created by YaoKevinn on 03/01/2024.
//

import CoreData
import UIKit

class CoreDataManager {
    private let mainContext: NSManagedObjectContext
    
    init() {
        self.mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func insertMoviesIfNeeded(movieDTOs: [MovieDTO]) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainContext
        
        privateContext.perform {
            for movieDTO in movieDTOs {
                if !self.checkIfMovieExists(id: movieDTO.id, context: privateContext) {
                    _ = self.insertMovie(movieDTO: movieDTO, context: privateContext)
                }
            }
            
            do {
                try privateContext.save()
                self.mainContext.perform {
                    do {
                        try self.mainContext.save()
                        print("Movies inserted successfully")
                    } catch {
                        print("Error saving changes to main context: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error saving changes to private context: \(error.localizedDescription)")
            }
        }
    }
    
    // For testing use
//    func getMovies() {
//        do {
//            let fetchRequest = Movie.fetchRequest()
//            let data = try mainContext.fetch(fetchRequest)
//            print("-------DATA FOR MOVIES-------")
//            print("Total count: \(data.count)")
//            print(data.map({ $0.title }))
//        } catch {
//            print("Error getting movies from CoreData: \(error.localizedDescription)")
//        }
//    }
    
    func getAllFavorites() -> [MovieDTO] {
        if let favIds = UserDefaults.standard.array(forKey: "favoritesMovieIds") as? [Int] {
            do {
                let request = Movie.fetchRequest()
                let movies = try mainContext.fetch(request)
                let filteredMovies = movies.filter({ favIds.contains(Int($0.id)) })
                let movieDTOs = filteredMovies.map({ MovieDTO(dataObject: $0) })
                
                return movieDTOs
            } catch {
                print("Error getting favorite movies from CoreData: \(error.localizedDescription)")
                return ([])
            }
        } else {
            return []
        }
    }
    
    func searchMoviesByPage(searchText: String, page: Int, size: Int = 20) -> ([MovieDTO], Int, Int) {
        do {
            let request = Movie.fetchRequest()
            let pred = NSPredicate(format: "title CONTAINS[c] %@", searchText)
            request.predicate = pred
            let totalMoviesCount = try mainContext.count(for: request)
            let totalPagesCount = Int(totalMoviesCount / size) + (totalMoviesCount % size == 0 ? 0 : 1)
            
            request.fetchLimit = size
            request.fetchOffset = (page - 1) * size
            
            let movies = try mainContext.fetch(request)
            let movieDTOs = movies.map({ MovieDTO(dataObject: $0) })
            
            return (movieDTOs, page, totalPagesCount)
        } catch {
            print("Error searching movies from CoreData: \(error.localizedDescription)")
            return ([], 1, 1)
        }
    }
    
    func deleteAllMovies() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

       do {
           let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
           try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
           try mainContext.save()
       } catch {
           print("Error deleting all data: \(error)")
       }
    }

    private func checkIfMovieExists(id: Int, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if movie exists: \(error.localizedDescription)")
            return false
        }
    }

    private func insertMovie(movieDTO: MovieDTO, context: NSManagedObjectContext) -> Movie? {
        let movie = Movie(context: context)
        movie.id = Int32(movieDTO.id)
        movie.overview = movieDTO.overview
        movie.posterPath = movieDTO.posterPath
        movie.releaseDate = movieDTO.releaseDate
        movie.title = movieDTO.title
        movie.image = movieDTO.image

        return movie
    }
}
