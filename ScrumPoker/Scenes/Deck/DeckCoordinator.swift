//
//  DeckCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class DeckCoordinator {
    
    private let window: UIWindow!
    private lazy var rootViewController: UIViewController = {
        let nc = UINavigationController(rootViewController: deckVC)
        return nc
    }()
    
    private let storyboard = UIStoryboard(name: "Deck")
    private let deckVC: DeckViewController
    private let deckVM: DeckViewModel
    
    init(window: UIWindow) {
        self.window = window
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

extension DeckCoordinator: DeckViewModelDelegate {
    func didTapShowSettings(from: DeckViewController) {
        
    }
}
