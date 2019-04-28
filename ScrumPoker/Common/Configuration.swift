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

class Configuration {
    private static var isInitialized = false
    
    private let sideMenuManager: SideMenuManager
    
    init(sideMenuManager: SideMenuManager = SideMenuManager.default) {
        guard !Configuration.isInitialized else {
            fatalError("Configuration should be initialized only once from AppDelegate")
        }
        Configuration.isInitialized = true
        self.sideMenuManager = sideMenuManager
    }
    
    func setFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func setSideMenu() {
        sideMenuManager.menuFadeStatusBar = false
    }
}
