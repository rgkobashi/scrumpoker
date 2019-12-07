//
//  TableRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

protocol TableRowViewModel {
    var text: String { get }
    var type: TableRowType { get }
}

enum TableRowType {
    case checkmark(Bool)
    case `switch`(Bool)
    case unspecified //TODO: change this to an icon according to the action, for example an icon to open external thing
}
