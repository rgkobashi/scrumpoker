//
//  Deck.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct Deck: Equatable {
    let id: String
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
        return Deck(id: "fibonacci", name: "Fibonacci", cards: cards)
    }
    
    static var standar: Deck {
        let cards = ["0", "½", "1", "2", "3", "5", "8", "13", "20", "40", "90", "100"]
            .map(Card.init) + extraCards
        return Deck(id: "standar", name: "Standar", cards: cards)
    }
    
    // MARK: Private

    private static var extraCards: [Card] {
        let values = ["?","∞","☕️"]
        return values.map(Card.init)
    }
}

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

private extension Collection where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var array: [Element] = []
        return self.compactMap {
            if array.contains($0) {
                return nil
            } else {
                array.append($0)
                return $0
            }
        }
    }
}