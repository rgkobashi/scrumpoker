//
//  CardFrontDesignView.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/09.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class CardFrontDesignView: UIView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    init(text: String, frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        self.textLabel.text = text
    }
    
    override init(frame: CGRect) {
        fatalError("CardFrontDesignView should be initialized by calling init(text:frame:)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("CardFrontDesignView should be initialized by calling init(text:frame:)")
    }
}

extension CardFrontDesignView: NibLoadableView {}
