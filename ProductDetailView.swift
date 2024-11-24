//
//  ProductDetailView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import PhotosUI
import SwiftData
struct ProductDetailView: View {
    var product: Product
    @Environment(\.modelContext) private var context
    @State private var showingOrder = false
    

    var username:User

       
       var body: some View {
           VStack {
               ProductImageView(product: product, sizeOption: .large, isAdmin: false)
                
               Text(product.name)
                   .font(.title)
                   .fontWeight(.bold)
               Text(product.companyName)
                   .font(.title2)
                   //.foregroundColor(.secondary)
               Text("Price: \(String((product.price)))")
                   .font(.title2)
                   .padding(.bottom, 10)
               Text("\(product.descriptor!)")
                   .font(.subheadline)
                   .foregroundColor(.secondary)
                   .padding(.leading,10)
                   .padding(.trailing,10)
               
               Spacer()
                   .sheet(isPresented: $showingOrder) {
                       PlaceOrderView(showingOrder: $showingOrder, /*order: order,*/ product: product, username: username)
                   }

               Button(action: {
                   addOrder()
               }){
                   Text("Place Order")
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color.black)
                       .foregroundColor(.white)
                       .cornerRadius(10)
                       .padding(.horizontal)
               }

           }
       }
     func addOrder(){
        self.showingOrder.toggle()

    }
}
