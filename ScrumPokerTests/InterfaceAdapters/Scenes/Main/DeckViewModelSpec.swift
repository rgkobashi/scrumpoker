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
            initialDeck = Deck(id: "1", name: "testing", cards: [])
            initiaLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: 0)
            viewDelegate = DoubleViewDelegate()
        }
        
        describe("updateDeck") {
            it("notifies view") {
                sut = DeckViewModel(deck: initialDeck, layout: initiaLayout)
                sut.viewDelegate = viewDelegate
                
                sut.updateDeck(Deck(id: "2", name: "testing", cards: []))
                expect(viewDelegate.isDidUpdateDeckCalled) == true
            }
        }
        
        describe("deckName") {
            it("returns deck name") {
                let name = "another deck"
                let newDeck = Deck(id: "2", name: name, cards: [])
                sut = DeckViewModel(deck: newDeck, layout: initiaLayout)
                
                expect(sut.deckName) == name
            }
        }
        describe("deckSize") {
            it("returns deck size") {
                let n = 5
                let cards = (0..<n).map { Card(text: String($0)) }
                let newDeck = Deck(id: "2", name: "name", cards: cards)
                sut = DeckViewModel(deck: newDeck, layout: initiaLayout)
                
                expect(sut.deckSize) == n
            }
        }
        describe("card(at:)") {
            it("returns corresponing card") {
                let cards = (0..<5).map { Card(text: String($0)) }
                let newDeck = Deck(id: "2", name: "name", cards: cards)
                sut = DeckViewModel(deck: newDeck, layout: initiaLayout)
                
                cards.enumerated().forEach { (index, card) in
                    expect(sut.card(at: index)) == card
                }
            }
        }
        
        describe("deckWidthMultiplier") {
            it("returns the complement of horizontalDeckPadding") {
                let horizontalDeckPadding: CGFloat = 0.5
                let expected: CGFloat = 1 - horizontalDeckPadding
                let newLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: horizontalDeckPadding, verticalDeckPadding: 0)
                sut = DeckViewModel(deck: initialDeck, layout: newLayout)
                
                expect(sut.deckWidthMultiplier) == expected
            }
        }
        describe("deckHeightMultiplier") {
            it("returns the complement of verticalDeckPadding") {
                let verticalDeckPadding: CGFloat = 0.5
                let expected: CGFloat = 1 - verticalDeckPadding
                let newLayout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: verticalDeckPadding)
                sut = DeckViewModel(deck: initialDeck, layout: newLayout)
                
                expect(sut.deckHeightMultiplier) == expected
            }
        }
        describe("cardSize") {}
        describe("horizontalCardSpacing") {}
        describe("verticalCardSpacing") {}
        
        describe("showMenu") {
            it("notifies delegate") {
                delegate = DoubleDelegate()
                sut = DeckViewModel(deck: initialDeck, layout: initiaLayout)
                sut.delegate = delegate
                
                sut.showMenu(from: DeckViewController())
                expect(delegate.isDidTapShowMenuCalled) == true
            }
        }
        describe("showCard") {
            it("notifies delegate") {
                delegate = DoubleDelegate()
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
