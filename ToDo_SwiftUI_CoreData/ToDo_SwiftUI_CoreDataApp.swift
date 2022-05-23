//
//  ToDo_SwiftUI_CoreDataApp.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 20.05.22.
//

import SwiftUI

@main
struct ToDo_SwiftUI_CoreDataApp: App {
    let manager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, manager.persistentContainer.viewContext)
        }
    }
}
