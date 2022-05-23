//
//  AddTaskView.swift
//  ToDo_SwiftUI_CoreData
//
//  Created by star on 23.05.22.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var title: String
    @State private var priority: Int
    private var task: Task?
    
    init(task: Task? = nil) {
        self.task = task
        self._title = State(initialValue: task?.title ?? "")
        self._priority = State(initialValue: Int(task?.priority ?? 0))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Titel")) {
                    TextField("Aufräumen", text: $title)
                }
                Section(header: Text("Priorität")) {
                    Picker("", selection: $priority) {
                        Text("Normal").tag(0)
                        Text("!!").tag(1)
                        Text("!!!").tag(2)              //alternative w/ foreach
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Abbrechen") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Speichern") {
                        if let task = task {
                            updateTask(task: task)
                        } else {
                            createTask()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            })
            .navigationTitle(task == nil ? "Neue Aufgabe" : "Bearbeiten")
            .navigationBarTitleDisplayMode(task == nil ? .large : .inline)
        }
    }
    
    func updateTask(task: Task) {
        task.title = title
        task.priority = Int16(priority)
        
        try? viewContext.save()
    }
    
    func createTask() {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.title = title
        task.priority = Int16(priority)
        task.timestamp = Date()
        
        try? viewContext.save()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
