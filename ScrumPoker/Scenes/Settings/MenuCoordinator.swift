//
//  MenuCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import SideMenu

protocol MenuCoordinatorDelegate: class {
    
}

class MenuCoordinator {
    var rootViewController: UIViewController {
        return sideMenuNavigationController
    }
    weak var delegate: MenuCoordinatorDelegate?
    
    private let sideMenuManager: SideMenuManager
    private lazy var sideMenuNavigationController: UISideMenuNavigationController = {
        let nc = UISideMenuNavigationController(rootViewController: settingsVC)
        sideMenuManager.menuRightNavigationController = nc
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Settings")
    private let settingsVC: SettingsViewController
    private let settingsVM: SettingsViewModel
    
    init(sideMenuManager: SideMenuManager = SideMenuManager.default, configuration: Configuration) {
        self.sideMenuManager = sideMenuManager
        settingsVC = storyboard.instantiateViewController()
        settingsVM = SettingsViewModel(configuration: configuration)
        settingsVM.delegate = self
        settingsVC.viewModel = settingsVM
    }
}

extension MenuCoordinator: SettingsViewModelDelegate {
    func didTapFeedback(from viewController: SettingsViewController) {
        
    }
}
