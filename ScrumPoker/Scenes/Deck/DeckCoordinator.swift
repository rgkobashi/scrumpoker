//
//  DeckCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class DeckCoordinator {
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private let window: UIWindow
    private let configuration: Configuration
    
    private lazy var menuCoordinator: MenuCoordinator = {
        let c = MenuCoordinator(configuration: configuration)
        c.delegate = self
        return c
    }()
    
    private lazy var navigationController: UINavigationController = {
        let nc = UINavigationController(rootViewController: deckVC)
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Deck")
    private let deckVC: DeckViewController
    private let deckVM: DeckViewModel
    
    init(window: UIWindow, configuration: Configuration) {
        self.window = window
        self.configuration = configuration
        deckVC = storyboard.instantiateViewController()
        deckVM = DeckViewModel(deck: configuration.selectedDeck, layout: .default)
        deckVM.delegate = self
        deckVC.viewModel = deckVM
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - Navigation

extension DeckCoordinator {
    func showMenu() {
        navigationController.present(menuCoordinator.rootViewController, animated: true, completion: nil)
    }
}

// MARK: - ViewModels callbacks

extension DeckCoordinator: DeckViewModelDelegate {
    func didTapShowMenu(from: DeckViewController) {
        showMenu()
    }
}

// MARK: - Coordinators callbacks

extension DeckCoordinator: MenuCoordinatorDelegate {
    
}
