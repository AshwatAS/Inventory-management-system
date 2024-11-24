//
//  FavouritesView.swift
//  final test
//
//  Created by Amit Sureka on 14/02/24.
//

import SwiftUI
import SwiftData
import PhotosUI
struct FavouritesCell: View {
    var product: Product
    @Environment(\.modelContext) private var context
    //@State private var isFavourite=false
    //@State private var changetoFavourite=false
    
    var body: some View {
        HStack {
            ProductImageView(product: product, sizeOption: .small, isAdmin: false)
                .padding(.trailing, 4)
                .padding(3)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(product.name)
                        .fontWeight(.bold)
                    Text(product.companyName)
                    Text("Price: \(String(product.price))")
                    Text("Current Supply: \(String(product.current_supply))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        
    }
}


struct FavouritesView: View {
    @Query var products: [Product]
    //@Binding var showingFavourites: Bool
    var user: User
    var body: some View {
        NavigationStack{
            VStack (spacing: 0){
                List{
                    ForEach(user.isFavorites){ product in
                        NavigationLink(destination: ProductDetailView(product: product, username: user)){
                            FavouritesCell(product: product)
                        }
                    }
                }
            }
        }
        .navigationTitle("My Favourites ❤️")
    }
}


