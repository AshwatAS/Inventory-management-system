//
//  ContentView.swift
//  final test
//
//  Created by Amit Sureka on 11/01/24.
//

import SwiftUI
import Combine
import SwiftData

struct ContentView: View {
    @State private var path=NavigationPath()
    @Query var users:[User]

    //@State private var isloginHidden = false
    
    var body: some View {
        LoginView(/*isViewHidden: isloginHidden,*/navigationpath: $path)
            .modelContainer(for: [User.self, Product.self, Order.self])
    }
}

extension ContentView {
    func loadImage(from urlString: String) -> UIImage {
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(systemName: "photo") ?? UIImage()
        }
        return image
    }
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro")
    }
}
