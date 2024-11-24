//
//  ProductImageView.swift
//  final test
//
//  Created by Amit Sureka on 13/02/24.
//

import SwiftUI
import PhotosUI

struct ProductImageView: View {
    @Environment(\.modelContext) private var context
    
    var sizeOption: SizeOption
    var product: Product
    var isAdmin: Bool
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    @State private var isPresentingImagePicker = false
    
    init(product: Product, sizeOption: SizeOption, isAdmin: Bool) {
        self.product = product
        self.isAdmin = isAdmin
        self.sizeOption = sizeOption
        if let image = product.image {
            self._image = State(initialValue: image)
        }
    }
    
    enum SizeOption {
        case large
        case small
    }
    
    var paddingAmount: CGFloat {
        switch(sizeOption) {
        case .large:
            return 30
        case .small:
            return 10
        }
    }
    
    var size: CGFloat {
        switch(sizeOption) {
        case .large:
            return 150
        case .small:
            return 50
        }
    }
    
    var body: some View {
           Group {
               if let image {
                   image
                       .resizable()
               } else {
                   Image(systemName: "photo")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .padding(paddingAmount)
                       .foregroundColor(.secondary)
               }
           }
           .frame(width: size, height: size)
           .background(Color(uiColor: .systemGray2))
           .clipShape(Circle())
           .onTapGesture {
               if isAdmin {
                   isPresentingImagePicker.toggle()
               }
           }
        
        .photosPicker(isPresented: $isPresentingImagePicker, selection: $selectedPhoto)
        .onChange(of: selectedPhoto) {
            Task {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                    self.image = Image(uiImage: uiImage)
                    product.imageData = data
                    try? context.save()
                }
            }
        }
    }
}

//#Preview {
//    ProductImageView()
//}
