//
//  CoreDataManager.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 20.05.22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    static var preview: CoreDataManager = {
        let manager = CoreDataManager(inMemory: true)
        let viewContext = manager.persistentContainer.viewContext
        
        for _ in 0..<2 {
            let task = Task(context: viewContext)
            task.id = UUID()
            task.title = "Mustertitel \((0...50).randomElement()!)"
            task.priority = (0...2).randomElement()!
            task.timestamp = Date()
        }
        
        
        try? viewContext.save()
        
        return manager
    }()
    
    let persistentContainer: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ToDo_SwiftUI_CoreData")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
