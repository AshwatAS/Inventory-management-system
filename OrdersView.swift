//
//  OrdersView.swift
//  final test
//
//  Created by Amit Sureka on 23/01/24.
//

import SwiftUI
import SwiftData

struct OrderCell: View{
    var order: Order
    @State private var showingPackaged = false
    @State private var showingDelivered = false
    @State private var showingConfirmation = false
    @State private var showingError=false
    @Query var products:[Product]
    var shippingbox=Image(systemName: "shippingbox")
    var delivery=Image(systemName: "truck.box.badge.clock")
    var completed=Image(systemName: "checkmark.circle")
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.product_name)
                    .font(.headline)
                Text("Placed by: \(order.person!.username)")
                    .font(.subheadline)
                Text("Quantity: \(order.quantity)")
                    .font(.subheadline)
                Text(order.date)
                    .font(.subheadline)

            }
            .alert("Product Unavailable", isPresented: $showingError){
                Button("OK",role:.cancel){ }
            } message: {
                Text("You do not have enough of this product in stock to complete this order. Kindly reorder or update supply.")
            }
            .alert("Are you sure you want to mark product as packaged?", isPresented: $showingPackaged){
                Button("Mark as Packaged",role:.destructive){
                    for product in products {
                        if product.name==order.product_name && product.current_supply<order.quantity{
                            showingError=true
                        }
                        else if product.name==order.product_name && product.current_supply>=order.quantity{
                            order.status="Packaged"
                        }
                    }
                }
                Button("Cancel", role: .cancel) { }
            }

            .alert("Are you sure you want to mark product as being delivered?", isPresented: $showingDelivered){
                Button("Mark as Being Delivered",role:.destructive){
                    order.status="Being Delivered"
                }
                Button("Cancel", role: .cancel) { }
            }
            .alert("Are you sure you want to mark order as completed?", isPresented: $showingConfirmation) {
                Button("Mark as Completed", role: .destructive) {
                        //completedOrders.append(order)
                        for product in products {
                            if product.name==order.product_name && product.current_supply<order.quantity{
                                showingError=true
                            }
                            else if product.name==order.product_name && product.current_supply>=order.quantity{
                                product.current_supply=product.current_supply-order.quantity
                                order.status="Completed"
                            }
                        }

                }
                Button("Cancel", role: .cancel) { }
            }
            Spacer()
            if order.status=="Pending"{
                shippingbox
                    .onTapGesture {
                        showingPackaged=true
                    }
                delivery
                    .onTapGesture {
                        showingDelivered=true
                    }
                completed
                    .onTapGesture {
                        showingConfirmation=true
                    }
            }
            else if order.status=="Packaged"{
                shippingbox.opacity(0)
                delivery
                    .onTapGesture {
                        showingDelivered=true
                    }
                completed
                    .onTapGesture {
                        showingConfirmation=true
                    }
            }
            else if order.status=="Being Delivered"{
                shippingbox.opacity(0)
                delivery.opacity(0)
                completed
                    .onTapGesture {
                        showingConfirmation=true
                    }
            }
            else if order.status=="Completed" {
                completed.opacity(0)
                Image(systemName: "shippingbox.fill")
                Image(systemName: "truck.box.badge.clock.fill")
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.black)
            }
        }
    }
}

struct OrdersView: View {
    @Query var orders: [Order]
    @State private var completedOrders: [Order] = []
    

    @State private var selectedOrder: Order?

    @Environment(\.modelContext) private var context
    @State private var deletedOrders: [Order] = []
    @Query var products:[Product]
    var body: some View{
        NavigationView {
            List{
                Section(header: Text("Pending Orders")) {
                    ForEach(orders, id: \.id) { order in
                        if order.status=="Pending" || order.status=="Packaged" || order.status=="Being Delivered"{
                            OrderCell(order: order)

                        }
                    }
                    .onDelete{ indexes in
                        for index in indexes {
                            let deletedOrder=orders[index]
                            deletedOrder.status="Deleted"
                            deletedOrders.append(deletedOrder)
                        }
                    }
                }
                                
                Section(header: Text("Completed Orders")) {
                    ForEach(orders, id: \.id) { order in
                        if order.status=="Completed"{
                            OrderCell(order: order)
                        }
                    }
                    .onDelete{ indexes in
                        for index in indexes {
                            let deletedOrder=orders[index]
                            deletedOrder.status="Deleted"
                            deletedOrders.append(deletedOrder)
                        }
                        
                    }
                }
            }


        }.navigationTitle("Your Orders")

    }
    func deleteitem(_ item:Order) {
            context.delete(item)
     }
}

