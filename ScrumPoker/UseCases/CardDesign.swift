//
//  CardDesign.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol CardDesign: UIView {
    func setupBorder()
}

extension CardDesign {
    func setupBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5
    }
}
