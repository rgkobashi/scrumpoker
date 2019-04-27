//
//  DeckLayout.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

struct DeckLayout {
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    let horizontalCardSpacing: CGFloat
    let verticalCardSpacing: CGFloat
    
    let horizontalDeckPadding: CGFloat
    let verticalDeckPadding: CGFloat
}

extension DeckLayout {
    static let `default` = DeckLayout(cardWidth: 0.20,
                                      cardHeight: 0.15,
                                      horizontalCardSpacing: 0.06,
                                      verticalCardSpacing: 0.04,
                                      horizontalDeckPadding: 27,
                                      verticalDeckPadding: 8)
}
