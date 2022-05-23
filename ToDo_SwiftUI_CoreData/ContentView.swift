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
//
//    @State private var todoItems: [TodoItem] = [
//        .init(title: "Item 1"),
//        .init(title: "Item 2")
//    ]
//
//
    var body: some View {
        NavigationView {
//            List (todoItems) { todoItems in
//                Text(todoItems.title)
//            }
            Text("Temp")
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
