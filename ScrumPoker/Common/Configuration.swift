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
    private var defaultDeckName: String {
        return Deck.fibonacci.name
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
    
    private var _selectedDeckName: String?
    var selectedDeckName: String {
        set {
            _selectedDeckName = newValue
            userDefaults.set(newValue, forKey: UserDefaultsKey.selectedDeckName.rawValue)
        }
        get {
            if let s = _selectedDeckName {
                return s
            }
            _selectedDeckName = userDefaults.string(forKey: UserDefaultsKey.selectedDeckName.rawValue) ?? defaultDeckName
            return _selectedDeckName!
        }
    }
}
