//
//  MainViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    
    var viewModel: MainViewModel!
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.register(CardCell.self)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCollectionView()
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
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.deckSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.card = viewModel.card(at: indexPath.row)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cardSize(for: holderView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.horizontalCardSpacing(for: holderView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.verticalCardSpacing(for: holderView)
    }
}
