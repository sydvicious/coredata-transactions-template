//
//  Amount.swift
//  CoreData-Transactions
//
//  Created by Syd Polk on 12/25/20.
//

import Foundation
import CoreData

class Amount: NSManagedObject, Encodable, Decodable {
    
    enum CodingKeys: CodingKey {
        case timestamp, id, amount
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init(context: PersistenceController.shared.container.viewContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.id = try container.decode(String.self, forKey: .id)
        self.amount = NSDecimalNumber(value: try container.decode(Double.self, forKey: .amount))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timestamp, forKey: .id)
        try container.encode(id, forKey: .id)
        try container.encode(amount?.doubleValue, forKey: .amount)
    }
    
}
