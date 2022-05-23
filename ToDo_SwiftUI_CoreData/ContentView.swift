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
    
    @State private var presentSheet = false

    var body: some View {
        NavigationView {
            List (tasks) { task in
                Text(task.title ?? "N/A")
            }
            .listStyle(PlainListStyle())
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        presentSheet.toggle()
//                        let newTask = Task(context: viewContext)
//                        newTask.title = "Test Titel 123"
//                        newTask.id = UUID()
//                        newTask.timestamp = Date()
//                        newTask.priority = 0
//
//                        try? viewContext.save()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $presentSheet, content: {
                AddTaskView()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
