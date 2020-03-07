//
//  CardFrontDesignView.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/09.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit
import Reusable

class CardFrontDesignView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var textLabel: UILabel!
    
    init(text: String, frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
        setupBorder()
        setupLabel(with: text)
        self.accessibilityIdentifier = "CardFrontView-\(text)"
    }
    
    override init(frame: CGRect) {
        fatalError("CardFrontDesignView should be initialized by calling init(text:frame:)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("CardFrontDesignView should be initialized by calling init(text:frame:)")
    }
    
    private func setupLabel(with text: String) {
        self.textLabel.text = text
        self.textLabel.font = .systemFont(ofSize: 500) // making it really big to be resized later and fill the whole view
        self.textLabel.numberOfLines = 0
        self.textLabel.adjustsFontSizeToFitWidth = true
    }
}

extension CardFrontDesignView: CardDesign {}
