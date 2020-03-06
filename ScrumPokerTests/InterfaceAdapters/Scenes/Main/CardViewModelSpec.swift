//
//  CardViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/06.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble


class CardViewModelSpec: QuickSpec {
    override func spec() {
        var configuration: DoubleConfiguration!
        var generator: DoubleGenerator!
        var viewDelegate: DoubleViewDelegate!
        var sut: CardViewModel!
        
        describe("flipCard") {
            beforeEach {
                configuration = DoubleConfiguration()
                generator = DoubleGenerator()
                viewDelegate = DoubleViewDelegate()
                sut = CardViewModel(card: Card(text: ""), configuration: configuration, hapticFeedbackGenerator: generator)
                sut.viewDelegate = viewDelegate
                
                configuration.valueToReturnForShakeOnReveal = false
            }
            it("notifies view") {
                sut.flipCard()
                expect(viewDelegate.isFlipCardCalled) == true
            }
            context("when shake on reveal is enabled") {
                it("generates haptic feedback") {
                    configuration.valueToReturnForShakeOnReveal = true
                    sut.flipCard()
                    expect(generator.isGenerateCalled) == true
                }
            }
            context("when shake on reveal is disable") {
                it("does not generate haptic feedback") {
                    configuration.valueToReturnForShakeOnReveal = false
                    sut.flipCard()
                    expect(generator.isGenerateCalled) == false
                }
            }
            it("flips the card") {
                sut.flipCard()
                expect(sut.isCardFlipped) == true
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleConfiguration: ScrumPoker.Configuration {
    var valueToReturnForShakeOnReveal: Bool!
    override func getValue(for preference: Preference<Bool>) -> Bool {
        switch preference {
        case .shakeOnReveal:
            return valueToReturnForShakeOnReveal
        default:
            fatalError("preference not handled")
        }
    }
}

private class DoubleGenerator: HapticFeedbackGenerator {
    var isGenerateCalled = false
    override func generate(_ type: HapticFeedbackGeneratorType) {
        isGenerateCalled = true
    }
}

private class DoubleViewDelegate: CardViewModelViewDelegate {
    var isFlipCardCalled = false
    func flipCard(completion: @escaping () -> Void) {
        isFlipCardCalled = true
        completion()
    }
}
