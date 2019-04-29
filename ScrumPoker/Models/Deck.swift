//
//  Deck.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct Deck {
    let name: String
    let cards: [Card]
}

extension Deck {
    static var fibonacci: Deck {
        let n = 12
        let cards = generateFibonacci(n+1)
            .removeDuplicates()
            .map(String.init)
            .map(Card.init) + extraCards
        return Deck(name: "Fibonacci", cards: cards)
    }
    
    // MAR: Private
    
    private static var extraCards: [Card] {
        let values = ["?","∞","☕️"]
        return values.map(Card.init)
    }
}

// MARK: -

private func generateFibonacci(_ n: Int) -> [Int] {
    guard n > 1 else {
        fatalError("n should be greater than 1")
    }
    var array = [0, 1]
    while array.count < n {
        array.append(array[array.count - 1] + array[array.count - 2])
    }
    return array
}
