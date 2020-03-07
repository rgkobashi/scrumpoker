//
//  DeckViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/07.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class DeckViewModelSpec: QuickSpec {
    override func spec() {
        var initialDeck: Deck!
        var initiaLayout: DeckLayout!
        var viewDelegate: DoubleViewDelegate!
        var delegate: DoubleDelegate!
        var sut: DeckViewModel!
        
        beforeEach {
            let initialCards = (0..<5).map { Card(text: String($0)) }
            initialDeck = Deck(id: "initialDeck", name: "initial deck", cards: initialCards)
            initiaLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: 0)
            viewDelegate = DoubleViewDelegate()
            delegate = DoubleDelegate()
        }
        
        describe("updateDeck") {
            beforeEach {
                sut = DeckViewModel(deck: initialDeck, layout: initiaLayout)
            }
            it("updates deck") {
                let newCards = (10..<15).map { Card(text: String($0)) }
                let newDeck = Deck(id: "newDeck", name: "new deck", cards: newCards)
                sut.updateDeck(newDeck)
                
                expect(sut.deckName) == newDeck.name
                expect(sut.deckSize) == newDeck.cards.count
                expect {
                    newDeck.cards.enumerated().allSatisfy { (i, card) -> Bool in
                        sut.card(at: i) == card
                    }
                } == true
            }
            it("notifies view") {
                sut.viewDelegate = viewDelegate
                sut.updateDeck(Deck(id: "newDeck", name: "new deck", cards: []))
                
                expect(viewDelegate.isDidUpdateDeckCalled) == true
            }
        }
        
        describe("deckWidthMultiplier") {
            it("returns the complement of horizontalDeckPadding") {
                let horizontalDeckPadding: CGFloat = 0.003
                let expected: CGFloat = 1 - horizontalDeckPadding
                let newLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: horizontalDeckPadding, verticalDeckPadding: 0)
                sut = DeckViewModel(deck: initialDeck, layout: newLayout)
                
                expect(sut.deckWidthMultiplier) == expected
            }
        }
        describe("deckHeightMultiplier") {
            it("returns the complement of verticalDeckPadding") {
                let verticalDeckPadding: CGFloat = 0.555
                let expected: CGFloat = 1 - verticalDeckPadding
                let newLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: verticalDeckPadding)
                sut = DeckViewModel(deck: initialDeck, layout: newLayout)
                
                expect(sut.deckHeightMultiplier) == expected
            }
        }
        describe("cardSize") {
            it("returns percentage size to be used for the card based on the view sent and deckLayout") {
                let viewWidth: CGFloat = 100
                let viewHeight: CGFloat = 100
                let view = UIView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
                
                let cardWidth: CGFloat = 0.8
                let cardHeight: CGFloat = 0.3
                let newLayout = DeckLayout(cardWidth: cardWidth, cardHeight: cardHeight, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: 0)
                sut = DeckViewModel(deck: initialDeck, layout: newLayout)
                
                let expected = CGSize(width: viewWidth * cardWidth, height: viewHeight * cardHeight)
                
                expect(sut.cardSize(for: view)) == expected
            }
        }
        describe("horizontalCardSpacing") {}
        describe("verticalCardSpacing") {}
        
        describe("showMenu") {
            it("notifies delegate") {
                sut = DeckViewModel(deck: initialDeck, layout: initiaLayout)
                sut.delegate = delegate
                
                sut.showMenu(from: DeckViewController())
                expect(delegate.isDidTapShowMenuCalled) == true
            }
        }
        describe("showCard") {
            it("notifies delegate") {
                sut = DeckViewModel(deck: initialDeck, layout: initiaLayout)
                sut.delegate = delegate
                
                sut.showCard(Card(text: ""), from: DeckViewController())
                expect(delegate.isDidTapShowCardCalled) == true
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleViewDelegate: DeckViewModelViewDelegate {
    var isDidUpdateDeckCalled = false
    func didUpdateDeck() {
        isDidUpdateDeckCalled = true
    }
}

private class DoubleDelegate: DeckViewModelDelegate {
    var isDidTapShowMenuCalled = false
    var isDidTapShowCardCalled = false
    func didTapShowMenu(from viewController: DeckViewController) {
        isDidTapShowMenuCalled = true
    }
    
    func didTapShowCard(_ card: Card, from viewController: DeckViewController) {
        isDidTapShowCardCalled = true
    }
}
