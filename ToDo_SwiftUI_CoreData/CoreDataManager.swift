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
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDo_SwiftUI_CoreData")
        
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
