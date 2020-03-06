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
        var layout: DeckLayout!
        var viewDelegate: ViewDelegate!
        var sut: DeckViewModel!
        
        beforeEach {
            initialDeck = Deck(id: "1", name: "testing", cards: [])
            layout = DeckLayout(cardWidth: 0, cardHeight: 0, horizontalCardSpacing: 0, verticalCardSpacing: 0, horizontalDeckPadding: 0, verticalDeckPadding: 0)
            viewDelegate = ViewDelegate()
        }
        
        describe("updateDeck") {
            it("notifies view") {
                sut = DeckViewModel(deck: initialDeck, layout: layout)
                sut.viewDelegate = viewDelegate
                
                sut.updateDeck(Deck(id: "2", name: "testing", cards: []))
                expect(viewDelegate.isDidUpdateDeckCalled) == true
            }
        }
        
        describe("deckName") {
            it("returns deck name") {
                let name = "another deck"
                let newDeck = Deck(id: "2", name: name, cards: [])
                sut = DeckViewModel(deck: newDeck, layout: layout)
                
                expect(sut.deckName) == name
            }
        }
        describe("deckSize") {
            it("returns deck size") {
                let n = 5
                let cards = (0..<n).map { Card(text: String($0)) }
                let newDeck = Deck(id: "2", name: "name", cards: cards)
                sut = DeckViewModel(deck: newDeck, layout: layout)
                
                expect(sut.deckSize) == n
            }
        }
        describe("card(at:)") {
            it("returns corresponing card") {
                let cards = (0..<5).map { Card(text: String($0)) }
                let newDeck = Deck(id: "2", name: "name", cards: cards)
                sut = DeckViewModel(deck: newDeck, layout: layout)
                
                cards.enumerated().forEach { (index, card) in
                    expect(sut.card(at: index)) == card
                }
            }
        }
    }
}

// MARK: - Test doubles

private class ViewDelegate: DeckViewModelViewDelegate {
    var isDidUpdateDeckCalled = false
    func didUpdateDeck() {
        isDidUpdateDeckCalled = true
    }
}
