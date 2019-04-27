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
    private var rootViewController: UIViewController {
        return mainVC
    }
    
    private let storyboard = UIStoryboard(name: "Main")
    private let mainVC: MainViewController
    private let mainVM: MainViewModel
    
    init(window: UIWindow) {
        self.window = window
        mainVC = storyboard.instantiateViewController()
        mainVM = MainViewModel()
        mainVC.viewModel = mainVM
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
