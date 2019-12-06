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
    
    var isSelected: Bool {
        return configuration.getValue(for: preference)
    }
    var text: String {
        return preference.name
    }
    var type: TableRowType {
        return .switch(isSelected)
    }
    
    func didSelect() {
        configuration.setValue(!isSelected, for: preference)
    }
}
