//
//  PreferenceRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct PreferenceRowViewModel: TableRowViewModel {
    let preference: Preference<Bool>
    let configuration: Configuration
    
    var text: String {
        return preference.name
    }
    var type: TableRowType {
        let isSelected = configuration.getValue(for: preference)
        return .switch(isSelected)
    }
}
