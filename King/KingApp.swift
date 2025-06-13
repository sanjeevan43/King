//
//  KingApp.swift
//  King
//
//  Created by sanjeevan on 13/06/25.
//

import SwiftUI

@main
struct KingApp: App {
    @AppStorage("isUserLoggedIn") var isUserLoggedIn = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            InitialView()
                .onAppear {
                    print("User logged in:", isUserLoggedIn)
                }
        }
    }}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        MobileAds.shared.start(completionHandler: nil)
        return true
    }
}
