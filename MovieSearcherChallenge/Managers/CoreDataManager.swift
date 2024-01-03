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
    
    func getMovies() {
        do {
            let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
            let data = try mainContext.fetch(fetchRequest)
            print("-------DATA FOR MOVIES-------")
            print("Total count: \(data.count)")
            print(data.map({ $0.image }))
        } catch {
            print("Error checking if movie exists: \(error.localizedDescription)")
        }
    }
    
    func deleteAllMovies() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

       do {
           let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
           try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
           try mainContext.save()
       } catch {
           print("Error deleting all data: \(error)")
       }
    }

    private func checkIfMovieExists(id: Int, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let count = try context.count(for: fetchRequest)
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
