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
            List {
                ForEach (tasks) { task in
                    HStack {
                        Text(priorityRepresentation[Int(task.priority)])
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                        Text(task.title ?? "N/A")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            .listStyle(PlainListStyle())
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(tasks.isEmpty)
                }
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
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(viewContext.delete)
        
        
        // #2 way
//        tasksToDelete.forEach { task in
//            viewContext.delete(task)
//        }
        // #1 way
//        var tasksToDelete = Array<Task>()
//
//        for index in offsets {
//            tasksToDelete.append(tasks[index])
//        }
//
//        for task in tasksToDelete {
//            viewContext.delete(task)
//        }
        
        try? viewContext.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)
    }
}
