//
//  Order.swift
//  final test
//
//  Created by Amit Sureka on 14/01/24.
//

import Foundation
import SwiftData
@Model
class Order: Identifiable {
    var id: String
    var product_name: String
    var quantity: Int
    var status: String
    var date: String
    var screw:Product?
    var person:User?

    init(product_name: String, quantity: Int, status: String, date:String, person:User?=nil) {
        self.id=UUID().uuidString
        self.product_name = product_name
        self.quantity = quantity
        self.status=status
        self.date=date
        self.person=person
    }

}
