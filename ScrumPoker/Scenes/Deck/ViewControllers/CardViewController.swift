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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.close)))
    }
    
    @objc private func close() {
        viewModel.close(from: self)
    }
}
