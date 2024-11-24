//
//  PlaceOrderView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import SwiftData
struct PlaceOrderView: View {
    @Environment(\.modelContext) private var context
    @State private var quantity: Int = 0
    @State private var showingZeroOrder = false
    @Binding var showingOrder: Bool
    var product:Product
    var username:User
    @State private var showingOrderConfirmation = false
    @State private var showingOrderNotAvailable = false
       var body: some View {
               VStack {
                   Text(product.name)
                       .font(.system(size: 24, weight: .bold, design: .default))
                       .foregroundColor(.primary)
                       .padding(.top)
                   
                   Stepper("Quantity: \(quantity)", value: $quantity, in: 0...100)
                       .padding()
                   Text("Total Price: ₹\(totalPrice)")
                       .font(.title)
                   Spacer()
                   //HStack {
                   Spacer()
                   Spacer()
                   Spacer()
                   Spacer()
                   Spacer()
                       .alert("Order Confirmed", isPresented: $showingOrderConfirmation) {
                           Button("OK", role: .cancel ) {
                               showingOrder = false
                           }
                       } message: {
                           Text("Your order for \(product.name) has been placed.")
                       }
                       .alert("You cannot place order with 0 items", isPresented: $showingZeroOrder){
                           Button("OK",role: .cancel){}
                       }
                       .alert("Try Again",isPresented: $showingOrderNotAvailable){
                           Button("OK",role: .cancel){
                               showingOrder=false
                           }
                       } message: {
                           Text("Your order could not be processed because currently item is unavailable, try ordering in some time. Sorry for the inconvenience.")
                       }
                       Button("Confirm Order") {
                           // Handle confirm order action
                           let order=Order(product_name: product.name, quantity: quantity, status: "Pending", date: Date().formatted(),person: username)
                           if order.quantity==0{
                               showingZeroOrder=true
                               context.delete(order)
                           }
                           else{
                               if order.quantity>product.current_supply{
                                   showingOrderNotAvailable=true
                                   context.delete(order)
                               }
                               else{
                                   username.orders.append(order)
                                   context.insert(order)
                                   showingOrderConfirmation=true
                               }
                           }

                       }
                       .font(.system(size: 17, weight: .medium, design: .default))
                       .foregroundColor(.white)
                       .frame(width: 300,height: 15.0)
                       .padding()
                       .background(Color.green)
                       .cornerRadius(10)
                       Button("Cancel Order") {
                           // Handle cancel order action
                           showingOrder=false
                       }
                       .font(.system(size: 17, weight: .medium, design: .default))
                       .foregroundColor(.white)
                       .frame(width: 300,height: 15.0)
                       .padding()
                       .background(Color.red)
                       .cornerRadius(10)
                   //}
                   .padding(.horizontal)
               }
               .frame(width: 300, height: 300)
               .padding()
           }


       private var totalPrice: Int {
           return Int(quantity) * product.price
       }
}



