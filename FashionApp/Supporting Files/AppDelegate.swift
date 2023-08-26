//
//  AppDelegate.swift
//  FashionApp
//
//  Created by Krasivo on 04.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let key = "UOXTifzXaYqdiMMJ1dYKAFQI6jkFAJqGFnKQvQ449ZmpPmvddkLYh2+0E/OO9cfhA6mRlFl4VT0hb4Ck/75VF0BiT2zWwoPUNDmicCV0HMGG24DMOy/3+ztNsMQTVywzoalIdfEi0ElEj5162EpVSJr3PSb8n+sN2kQzrdCIG/U="
        let secret = "mG0c3O3Mzeu5dkZJW3gpql8+jBucojBtBSjI3YJz2gD2+npCHPsRIaudygv4mh5sYO/ySqSv6AUgTZsNIoAsL6pnTt6NY7gprvL71PkpglJhrp9sGpqfp0B228KI+IMTu4aGVjtYuk+Uxs/kosIBw93X8SHDFCyvJ+qFKnTEkm/0cldTJDmVDtLY8IhR1UfN"
        CDrawKit.setLicenseKey(key, secret: secret)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

