//
//  TableRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

enum TableSectionSelectionStyle {
    case single
    case multiple
    case disable
}

enum TableRowType {
    case none
    case checkmark(Bool)
    case `switch`(Bool)
}

protocol TableRowViewModel {
    var text: String { get }
    var type: TableRowType { get }
    var isAutoDeselectable: Bool { get }
}
