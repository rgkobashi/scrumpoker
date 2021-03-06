//
//  CardViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit
import Reusable

class CardViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main")
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            if #available(iOS 13.0, *) {
                closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            } else {
                closeButton.setImage(#imageLiteral(resourceName: "closeIcon"), for: .normal)
            }
            closeButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        }
    }
    @IBOutlet weak var cardView: CardView! {
        didSet {
            cardView.setup(card: viewModel.card, initialSide: .back)
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
        self.view.accessibilityIdentifier = "CardViewController.view"
    }
    
    @objc private func tapCardView() {
        if viewModel.isCardFlipped {
            close()
        } else {
            viewModel.flipCard()
        }
    }
    
    @objc private func close() {
        viewModel.close(from: self)
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
