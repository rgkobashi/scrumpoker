//
//  MainCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MainCoordinator {
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
    private let deckVC: DeckViewController
    private let deckVM: DeckViewModel
    
    init(window: UIWindow, configuration: Configuration) {
        self.window = window
        self.configuration = configuration
        deckVC = DeckViewController.instantiate()
        deckVM = DeckViewModel(deck: configuration.selectedDeck)
        deckVM.delegate = self
        deckVC.viewModel = deckVM
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - Navigation

extension MainCoordinator {
    private func showMenu() {
        navigationController.present(menuCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    private func showCardScreen(_ card: Card, from viewController: UIViewController) {
        let vc = CardViewController.instantiate()
        let vm = CardViewModel(card: card,
                               configuration: configuration,
                               hapticFeedbackGenerator: HapticFeedbackGenerator())
        vc.viewModel = vm
        vm.delegate = self
        viewController.present(vc, animated: true)
    }
}

// MARK: - ViewModels callbacks

extension MainCoordinator: DeckViewModelDelegate {
    func didTapShowMenu(from viewController: DeckViewController) {
        showMenu()
    }
    
    func didTapShowCard(_ card: Card, from viewController: DeckViewController) {
        showCardScreen(card, from: viewController)
    }
}

extension MainCoordinator: CardViewModelDelegate {
    func didTapClose(from viewController: CardViewController) {
        viewController.dismiss(animated: true)
    }
}

// MARK: - Coordinators callbacks

extension MainCoordinator: MenuCoordinatorDelegate {
    func didUpdateDeck(_ deck: Deck, from coordinator: MenuCoordinator) {
        deckVM.updateDeck(deck)
    }
}
