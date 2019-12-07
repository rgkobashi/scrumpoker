//
//  DeckViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol DeckViewModelDelegate: class {
    func didTapShowMenu(from: DeckViewController)
}

class DeckViewModel {
    private let deck: Deck
    private let layout: DeckLayout
    
    weak var delegate: DeckViewModelDelegate?
    
    init(deck: Deck, layout: DeckLayout) {
        self.deck = deck
        self.layout = layout
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
        return 1 - layout.horizontalDeckPadding
    }
    
    var deckHeightMultiplier: CGFloat {
        return 1 - layout.verticalDeckPadding
    }
    
    func cardSize(for parentView: UIView) -> CGSize {
        let w = parentView.frame.width * layout.cardWidth
        let h = parentView.frame.height * layout.cardHeight
        return CGSize(width: w, height: h)
    }
    
    func horizontalCardSpacing(for parentView: UIView) -> CGFloat {
        return parentView.frame.width * layout.horizontalCardSpacing
    }
    
    func verticalCardSpacing(for parentView: UIView) -> CGFloat {
        return parentView.frame.height * layout.verticalCardSpacing
    }
    
    // MARK: Navigation
    
    func showMenu(from viewController: DeckViewController) {
        delegate?.didTapShowMenu(from: viewController)
    }
}
