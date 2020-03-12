//
//  ViewControllerAlertable.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/15.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

typealias ViewControllerAlertableAction = () -> Void

enum ViewControllerAlertableType {
    case informable(action: ViewControllerAlertableAction?)
}

protocol ViewControllerAlertable where Self: UIViewController {
    func showAlert(title: String?, message: String, type: ViewControllerAlertableType)
}

extension ViewControllerAlertable {
    
    func showAlert(title: String? = nil, message: String, type: ViewControllerAlertableType) {
        switch type {
        case let .informable(action):
            showInformableAlert(title: title, message: message, action: action)
        }
    }
    
    // MARK: Private
    
    private func showInformableAlert(title: String?, message: String, action: ViewControllerAlertableAction?) {
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertA =  UIAlertAction(title: "common.ok".localized(), style: .default) { _ in
            action?()
        }
        alertC.addAction(alertA)
        self.present(alertC, animated: true, completion: nil)
    }
}

