//
//  DeckViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol DeckViewModelViewDelegate: class {
    func didUpdateDeck()
}

protocol DeckViewModelDelegate: class {
    func didTapShowMenu(from viewController: DeckViewController)
    func didTapShowCard(_ card: Card, from viewController: DeckViewController)
}

class DeckViewModel {
    private var deck: Deck
    
    weak var delegate: DeckViewModelDelegate?
    weak var viewDelegate: DeckViewModelViewDelegate?
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    func updateDeck(_ deck: Deck) {
        self.deck = deck
        viewDelegate?.didUpdateDeck()
    }
    
    // MARK: Data source
    
    var deckName: String {
        return deck.name
    }
    
    var deckSize: Int {
        return deck.cards.count
    }
    
    func card(at index: Int) -> Card {
        return deck.cards[index]
    }
    
    // MARK: Layout
    
    var deckWidthMultiplier: CGFloat {
        return 1 - deck.layout.horizontalDeckPadding
    }
    
    var deckHeightMultiplier: CGFloat {
        return 1 - deck.layout.verticalDeckPadding
    }
    
    func cardSize(for parentView: UIView) -> CGSize {
        let w = parentView.frame.width * deck.layout.cardWidth
        let h = parentView.frame.height * deck.layout.cardHeight
        return CGSize(width: w, height: h)
    }
    
    func horizontalCardSpacing(for parentView: UIView) -> CGFloat {
        return parentView.frame.width * deck.layout.horizontalCardSpacing
    }
    
    func verticalCardSpacing(for parentView: UIView) -> CGFloat {
        return parentView.frame.height * deck.layout.verticalCardSpacing
    }
    
    // MARK: Navigation
    
    func showMenu(from viewController: DeckViewController) {
        delegate?.didTapShowMenu(from: viewController)
    }
    
    func showCard(_ card: Card, from viewController: DeckViewController) {
        delegate?.didTapShowCard(card, from: viewController)
    }
}
