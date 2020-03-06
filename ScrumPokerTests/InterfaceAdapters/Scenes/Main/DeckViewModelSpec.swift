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
    }
}

// MARK: - Test doubles

private class ViewDelegate: DeckViewModelViewDelegate {
    var isDidUpdateDeckCalled = false
    func didUpdateDeck() {
        isDidUpdateDeckCalled = true
    }
}
