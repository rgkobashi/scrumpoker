//
//  CardCell.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var card: Card! {
        didSet {
            textLabel.text = card.text
        }
    }
}

extension CardCell: NibLoadableView {}
