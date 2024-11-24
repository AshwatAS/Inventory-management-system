//
//  final_testApp.swift
//  final test
//
//  Created by Amit Sureka on 11/01/24.
//

import SwiftUI
import SwiftData
@main
struct final_testApp: App {
    //let persistenceController = PersistenceController.shared
    let container: ModelContainer
    @StateObject var lnManager = LocalNotificationManager()
    
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        if let container = try? ModelContainer(for: User.self, Order.self, Product.self, configurations: config) {
            self.container = container
        } else {
            fatalError("Failed to initialize")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .environmentObject(lnManager)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .modelContainer(for: Product.self)
        //.modelContainer(for: Order.self)
    }
}
