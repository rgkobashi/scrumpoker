//
//  DeckViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit
import Reusable

class DeckViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main")
    
    @IBOutlet weak var holderView: UIView!
    
    var viewModel: DeckViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(cellType: CardCell.self)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle()
        setupNavigationBar()
        layoutCollectionView()
    }
    
    private func updateTitle() {
        self.title = viewModel.deckName
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = {
            if #available(iOS 13.0, *) {
                return UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(self.showMenu))
            } else {
                return UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: .plain, target: self, action: #selector(self.showMenu))
            }
        }()
    }
    
    private func layoutCollectionView() {
        holderView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalC = NSLayoutConstraint(item: collectionView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: holderView,
                                             attribute: .centerX,
                                             multiplier: 1,
                                             constant: 0)
        let verticalC = NSLayoutConstraint(item: collectionView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: holderView,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 0)
        let widthC = NSLayoutConstraint(item: collectionView,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: holderView,
                                        attribute: .width,
                                        multiplier: viewModel.deckWidthMultiplier,
                                        constant: 0)
        let heightC = NSLayoutConstraint(item: collectionView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: holderView,
                                         attribute: .height,
                                         multiplier: viewModel.deckHeightMultiplier,
                                         constant: 0)
        holderView.addConstraints([horizontalC, verticalC, widthC, heightC])
    }
    
    @objc private func showMenu() {
        viewModel.showMenu(from: self)
    }
}

extension DeckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.deckSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.card = viewModel.card(at: indexPath.row)
        return cell
    }
}

extension DeckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cardSize(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.horizontalCardSpacing(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.verticalCardSpacing(for: collectionView)
    }
}

extension DeckViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = viewModel.card(at: indexPath.row)
        viewModel.showCard(card, from: self)
    }
}

extension DeckViewController: DeckViewModelViewDelegate {
    func didUpdateDeck() {
        updateTitle()
        collectionView.reloadData()
    }
}
