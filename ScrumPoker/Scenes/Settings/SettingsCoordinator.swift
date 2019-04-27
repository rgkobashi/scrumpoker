//
//  SettingsCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import SideMenu

class SettingsCoordinator {
    var rootViewController: UIViewController {
        return sideMenuNavigationController
    }
    
    private lazy var sideMenuNavigationController: UISideMenuNavigationController = {
        let nc = UISideMenuNavigationController(rootViewController: settingsVC)
        SideMenuManager.default.menuRightNavigationController = nc
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Settings")
    private let settingsVC: SettingsViewController
    private let settingsVM: SettingsViewModel
    
    init() {
        settingsVC = storyboard.instantiateViewController()
        settingsVM = SettingsViewModel()
        settingsVC.viewModel = settingsVM
    }
}
