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
 
 reorganize project and make sure the models and VM makes sense
 reorganize models, consider adding it into viewModel file
 fix signing
 instead of Settings, use Menu
 check TODOs
 */

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
