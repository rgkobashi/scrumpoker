//
//  CardBackDesignView.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/10.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class CardBackDesignView: UIView {
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
        setupFromNib()
        setupBorder()
        helperView.layer.cornerRadius = 5
    }
}

extension CardBackDesignView: NibLoadableView {}
extension CardBackDesignView: CardDesign {}
