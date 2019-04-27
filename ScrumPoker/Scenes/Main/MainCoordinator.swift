//
//  MainCoordinator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MainCoordinator {
    
    private let window: UIWindow!
    private lazy var rootViewController: UIViewController = {
        let nc = UINavigationController(rootViewController: mainVC)
        return nc
    }()
    
    private let storyboard = UIStoryboard(name: "Main")
    private let mainVC: MainViewController
    private let mainVM: MainViewModel
    
    init(window: UIWindow) {
        self.window = window
        mainVC = storyboard.instantiateViewController()
        mainVM = MainViewModel(deck: Card.fibonacciDeck, layout: .default)
        mainVC.viewModel = mainVM
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
