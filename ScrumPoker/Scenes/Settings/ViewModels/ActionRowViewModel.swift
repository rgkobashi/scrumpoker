//
//  ActionRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct ActionRowViewModel: TableRowViewModel {
    let text: String
    let action: () -> ()
    
    var type: TableRowType {
        return .unspecified
    }
}
