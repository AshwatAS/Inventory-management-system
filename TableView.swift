//
//  TableView.swift
//  final test
//
//  Created by Amit Sureka on 12/01/24.
//

import SwiftUI
import PhotosUI
import SwiftData


struct TableView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.editMode) var editMode
    @Environment(\.modelContext) private var context
    @Query var products: [Product]
    
//    @State private var products:[Product] = [Product(name: "Screw A", companyName: "Company A"),
//                                    Product(name: "Screw B", companyName: "Company B"),
//                                    Product(name: "Screw C", companyName: "Company C"),
//                                    Product(name: "Screw D", companyName: "Company D")]
     @State private var currentSupply: Int = 0
     @State private var minimumSupply: Int = 0
    //@State private var price: Int=0
     @State private var showingAddProductSheet = false
     @State private var searchText = ""
     @State private var showingProfile = false
//    @State private var showingFavourites = false
     //@State private var selectedProduct: Product
     //@State private var selectedImage: UIImage?
    @State private var selectedImages: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var data: String = ""
     var user: User
    
     @State private var isPresentingImagePicker = false
     @State private var activeImagePickerIndex: Int? = nil
    
    
    var isAdmin: Bool {
        return user.username == "Admin" && user.password == "1234"
    }
    
     var body: some View {
         NavigationStack {
             VStack(spacing: 0) {
                 
                 List {
                     ForEach(searchResults) { product in
                         //selectedProduct = product
                         if isAdmin {
                             NavigationLink(destination: EditSupply.init(product: product)){
                                 TableItemView(product: product, user: user, isadmin: isAdmin)
                             }
                         }
                         else{
                             NavigationLink(destination: ProductDetailView(product: product, username: user)) {
                                 TableItemView(product: product, user: user, isadmin: isAdmin)
                             }.deleteDisabled(true)
                         }
                         
                     }
                     
                     .onDelete{ indexes in
                         //                     if isadmin == true {
                         for index in indexes {
                             deleteitem(products[index])
                             //                         }
                         }
                         
                     } //.disabled(!isadmin)
                     //.onMove(perform: move)
                 }
                 .environment(\.editMode, editMode)
                 .overlay(alignment: .bottomTrailing) {
                     if isAdmin{
                         Button(action: {
                             self.showingAddProductSheet = true
                         }) {
                             Image(systemName: "plus")
                                 .foregroundColor(colorScheme == .dark ? .black : .white)
                                 .padding()
                                 .frame(width: 60, height: 60)
                                 .background(Color.primary)
                                 .clipShape(Circle())
                                 .shadow(radius: 10)
                         }
                         .padding()
                     }
                 }
                 .searchable(text: $searchText)
                 .navigationTitle("Cauvery Industrials")
                 .navigationBarItems(leading: NavigationLink(destination: OrdersView()){
                     if isAdmin{
                         Image(systemName: "list.clipboard")
                     }
                 }
                 )
                 
                 .toolbar {
                     ToolbarItemGroup(placement: .navigationBarTrailing) {
                         //                     if editMode?.wrappedValue == .inactive {
                         Button(action: {
                             self.showingProfile.toggle()
                         }, label: {
                             Label("Profile", systemImage: "person.fill")
                                 .labelStyle(.iconOnly)
                         })
                     }
                     if !isAdmin{
                         ToolbarItemGroup(placement: .navigationBarLeading){
    //                         Button(action: {
    //                             self.showingFavourites.toggle()
    //                         }, label: {
                             NavigationLink(destination: FavouritesView(user: user)){
                                 Image(systemName: "heart.text.square.fill")
                             }
    //                             Label("Favorites", systemImage: "heart.text.square.fill")
    //                                 .labelStyle(.iconOnly)
    //                         })
                         }
                     }
                 }
                 
                 .sheet(isPresented: $showingAddProductSheet) {
                     AddProductSheet(isPresented: $showingAddProductSheet, currentSupply: $currentSupply, minimumSupply: $minimumSupply)
                 }
                 .sheet(isPresented: $showingProfile) {
                     ProfileView(showingProfile: $showingProfile,isadmin: isAdmin, username:user) {
                         dismiss()
                     }
                 }
//                 .sheet(isPresented: $showingFavourites) {
//                     FavouritesView(showingFavourites: $showingFavourites) //{
//                         //dismiss()
//                     //}
//                 }
                 //             .sheet(isPresented: $isPresentingImagePicker) {
                 //                 PhotoPicker(selectedImage: $selectedImage)
                 //             }
                 //             .photosPicker(isPresented: $isPresentingImagePicker, selection: $selectedImages, maxSelectionCount: 1)
                 .task(id: selectedImages) {
                     if selectedImages?.supportedContentTypes.first == .image {
                         self.selectedImage = try? await selectedImages?.loadTransferable(type: Image.self)
                     }
                 }
                 
                 if isAdmin{
                     Text("Click any product to update supply")
                         .foregroundStyle(.secondary)
                         .bold()
                         .padding(5)
                         .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                         .background {
                             Color(uiColor: .systemGroupedBackground)
                                 .ignoresSafeArea()
                         }
                 } else{
                     Text("Click top right to track all your orders")
                         .foregroundStyle(.secondary)
                         .bold()
                         .padding(5)
                         .frame(maxWidth: .infinity, maxHeight: 30, alignment: .center)
                         .background {
                             Color(uiColor: .systemGroupedBackground)
                                 .ignoresSafeArea()
                         }
                 }
             }
         }
     }
     
     var searchResults: [Product] {
         if searchText.isEmpty {
             return products
         } else {
             return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
         }
     }
     
    func deleteitem(_ item:Product) {
            context.delete(item)
     }
     
//     func move(from source: IndexSet, to destination: Int) {
//         products.move(fromOffsets: source, toOffset: destination)
//     }
    }
