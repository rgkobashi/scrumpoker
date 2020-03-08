//
//  DeckRowViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/08.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class DeckRowViewModelSpec: QuickSpec {
    override func spec() {
        var deck: Deck!
        var configuration: DoubleConfiguration!
        var sut: DeckRowViewModel!
        
        beforeEach {
            deck = .fibonacci
            configuration = DoubleConfiguration()
            sut = DeckRowViewModel(deck: deck, configuration: configuration)
        }
        describe("text") {
            it("returns deck name") {
                expect(sut.text) == deck.name
            }
        }
        describe("type") {
            context("when holding deck is selected") {
                it("returns checkmark with true") {
                    configuration.selectedDeckToReturn = .fibonacci
                    expect {
                        switch sut.type {
                        case .checkmark(let value):
                            return value
                        default:
                            return false
                        }
                    } == true
                }
            }
            context("when holding deck is not selected") {
                it("returns checkmark with false") {
                    configuration.selectedDeckToReturn = .standard
                    expect {
                        switch sut.type {
                        case .checkmark(let value):
                            return value
                        default:
                            return false
                        }
                    } == false
                }
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleConfiguration: ScrumPoker.Configuration {
    var selectedDeckToReturn: Deck!
    override var selectedDeck: Deck {
        set {}
        get { return selectedDeckToReturn }
    }
}
