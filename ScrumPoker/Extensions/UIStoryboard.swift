//
//  UIStoryboard.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    convenience init(name: String) {
        self.init(name: name, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Could not instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}
