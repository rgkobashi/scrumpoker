//
//  ActionRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

struct ActionRowViewModel<T>: TableRowViewModel {
    let text: String
    let image: UIImage?
    let action: (T) -> ()
    
    var type: TableRowType {
        return .unspecified(image)
    }
}
