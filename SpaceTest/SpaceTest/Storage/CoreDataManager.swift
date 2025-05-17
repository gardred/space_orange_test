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
        let container = NSPersistentContainer(name: "")
        
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
    
    func fetch<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
         let request = T.fetchRequest()
         request.predicate = predicate
         request.sortDescriptors = sortDescriptors

         do {
             return try context.fetch(request) as? [T] ?? []
         } catch {
             return []
         }
     }
}
