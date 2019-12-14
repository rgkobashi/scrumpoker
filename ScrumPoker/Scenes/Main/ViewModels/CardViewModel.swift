//
//  CardViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

protocol CardViewModelViewDelegate: class {
    func flipCard(completion: @escaping () -> Void)
}

protocol CardViewModelDelegate: class {
    func didTapClose(from viewController: CardViewController)
}

class CardViewModel {
    private let card: Card
    private let configuration: Configuration
    private let hapticFeedbackGenerator: HapticFeedbackGenerator
    private var isShakeToRevealEnabled: Bool {
        configuration.getValue(for: .shakeToReveal)
    }
    private(set) var isCardFlipped = false
    
    weak var delegate: CardViewModelDelegate?
    weak var viewDelegate: CardViewModelViewDelegate?
    
    var cardText: String {
        return card.text
    }
    
    init(card: Card, configuration: Configuration, hapticFeedbackGenerator: HapticFeedbackGenerator) {
        self.card = card
        self.configuration = configuration
        self.hapticFeedbackGenerator = hapticFeedbackGenerator
    }
    
    func flipCard() {
        viewDelegate?.flipCard { [weak self] in
            self?.isCardFlipped = true
        }
    }
    
    func flipCardWhenShakingIfNeeded() {
        guard isShakeToRevealEnabled, !isCardFlipped else {
            return
        }
        flipCard()
    }
    
    func close(from viewController: CardViewController) {
        delegate?.didTapClose(from: viewController)
    }
}
