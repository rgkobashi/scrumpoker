//
//  ApplicationType.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2020/03/05.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

import UIKit

protocol ApplicationType: class {
    var keyWindow: UIWindow? { get }
    var isIdleTimerDisabled: Bool { get set }
}
