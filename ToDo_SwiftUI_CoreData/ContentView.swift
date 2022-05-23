//
//  ContentView.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 20.05.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false), NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)]) var tasks: FetchedResults<Task>
    
    @State private var presentSheet = false
    private var priorityRepresentation = ["", "!!", "!!!"]
    
    var body: some View {
        NavigationView {

            taskView
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
    
    @ViewBuilder
    var taskView: some View {
        if tasks.isEmpty {
            VStack(spacing: 30) {
                Image(systemName: "tray.full")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                Text("Keine Aufgaben")
                    .font(.system(size: 30, weight: .semibold))
            }
            .foregroundColor(Color.black.opacity(0.4))
        } else {
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
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(viewContext.delete)

        try? viewContext.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)
    }
}
