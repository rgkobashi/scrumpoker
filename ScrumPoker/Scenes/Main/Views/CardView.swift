//
//  CardView.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/10.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol CardDesign: UIView {}
extension CardFrontDesignView: CardDesign {}
extension CardBackDesignView: CardDesign {}

extension CardView {
    enum Side {
        case front
        case back
    }
}

class CardView: UIView {
    
    private var cardDesigns: (front: CardDesign, back: CardDesign)!
    
    func setup(card: Card, initialSide: Side) {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        cardDesigns = (front: CardFrontDesignView(text: card.text, frame: frame),
                       back: CardBackDesignView(frame: frame))
        switch initialSide {
        case .front:
            self.addSubview(cardDesigns.front)
        case .back:
            self.addSubview(cardDesigns.back)
        }
    }
    
    func flip(completion: @escaping () -> Void) {
        guard cardDesigns != nil else {
            fatalError("CardView not properly set up, call setup(with:) before calling flip()")
        }
        if cardDesigns.back.superview == nil {
            cardDesigns = (front: cardDesigns.back, back: cardDesigns.front)
        } else {
            cardDesigns = (front: cardDesigns.front, back: cardDesigns.back)
        }
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.cardDesigns.back.removeFromSuperview()
            self.addSubview(self.cardDesigns.front)
        }, completion: { _ in completion() } )
    }
}
