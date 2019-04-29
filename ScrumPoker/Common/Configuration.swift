//
//  Configuration.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Fabric
import Crashlytics
import SideMenu

private enum UserDefaultsKey: String {
    case selectedDeckName
}

class Configuration {
    private static var isInitialized = false
    
    private let sideMenuManager: SideMenuManager
    private let userDefaults: UserDefaults
    private var defaultDeck: Deck {
        return Deck.fibonacci
    }
    
    init(sideMenuManager: SideMenuManager = SideMenuManager.default, userDefaults: UserDefaults = UserDefaults.standard) {
        guard !Configuration.isInitialized else {
            fatalError("Configuration should be initialized only once from AppDelegate")
        }
        Configuration.isInitialized = true
        self.sideMenuManager = sideMenuManager
        self.userDefaults = userDefaults
    }
    
    func setFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func setSideMenu() {
        sideMenuManager.menuFadeStatusBar = false
    }
    
    // MARK: -
    
    // TODO avoid reading userDefaults everytime selectedDeck is called
    var selectedDeck: Deck {
        set {
            userDefaults.set(newValue.name, forKey: UserDefaultsKey.selectedDeckName.rawValue)
        }
        get {
            let savedDeckName = userDefaults.string(forKey: UserDefaultsKey.selectedDeckName.rawValue)
            switch savedDeckName {
            case nil:
                return defaultDeck
            case Deck.fibonacci.name:
                return .fibonacci
            case Deck.standar.name:
                return .standar
            default:
                // return custom deck from DB
                fatalError("Saved deck does not exists")
            }
        }
    }
}
