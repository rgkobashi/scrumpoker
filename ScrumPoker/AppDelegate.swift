//
//  AppDelegate.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

typealias App = AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let configuration = Configuration()

    var window: UIWindow?
    private var deckCoordinator: DeckCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        App.configuration.setFabric()
        App.configuration.setSideMenu()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        deckCoordinator = DeckCoordinator(window: window!, configuration: App.configuration)
        deckCoordinator.start()
        
        return true
    }
}
