//
//  CardBackDesignView.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/10.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit
import Reusable

class CardBackDesignView: UIView, NibOwnerLoadable {
    @IBOutlet weak var helperView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.loadNibContent()
        setupBorder()
        helperView.layer.cornerRadius = 5
    }
}

extension CardBackDesignView: CardDesign {}
