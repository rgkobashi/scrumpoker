//
//  AppDelegate.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let configuration = Configuration()
    private var mainCoordinator: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configuration.setupFirebase()
        configuration.loadPreferences()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(window: window!, configuration: configuration)
        mainCoordinator.start()
        
        configuration.setupGlobalAppearance(from: window!)
        return true
    }
}
