//
//  EditSupply.swift
//  final test
//
//  Created by Amit Sureka on 30/01/24.
//

import SwiftUI
import SwiftData
struct EditSupply: View {
    var product: Product
    private var adjustSupplyView:some View{
        HStack {
            Button(action: {
                if product.current_supply > 0 { product.current_supply -= 1 }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.primary)
            }
            
            Text("Current Supply: \(product.current_supply)")
                .font(.title2)
                .padding(.horizontal)
            
            Button(action: {
                product.current_supply += 1
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.primary)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ProductImageView(product: product, sizeOption: .large, isAdmin: true)
                
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(product.companyName)
                    .font(.title2)
                Text("Price: \(String((product.price)))")
                    .font(.title2)
                
                Spacer()
                adjustSupplyView
                Spacer()
                
            }
        }

    }
}

