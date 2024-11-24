//
//  User.swift
//  final test
//
//  Created by Amit Sureka on 15/01/24.
//

import Foundation
import SwiftData
@Model
class User{
    var username: String
    var password: String
    var orders=[Order]()
    var isFavorites=[Product]()
    
    init(username: String, password: String, orders: [Order] = [Order](), isFavorites: [Product]=[Product]()) {
        self.username = username
        self.password = password
        self.orders = orders
        self.isFavorites = isFavorites
    }
}



