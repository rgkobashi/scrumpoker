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
        
        describe("flipCardWhenShakingIfNeeded") {
            beforeEach {
                configuration = DoubleConfiguration()
                generator = DoubleGenerator()
                viewDelegate = DoubleViewDelegate()
                sut = CardViewModel(card: Card(text: ""), configuration: configuration, hapticFeedbackGenerator: generator)
                sut.viewDelegate = viewDelegate
                
                configuration.valueToReturnForShakeOnReveal = false
                configuration.valueToReturnForShakeToReveal = false
            }
            
            context("when shake to reveal is enabled") {
                beforeEach {
                    configuration.valueToReturnForShakeToReveal = true
                }
                context("and card is not flipped") {
                    it("flips the card") {
                        sut.flipCardWhenShakingIfNeeded()
                        expect(viewDelegate.isFlipCardCalled) == true
                    }
                }
                context("and card is already flipped") {
                    beforeEach {
                        sut.flipCard() // this will set isFlipCardCalled to true
                        viewDelegate.isFlipCardCalled = false // setting to false so it can be evaluated again
                    }
                    it("does not flip the card") {
                        sut.flipCardWhenShakingIfNeeded()
                        expect(viewDelegate.isFlipCardCalled) == false
                    }
                }
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleConfiguration: ScrumPoker.Configuration {
    var valueToReturnForShakeOnReveal: Bool!
    var valueToReturnForShakeToReveal: Bool!
    override func getValue(for preference: Preference<Bool>) -> Bool {
        switch preference {
        case .shakeOnReveal:
            return valueToReturnForShakeOnReveal
        case .shakeToReveal:
            return valueToReturnForShakeToReveal
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
