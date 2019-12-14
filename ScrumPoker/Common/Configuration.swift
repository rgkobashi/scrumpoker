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
    private let application: UIApplication
    private let userDefaults: UserDefaults
    private let sideMenuManager: SideMenuManager
    private var defaultDeck: Deck {
        return Deck.fibonacci
    }
    
    init(application: UIApplication = .shared, userDefaults: UserDefaults = .standard, sideMenuManager: SideMenuManager = .default) {
        self.application = application
        self.sideMenuManager = sideMenuManager
        self.userDefaults = userDefaults
    }
    
    func setupFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func setupSideMenu(from window: UIWindow) {
        sideMenuManager.menuFadeStatusBar = false
        sideMenuManager.menuWidth = window.screen.bounds.size.width * 0.60
    }
    
    func disableAutoLock() {
        application.isIdleTimerDisabled = true
    }
    
    func setupGlobalAppearance(from window: UIWindow) {
        window.tintColor = .black
    }
}

// MARK: - Settings

extension Configuration {
    var selectedDeck: Deck { // TODO avoid reading userDefaults everytime selectedDeck is called
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
