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
    
    var viewModel: CardViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapCardView)))
    }
    
    @objc private func tapCardView() {
        if viewModel.isCardFlipped {
            viewModel.close(from: self)
        } else {
            viewModel.flipCard()
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        viewModel.flipCardWhenShakingIfNeeded()
    }
}

extension CardViewController: CardViewModelViewDelegate {
    func flipCard(completion: @escaping () -> Void) {
        cardView.flip(completion: completion)
    }
}