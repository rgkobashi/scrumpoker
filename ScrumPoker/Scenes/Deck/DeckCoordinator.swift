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
    
    // MARK: Coordinators
    private lazy var settingsCoordinator: SettingsCoordinator = {
        let c = SettingsCoordinator()
        c.delegate = self
        return c
    }()
    
    // MARK: Stack
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
        deckVM = DeckViewModel(deck: Card.fibonacciDeck, layout: .default)
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
    func showSettings() {
        navigationController.present(settingsCoordinator.rootViewController, animated: true, completion: nil)
    }
}

// MARK: - ViewModels callbacks

extension DeckCoordinator: DeckViewModelDelegate {
    func didTapShowSettings(from: DeckViewController) {
        showSettings()
    }
}

// MARK: - Coordinators callbacks

extension DeckCoordinator: SettingsCoordinatorDelegate {
    
}
