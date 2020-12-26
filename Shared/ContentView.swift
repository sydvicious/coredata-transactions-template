//
//  ContentView.swift
//  Shared
//
//  Created by Syd Polk on 12/12/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Amount.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Amount>

    var body: some View {
        #if os(iOS)
        NavigationView {
            List {
                ForEach(items) { item in
                    Text("Item at \(item.timestamp!, formatter: itemFormatter); amount: \(item.amount ?? 0.0)")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarItems(trailing: Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            })
        }
        #else
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
        #endif
    }

    private func addItem() {
        withAnimation {
            do {
                let newItem = Item(context: viewContext)
                let newAmount = Amount(context: viewContext)
                let timestamp = Date()
                newItem.timestamp = timestamp
                newItem.id = UUID().uuidString
                newAmount.timestamp = timestamp
                newAmount.amount = NSDecimalNumber(value: Double.random(in: -1000000.00..<1000000.00))
                newAmount.id = UUID().uuidString
                newItem.dataid = newAmount.id
                newItem.data = try JSONEncoder().encode(newAmount).base64EncodedString()
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
