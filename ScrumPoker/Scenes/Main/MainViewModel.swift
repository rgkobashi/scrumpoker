//
//  MainViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MainViewModel {
    private var cards: [Card]
    private var deckLayout: DeckLayout
    private let screen: UIScreen
    
    var totalNumberOfCards: Int {
        return cards.count
    }
    
    init(cards: [Card], deckLayout: DeckLayout, screen: UIScreen = UIScreen.main) {
        self.cards = cards
        self.deckLayout = deckLayout
        self.screen = screen
    }
    
    func updateCards(_ cards: [Card]) {
        self.cards = cards
    }
    
    func card(at index: Int) -> Card {
        return cards[index]
    }
}
