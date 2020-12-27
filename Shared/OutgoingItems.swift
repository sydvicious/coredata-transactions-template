//
//  OutgoingItems.swift
//  CoreData-Transactions
//
//  Created by Syd Polk on 12/25/20.
//

import Foundation
import CoreData

class OutgoingItems {
    static let shared = OutgoingItems()
    
    public func add(_ data: DataModel) throws {
        do {
            let context = PersistenceController.shared.container.viewContext
            let newItem = Outgoing(context: context)
            newItem.dataid = data.getId()
            newItem.data = try JSONEncoder().encode(data).base64EncodedString()
            newItem.timestamp = data.getTimestamp()
            newItem.type = data.name()
            newItem.id = UUID().uuidString
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

    }
    
    public func syncAndDrain() {
    }
}
