//
//  MainViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

class MainViewModel {
    private var cards: [Card]
    
    var totalNumberOfCards: Int {
        return cards.count
    }
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func updateCards(_ cards: [Card]) {
        self.cards = cards
    }
    
    func card(at index: Int) -> Card {
        return cards[index]
    }
}
