//
//  ProfileView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import SwiftData




struct ProgressCell: View {
    @State var progress:Double
    @State var progressImages:[String]=["archivebox","shippingbox","truck.box.badge.clock","checkmark.circle"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .frame(height: 4)
                
                Rectangle()
                    .foregroundColor(Color.green)
                    .frame(width: CGFloat(progress) * 300, height: 4)
                HStack(spacing: 76) {
                    ForEach(0..<4) { index in
                        ZStack{
                            Circle()
                                .fill(Color.black)
                                .frame(width: 22, height: 22)
                            Image(systemName: "\(progressImages[index])")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15) // Size of the image
                                .foregroundColor(.white)
                        }
                            
                    }
                }
            }
            .cornerRadius(10)
        }
    }
}

struct ProfileView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State private var path=NavigationPath()
    @Binding var showingProfile: Bool
    var isadmin:Bool
    var username:User
    @Query var orders:[Order]
    
    
    var completionAction: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 100)
                        //.padding()
                    
                    Text(username.username)
                        .font(.title)
                        .bold()
                }
                .listRowInsets(.none)
                .listRowBackground(Color(uiColor: .systemGroupedBackground))
                .frame(maxWidth: .infinity)
                
                // Your Orders Section
                Section("Your Orders") {
                    List {
                        if isadmin{
                            ForEach(orders) { order in
                                if order.quantity != 0 {
                                    HStack {
                                        if order.status=="Completed"{
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.green)
                                        } else {
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.red)
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text("Product: \(order.product_name)")
                                                .foregroundColor(.primary)
                                            Text("Quantity: \(order.quantity)")
                                                .foregroundColor(.primary)
                                            //                            Text(order.status == .completed ? "Completed" : "Pending")
                                            //                                .foregroundColor(order.status == .completed ? .green : .orange)
                                                .font(.caption)
                                        }
                                        Spacer()
                                        Text(order.date)
                                            .foregroundColor(.secondary)
                                            .font(.caption)
                                    }
                                    .padding(.vertical, 4)
                                }
                                
                            }
                        } else {
                            ForEach(username.orders) { order in
                                if order.quantity != 0 {
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            Text("Product: \(order.product_name)")
                                                .foregroundColor(.primary)
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                //.lineLimit(1)
                                            Text("Quantity: \(order.quantity)")
                                                .foregroundColor(.primary)
                                                .font(.caption)
                                            Text(order.date)
                                                .foregroundColor(.primary)
                                                .font(.caption)
                                            if order.status=="Pending"{
                                                
                                                ProgressCell(progress: 0.25)
                                                .frame(width: 300, height: 4)
                                                .padding(.bottom,5)
                                                .padding(.top,5)
                                            } else if order.status=="Packaged"{
                                                ProgressCell(progress: 0.5)
                                                .frame(width: 300, height: 4)
                                                .padding(.bottom,5)
                                                .padding(.top,5)
                                            } else if order.status=="Being Delivered"{
                                                ProgressCell(progress: 0.75)
                                                .frame(width: 300, height: 4)
                                                .padding(.bottom,5)
                                                .padding(.top,5)
                                            } else if order.status=="Completed"{
                                                ProgressCell(progress: 1.0)
                                                .frame(width: 300, height: 4)
                                                .padding(.bottom,5)
                                                .padding(.top,5)
                                            }
                                            Text("Your order is \(order.status.lowercased())")
                                                .foregroundColor(.secondary)
                                                .font(.subheadline)
                                                //.lineLimit(1)
                                        }
                                        Spacer()


                                    }

                                }
                                
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(colorScheme == .dark ? .black : .white)
                            .font(.headline)
                            .scaleEffect(0.8)
                            .padding(5)
                            .background(.secondary.opacity(0.8), in: Circle())
                    }
                    .tint(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Log Out", role: .destructive) {
                        dismiss()
                        completionAction()
                    }
                    .tint(.red)
                })
            }
        }
    }
}


