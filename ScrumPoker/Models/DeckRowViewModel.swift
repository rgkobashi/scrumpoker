//
//  DeckRowViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct DeckRowViewModel: TableRowViewModel {
    let deck: Deck
    let configuration: Configuration
    
    var text: String {
        return deck.name
    }
    var type: TableRowType {
        return .checkmark(configuration.selectedDeck == deck)
    }
    
    func didSelect() {
        configuration.selectedDeck = deck
    }
}
