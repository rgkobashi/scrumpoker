//
//  MenuCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import SideMenu

protocol MenuCoordinatorDelegate: class {
    func didUpdateDeck(_ deck: Deck, from coordinator: MenuCoordinator)
}

class MenuCoordinator {
    var rootViewController: UIViewController {
        return sideMenuNavigationController
    }
    weak var delegate: MenuCoordinatorDelegate?
    
    private let sideMenuManager: SideMenuManager
    private lazy var sideMenuNavigationController: UISideMenuNavigationController = {
        let nc = UISideMenuNavigationController(rootViewController: menuVC)
        sideMenuManager.menuRightNavigationController = nc
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Menu")
    private let menuVC: MenuViewController
    private let menuVM: MenuViewModel
    
    init(sideMenuManager: SideMenuManager = SideMenuManager.default, configuration: Configuration) {
        self.sideMenuManager = sideMenuManager
        menuVC = storyboard.instantiateViewController()
        menuVM = MenuViewModel(configuration: configuration)
        menuVM.delegate = self
        menuVC.viewModel = menuVM
    }
}

extension MenuCoordinator: MenuViewModelDelegate {
    func didUpdateDeck(_ deck: Deck, from viewController: MenuViewController) {
        delegate?.didUpdateDeck(deck, from: self)
    }
    
    func didTapFeedback(from viewController: MenuViewController) {
        
    }
    
    func didTapContribute(from viewController: MenuViewController) {
        
    }
}
