//
//  PreferenceBoolRowViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/08.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class PreferenceBoolRowViewModelSpec: QuickSpec {
    override func spec() {
        var preference: Preference<Bool>!
        var configuration: DoubleConfiguration!
        var sut: PreferenceBoolRowViewModel!
        
        beforeEach {
            preference = .shakeToReveal
            configuration = DoubleConfiguration()
            sut = PreferenceBoolRowViewModel(preference: preference, configuration: configuration)
        }
        describe("text") {
            it("returns preference name") {
                expect(sut.text) == preference.name
            }
        }
        describe("type") {
            it("returns switch with value from configuration") {
                let expected = true
                configuration.valueToReturn = expected
                expect {
                    switch sut.type {
                    case .switch(let value):
                        return value
                    default:
                        return false
                    }
                } == expected
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleConfiguration: ScrumPoker.Configuration {
    var valueToReturn: Bool!
    var selectedDeckToReturn: Deck!
    override var selectedDeck: Deck {
        set {}
        get { return selectedDeckToReturn }
    }
    
    override func getValue(for preference: Preference<Bool>) -> Bool {
        return valueToReturn
    }
}
