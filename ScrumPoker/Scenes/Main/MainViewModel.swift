//
//  MainViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MainViewModel {
    private let deck: [Card]
    private let layout: DeckLayout
    private let screen: UIScreen
    
    var deckSize: Int {
        return deck.count
    }
    
    init(deck: [Card], layout: DeckLayout, screen: UIScreen = UIScreen.main) {
        self.deck = deck
        self.layout = layout
        self.screen = screen
    }
    
    func card(at index: Int) -> Card {
        return deck[index]
    }
    
    }
}
