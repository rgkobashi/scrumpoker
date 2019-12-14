//
//  AppDelegate.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

/* TODO
 run lincenceplist
 refiew that everything is being deallocated
 add localization, look for strings to localize
 test that the layout is correct when it is less than 15 elements
 check warnings
 see if we can fully follow the architecture
 fix signing
 check TODOs
 add tests
 add analytics
 add linter
 add to share app
 
 https://flawlessapp.io/blog/advanced-mvvm-tableview-tutorial/
 https://cocoacasts.com/configuring-table-views-with-model-view-viewmodel-and-protocols
 https://novemberfive.co/blog/creating-dynamic-screens-protocol-oriented-mvvm-swift
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let configuration = Configuration()
    private var mainCoordinator: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configuration.setupFabric()
        configuration.disableAutoLock()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(window: window!, configuration: configuration)
        mainCoordinator.start()
        
        configuration.setupSideMenu(from: window!)
        configuration.setupGlobalAppearance(from: window!)
        return true
    }
}
