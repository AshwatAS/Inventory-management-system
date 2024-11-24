//
//  AddProductSheet.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import SwiftData

struct AddProductSheet: View {
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var context
    @State private var path=NavigationPath()
    @Binding var currentSupply: Int
    @Binding var minimumSupply: Int
    @State private var price=""
    @State private var newProductName = ""
    @State private var newCompanyName = ""
    @State private var description = ""
    @State private var showingEmptyAlert = false
    @State private var showingInvalidAlert=false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Details")) {
                    TextField("Product Name", text: $newProductName)
                    TextField("Company Name", text: $newCompanyName)
                    Stepper("Current Supply: \(currentSupply)", value: $currentSupply, in: 0...Int.max)
                    Stepper("Minimum Supply: \(minimumSupply)", value: $minimumSupply, in: 0...Int.max)
                    TextField("Price", text: $price)
                    TextField("Enter a description for your product", text: $description)
                }
                
                Section {
                    Button("Add Product") {
                        addProduct()
                    }
                }
            }
            .navigationTitle("Add New Product")
            .alert("Enter credentials.",isPresented:$showingEmptyAlert){
                Button("OK",role: .cancel){}
            }
            .alert("Enter valid credentials.",isPresented:$showingInvalidAlert){
                Button("OK",role: .cancel){}
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func addProduct() {
        if !newProductName.isEmpty && !newCompanyName.isEmpty && !price.isEmpty {
            let product=Product(name: newProductName, companyName: newCompanyName, current_supply: currentSupply, min_supply:minimumSupply,price: Int(price)!, descriptor: description)
            context.insert(product)
            path.append(product)
            //products.append(Product(name: newProductName, companyName: newCompanyName))
            newProductName = ""
            newCompanyName = ""
            description = ""
            price=""
            currentSupply=0
            minimumSupply=0
            isPresented = false
        }
        else if Int(price)!<0{
            showingInvalidAlert=true
        }
        else{
            showingEmptyAlert=true
        }
    }
}

//#Preview {
//    AddProductSheet()
//}
