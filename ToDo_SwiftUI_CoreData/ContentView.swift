//
//  ContentView.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 20.05.22.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    let title: String
}

struct ContentView: View {
    @State private var todoItems: [TodoItem] = [
        .init(title: "Item 1"),
        .init(title: "Item 2")
    ]

    
    var body: some View {
        NavigationView {
            List (todoItems) { todoItems in
                Text(todoItems.title)
            }
            .navigationTitle("ToDo's")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        todoItems.append(.init(title: "Item \((0...9).randomElement()!)"))
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
