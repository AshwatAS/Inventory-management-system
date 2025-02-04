//
//  LocalNotificationManager.swift
//  final test
//
//  Created by Amit Sureka on 03/02/24.
//

import Foundation
import NotificationCenter
class LocalNotificationManager: ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted = false
    
    func requestAuthorization() async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
        print(isGranted)
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
}
