//
//  Configuration.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import SideMenu
import Firebase

private enum UserDefaultsKey: String {
    case selectedDeckName
}

class Configuration {
    private let application: ApplicationType
    private let userDefaults: UserDefaults
    private let firebaseApp: FirebaseApp.Type
    private let sideMenuManager: SideMenuManager
    private var screenSize: CGSize {
        guard let kw = application.keyWindow else {
            fatalError("application does not have keyWindow")
        }
        return kw.screen.bounds.size
    }
    private var defaultDeck: Deck {
        return Deck.fibonacci
    }
    
    var statusBarAlpha: CGFloat {
        return 0.0
    }
    var menuWidth: CGFloat {
        return screenSize.width * 0.60
    }
    
    init(application: ApplicationType = UIApplication.shared, userDefaults: UserDefaults = .standard, firebaseApp: FirebaseApp.Type = FirebaseApp.self, sideMenuManager: SideMenuManager = .default) {
        self.application = application
        self.sideMenuManager = sideMenuManager
        self.userDefaults = userDefaults
        self.firebaseApp = firebaseApp   
    }
    
    func setupFirebase() {
        firebaseApp.configure()
    }
    
    func loadPreferences() {
        application.isIdleTimerDisabled = getValue(for: .disableAutoLock)
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
        handlePreferenceBool(preference, with: value)
    }
    
    func getValue(for preference: Preference<Bool>) -> Bool {
        return userDefaults.bool(forKey: preference.id)
    }
    
    private func handlePreferenceBool(_ preference: Preference<Bool>, with value: Bool) {
        if preference == .disableAutoLock {
            application.isIdleTimerDisabled = value
        }
    }
}

// MARK:

extension UIApplication: ApplicationType {}
