//
//  DataModel.swift
//  CoreData-Transactions
//
//  Created by Syd Polk on 12/25/20.
//

import Foundation
import CoreData

class DataModel: NSManagedObject, Encodable, Decodable {
    
    required convenience init(from decoder: Decoder) throws {
        self.init(context: PersistenceController.shared.container.viewContext)
    }
    
    func name() -> String {
        return "must inherit"
    }
    
    func getId() -> String {
        return "must inherit"
    }
    
    func getTimestamp() -> Date {
        return Date.init(timeIntervalSince1970: 0)
    }
}
