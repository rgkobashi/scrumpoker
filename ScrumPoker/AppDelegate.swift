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
 add shake to reveal
 add feature request
 add avoid autolock
 avoid rorating device
 refiew that everything is being deallocated
 add localization, look for strings to localize
 add contribute option
 add support for custom decks
 considera layout for more than 15 elements
 check warnings
 considering adding baselines for story points and share baselines to other devices
 
 https://flawlessapp.io/blog/advanced-mvvm-tableview-tutorial/
 https://cocoacasts.com/configuring-table-views-with-model-view-viewmodel-and-protocols
 https://novemberfive.co/blog/creating-dynamic-screens-protocol-oriented-mvvm-swift
 
 fix signing
 check TODOs
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let configuration = Configuration()
    private var mainCoordinator: MainCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configuration.setFabric()
        configuration.setSideMenu()
        configuration.disableAutoLock()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(window: window!, configuration: configuration)
        mainCoordinator.start()
        
        return true
    }
}
