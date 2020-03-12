//
//  String.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2020/03/12.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
}
