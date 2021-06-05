//
//  AppDelegate.swift
//
//

import UIKit
import Firebase
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.register(defaults: ["isFirstLinking": true])
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "startAppRefresh",
            using: nil
        ) { task in
            StorageManager.instance.startAppRefresh(task as! BGAppRefreshTask)
        }
        
        UserDefaults.standard.register(defaults: ["isFirstLaunch": true])
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if isFirstLaunch {
            UserDefaults.standard.set(Date(), forKey: "lastFetchUpdate")
            UserDefaults.standard.set(false, forKey: "isFirstLaunch")
        }
        
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

