//
//  CardViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

class CardViewModel {
    private let card: Card
    
    var cardText: String {
        return card.text
    }
    
    init(card: Card) {
        self.card = card
    }
}
