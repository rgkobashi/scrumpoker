//
//  PreferenceModelController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2020/02/29.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

import Foundation

struct PreferenceModelController<T> {
    let preference: Preference<T>
    let configuration: Configuration
}

extension PreferenceModelController where T == Bool {
    var isEnable: Bool {
        set {
            configuration.setValue(newValue, for: preference)
        }
        get {
            return configuration.getValue(for: preference)
        }
    }
}
