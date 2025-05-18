//
//  CoreDataManager.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LaunchFavorites")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        guard context.hasChanges else {
            return
        }
        
        try? context.save()
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    func add(_ launch: Launch) {
        let storage = Favorites(context: context)
        storage.id = launch.rocket
        saveContext()
    }
    
    func removeLaunch(by id: String) {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            if let launch = try context.fetch(request).first {
                delete(launch)
            }
        } catch {
            print("Failed to delete launch with id \(id): \(error)")
        }
    }
    
    func getAllLaunches() -> [Favorites] {
          let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
          do {
              return try context.fetch(request)
          } catch {
              print("Failed to get launches: \(error)")
              return []
          }
      }
}
