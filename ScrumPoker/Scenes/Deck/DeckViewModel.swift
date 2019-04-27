//
//  DeckViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol DeckViewModelDelegate: class {
    func didTapShowSettings(from: DeckViewController)
}

class DeckViewModel {
    private let deck: [Card]
    private let layout: DeckLayout
    private let screen: UIScreen
    
    weak var delegate: DeckViewModelDelegate?
    
    var deckSize: Int {
        return deck.count
    }
    
    var deckWidthMultiplier: CGFloat {
        return 1 - layout.horizontalDeckPadding
    }
    
    var deckHeightMultiplier: CGFloat {
        return 1 - layout.verticalDeckPadding
    }
    
    init(deck: [Card], layout: DeckLayout, screen: UIScreen = UIScreen.main) {
        self.deck = deck
        self.layout = layout
        self.screen = screen
    }
    
    func card(at index: Int) -> Card {
        return deck[index]
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
    
    func showSettings(from viewController: DeckViewController) {
        delegate?.didTapShowSettings(from: viewController)
    }
}
