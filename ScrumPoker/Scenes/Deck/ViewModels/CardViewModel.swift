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
    private let configuration: Configuration
    
    weak var delegate: CardViewModelDelegate?
    
    var cardText: String {
        return card.text
    }
    
    var isShakeToRevealEnabled: Bool {
        configuration.getValue(for: .shakeToReveal)
    }
    
    init(card: Card, configuration: Configuration) {
        self.card = card
        self.configuration = configuration
    }
    
    func close(from viewController: CardViewController) {
        delegate?.didTapClose(from: viewController)
    }
}
