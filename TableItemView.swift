//
//  TableItemView.swift
//  final test
//
//  Created by Amit Sureka on 16/01/24.
//

import SwiftUI
import PhotosUI

struct TableItemView: View {
    var product: Product
    var user: User
    var isadmin:Bool
    @Environment(\.modelContext) private var context
    //@State private var isFavourite=false
    @State private var changetoFavourite=false
    
    var body: some View {
        HStack {
            ProductImageView(product: product, sizeOption: .small, isAdmin: isadmin)
            .padding(.trailing, 4)
            .padding(3)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(product.name)
                    Text(product.companyName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if isadmin{
                    if product.current_supply<=product.min_supply{
                        Image(systemName: "checkmark").opacity(0)
                    }else {
                        Image(systemName: "checkmark").opacity(1)
                    }
                } else{
                    heart
                        .foregroundColor(.pink)
                        .onTapGesture {
                            if !user.isFavorites.contains(product) {
                                // Element is not present in the array
                                user.isFavorites.append(product)
                                changetoFavourite=true
                            } else {
                                // Element is present in the array
                                if let index = user.isFavorites.firstIndex(of: product) {
                                    user.isFavorites.remove(at: index)
                                }
                            }
                            
                        }
                }
            }
//        } icon: {
            .alert("Item added to favourites",isPresented: $changetoFavourite){
                Button("OK", role: .cancel) { }
            } message: {
                Text("Check full list on top left corner")
            }
        }

    }
    var heart: Image{
        if user.isFavorites.contains(product) {
            return Image(systemName: "heart.fill")
        }
        else{
            return Image(systemName: "heart")
        }
    }
}

//#Preview {
//    TableItemView(product: Product())
//}
