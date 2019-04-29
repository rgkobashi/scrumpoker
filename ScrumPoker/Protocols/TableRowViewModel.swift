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
    case none
}

enum TableRowType {
    case checkmark(Bool)
    case `switch`(Bool)
    case action(() -> Void)
}

protocol TableRowViewModel {
    var text: String { get }
    var type: TableRowType { get }
}
