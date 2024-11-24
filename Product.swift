//
//  Product.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Product: Identifiable {
    //var id: String
    var name: String
    var companyName: String
    var inorder: Order?
    var current_supply: Int
    var min_supply: Int
    var price: Int
    var descriptor: String?
    @Attribute(.externalStorage) var imageData: Data?

    init(name: String, companyName: String, inorder: Order? = nil, current_supply: Int, min_supply: Int, price: Int, descriptor: String? = nil, imageData: Data? = nil) {
        self.name = name
        self.companyName = companyName
        self.inorder = inorder
        self.current_supply = current_supply
        self.min_supply = min_supply
        self.imageData = imageData
        self.price = price
        self.descriptor = descriptor
    }

}


extension Product {
    var image: Image? {
        if let imageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
}

