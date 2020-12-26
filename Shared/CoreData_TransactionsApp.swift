//
//  CoreData_TransactionsApp.swift
//  Shared
//
//  Created by Syd Polk on 12/12/20.
//

import SwiftUI

@main
struct CoreData_TransactionsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
