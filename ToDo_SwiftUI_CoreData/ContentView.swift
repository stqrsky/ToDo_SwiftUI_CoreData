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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false), NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)]) var tasks: FetchedResults<Task>
    
    @State private var presentSheet = false
    private var priorityRepresentation = ["", "!!", "!!!"]

    var body: some View {
        NavigationView {
            List (tasks) { task in
                HStack {
                    Text(priorityRepresentation[Int(task.priority)])
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                    Text(task.title ?? "N/A")
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        presentSheet.toggle()
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
            .environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)
    }
}
