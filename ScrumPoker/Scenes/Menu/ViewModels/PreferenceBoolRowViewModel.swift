//
//  PreferenceBoolRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct PreferenceBoolRowViewModel: TableRowViewModel {
    let preference: Preference<Bool>
    let configuration: Configuration
    
    var text: String {
        return preference.name
    }
    var type: TableRowType {
        return .switch(isEnable)
    }
    
    var isEnable: Bool {
        set {
            configuration.setValue(newValue, for: preference)
        }
        get {
            return configuration.getValue(for: preference)
        }
    }
}
