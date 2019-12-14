//
//  DeckLayout.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

/// For a layout that does not require scrolling use the listed formulas:
/// - (cardWidth * X) + (horizontalCardSpacing * (X-1)) = 1
/// - (cardHeight * Y) + (verticalCardSpacing * (Y-1)) = 1
///
/// Where `X` is the number of cards per row and `Y` number of cards per column.
struct DeckLayout {
    /// Percentage of card containerView width to use for card width expressed from 0 to 1.
    let cardWidth: CGFloat
    /// Percentage of card containerView height to use for card height expressed from 0 to 1.
    let cardHeight: CGFloat
    
    /// Percentage of card containerView width to use for horizontal card spacing expressed from 0 to 1.
    let horizontalCardSpacing: CGFloat
    /// Percentage of card containerView height to use for vertical card spacing expressed from 0 to 1.
    let verticalCardSpacing: CGFloat
    
    /// Percentage of deck containerView width to use for horizontal deck padding expressed from 0 to 1.
    let horizontalDeckPadding: CGFloat
    /// Percentage of deck containerView height to use for vertical deck padding expressed from 0 to 1.
    let verticalDeckPadding: CGFloat
}

extension DeckLayout {
    /// Layout for 3 cards per row and 5 per column without the need of scrolling.
    static let `default` = DeckLayout(cardWidth: 0.28,
                                      cardHeight: 0.166,
                                      horizontalCardSpacing: 0.08,
                                      verticalCardSpacing: 0.0425,
                                      horizontalDeckPadding: 0.15,
                                      verticalDeckPadding: 0.1)
}
