//
//  CardViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

protocol CardViewModelDelegate: class {
    func didTapClose(from viewController: CardViewController)
}

class CardViewModel {
    private let card: Card
    
    weak var delegate: CardViewModelDelegate?
    
    var cardText: String {
        return card.text
    }
    
    init(card: Card) {
        self.card = card
    }
    
    func close(from viewController: CardViewController) {
        delegate?.didTapClose(from: viewController)
    }
}
