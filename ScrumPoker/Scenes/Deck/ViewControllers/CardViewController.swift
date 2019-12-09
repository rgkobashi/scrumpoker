//
//  CardViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView! {
        didSet {
            cardView.setup(with: viewModel.cardText)
        }
    }
    
    var viewModel: CardViewModel!
    
    private var isCardFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapCardView)))
    }
    
    @objc private func tapCardView() {
        if isCardFlipped {
            viewModel.close(from: self)
            return
        }
        cardView.flip { [weak self] in
            self?.isCardFlipped = true
        }
    }
}
