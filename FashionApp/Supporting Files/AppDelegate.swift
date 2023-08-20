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
        let key = "LZOQlP9PH7DpzZqHddm86KYHFSMr6ZO+Q5AFIHPacQhHPSGCcSQPy+79Uf9UqzgqocRmm9c+ijbYjxUq0mDFHoteXj8fbjQzP/woOe9IIoaRB2XfvPopoLmVl8AepUJ9NnAIelcCsB3cop3/Tgf5UIJu37K+rMmDUhGNCl0dvFA="
        let secret = "mG0c3O3Mzeu5dkZJW3gpql8+jBucojBtBSjI3YJz2gDX71SsU8BGXkyVVMfiSLDXkA3OINaisXidbk+LaYGLWWkdpKoziVtBdrJ4u/HoqZlhrp9sGpqfp0B228KI+IMTu4aGVjtYuk+Uxs/kosIBw93X8SHDFCyvJ+qFKnTEkm/0cldTJDmVDtLY8IhR1UfN"
        
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

