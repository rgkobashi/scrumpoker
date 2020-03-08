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
    static let shakeToReveal = Preference(name: "Shake to reveal", id: "shakeToReveal")
    static let vibrateOnReveal = Preference(name: "Vibrate on reveal", id: "vibrateOnReveal")
    static let disableAutoLock = Preference(name: "Disable auto-lock", id: "disableAutoLock")
}
