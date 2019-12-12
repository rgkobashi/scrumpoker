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
    
    private let application: UIApplication
    private let bundle: Bundle
    private let sideMenuManager: SideMenuManager
    private let userDefaults: UserDefaults
    private var defaultDeck: Deck {
        return Deck.fibonacci
    }
    
    var contributeURL: URL {
        return URL(string: "https://github.com/rgkobashi/scrumpoker")!
    }
    
    init(bundle: Bundle = .main, application: UIApplication = .shared, sideMenuManager: SideMenuManager = SideMenuManager.default, userDefaults: UserDefaults = UserDefaults.standard) {
        guard !Configuration.isInitialized else {
            fatalError("Configuration should be initialized only once from AppDelegate")
        }
        Configuration.isInitialized = true
        self.bundle = bundle
        self.application = application
        self.sideMenuManager = sideMenuManager
        self.userDefaults = userDefaults
    }
    
    func setFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func setSideMenu() {
        sideMenuManager.menuFadeStatusBar = false
    }
    
    func disableAutoLock() {
        application.isIdleTimerDisabled = true
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
                fatalError("Saved deck does not exists")
            }
        }
    }
    
    func setValue(_ value: Bool, for preference: Preference<Bool>) {
        userDefaults.set(value, forKey: preference.id)
    }
    
    func getValue(for preference: Preference<Bool>) -> Bool {
        return userDefaults.bool(forKey: preference.id)
    }
}
