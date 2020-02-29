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
            switch preference.type {
            case .shakeToReveal, .shakeOnReveal:
                break // TODO update value on configuration
            case .autoLock:
                break // TODO update value on configuration
            }
        }
        get {
            switch preference.type {
            case .shakeToReveal, .shakeOnReveal:
                return true // TODO get value from configuration
            case .autoLock:
                return true // TODO get value from configuration
            }
        }
    }
}
