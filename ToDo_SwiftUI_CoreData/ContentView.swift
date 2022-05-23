//
//  ContentView.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 20.05.22.
//

import SwiftUI

//struct TodoItem: Identifiable {
//    let id = UUID()
//    let title: String
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false)]) var tasks: FetchedResults<Task>

    var body: some View {
        NavigationView {
            List (tasks) { task in
                Text(task.title ?? "N/A")
            }
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        let newTask = Task(context: viewContext)
                        newTask.title = "Test Titel 123"
                        newTask.id = UUID()
                        newTask.timestamp = Date()
                        newTask.priority = 0
                        
                        try? viewContext.save()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
