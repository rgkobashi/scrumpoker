//
//  MainCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

extension MainCoordinator {
    enum Error: Swift.Error {
        case invalidBrowserURL
    }
}

class MainCoordinator {
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private let window: UIWindow
    private let configuration: Configuration
    private let application: UIApplication
    
    private lazy var menuCoordinator: MenuCoordinator = {
        let c = MenuCoordinator(configuration: configuration)
        c.delegate = self
        return c
    }()
    
    private lazy var navigationController: UINavigationController = {
        let nc = UINavigationController(rootViewController: deckVC)
        return nc
    }()
    private let storyboard = UIStoryboard(name: "Main")
    private let deckVC: DeckViewController
    private let deckVM: DeckViewModel
    
    init(window: UIWindow, configuration: Configuration, application: UIApplication = .shared) {
        self.window = window
        self.configuration = configuration
        self.application = application
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

extension MainCoordinator {
    private func showMenu() {
        navigationController.present(menuCoordinator.rootViewController, animated: true, completion: nil)
    }
    
    private func showCardScreen(_ card: Card, from viewController: UIViewController) {
        let vc: CardViewController = storyboard.instantiateViewController()
        let vm = CardViewModel(card: card, configuration: configuration)
        vc.viewModel = vm
        vm.delegate = self
        viewController.present(vc, animated: true)
    }
    
    private func openBrowser(with url: URL) throws {
        guard application.canOpenURL(url) else {
            throw Error.invalidBrowserURL
        }
        application.open(url, options: [:])
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
    
    func didTapFeedback(from coordinator: MenuCoordinator) {
        
    }
    
    func didTapContribute(from coordinator: MenuCoordinator) {
        try? openBrowser(with: configuration.contributeURL)
    }
}
