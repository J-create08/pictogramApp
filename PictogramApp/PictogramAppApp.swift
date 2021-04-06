//
//  PictogramAppApp.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 25/3/21.
//

import SwiftUI
import Firebase

@main
struct PictogramAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase done")
        return true
    }
}
