//
//  RowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

enum RowType {
    case none
    case checkmark
    case `switch`
}

protocol RowViewModel {
    var text: String { get }
    var type: RowType { get }
}
