//
//  SettingsCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import SideMenu

protocol SettingsCoordinatorDelegate: class {
    
}

class SettingsCoordinator {
    var rootViewController: UIViewController {
        return sideMenuNavigationController
    }
    weak var delegate: SettingsCoordinatorDelegate?
    
    private let sideMenuManager: SideMenuManager
    
    // MARK: Stack
    private lazy var sideMenuNavigationController: UISideMenuNavigationController = {
        let nc = UISideMenuNavigationController(rootViewController: settingsVC)
        sideMenuManager.menuRightNavigationController = nc
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Settings")
    private let settingsVC: SettingsViewController
    private let settingsVM: SettingsViewModel
    
    init(sideMenuManager: SideMenuManager = SideMenuManager.default) {
        self.sideMenuManager = sideMenuManager
        let settings = [SettingsSectionViewModel(title: "Deck",
                                                 rows: [SettingsRowViewModel(text: "Fibonnaci", type: .checkmark(true)),
                                                        SettingsRowViewModel(text: "Standard", type: .checkmark(false)),
                                                        SettingsRowViewModel(text: "T-shirt", type: .checkmark(true))]),
                        SettingsSectionViewModel(title: nil,
                                                 rows: [SettingsRowViewModel(text: "Sound", type: .switch(true)),
                                                        SettingsRowViewModel(text: "Shake to reveal", type: .switch(false))])]
        settingsVC = storyboard.instantiateViewController()
        settingsVM = SettingsViewModel(settings: settings)
        settingsVC.viewModel = settingsVM
    }
}
