//
//  Preference.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/30.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct Preference<T>: Equatable {
    let name: String
    let id: String
}

extension Preference where T == Bool {
    static let shakeToReveal = Preference(name: "preference.shakeToReveal".localized(), id: "shakeToReveal")
    static let vibrateOnReveal = Preference(name: "preference.vibrateOnReveal".localized(), id: "vibrateOnReveal")
    static let disableAutoLock = Preference(name: "preference.disableAutoLock".localized(), id: "disableAutoLock")
}
