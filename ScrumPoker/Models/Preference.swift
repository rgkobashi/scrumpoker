//
//  Preference.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/30.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct Preference<T> {
    let name: String
    let id: String
}

extension Preference {
    static var shakeToReveal: Preference<Bool> {
        return Preference<Bool>(name: "Shake to reveal", id: "shakeToReveal")
    }

    static var shakeOnReveal: Preference<Bool> {
        return Preference<Bool>(name: "Shake on reveal", id: "shakeOnReveal")
    }
}
