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
        var delegate: DoubleDelegate!
        var sut: CardViewModel!
        
        beforeEach {
            configuration = DoubleConfiguration()
            generator = DoubleGenerator()
            viewDelegate = DoubleViewDelegate()
            delegate = DoubleDelegate()
        }
        
        describe("flipCard") {
            beforeEach {
                sut = CardViewModel(card: Card(text: ""), configuration: configuration, hapticFeedbackGenerator: generator)
                sut.viewDelegate = viewDelegate
                
                configuration.valueToReturnForVibrateOnReveal = false
            }
            it("notifies view") {
                sut.flipCard()
                expect(viewDelegate.isFlipCardCalled) == true
            }
            context("when vibrate on reveal is enabled") {
                beforeEach {
                    configuration.valueToReturnForVibrateOnReveal = true
                }
                it("generates haptic feedback") {
                    sut.flipCard()
                    expect(generator.isGenerateCalled) == true
                }
            }
            context("when vibrate on reveal is disable") {
                beforeEach {
                    configuration.valueToReturnForVibrateOnReveal = false
                }
                it("does not generate haptic feedback") {
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
                sut = CardViewModel(card: Card(text: ""), configuration: configuration, hapticFeedbackGenerator: generator)
                sut.viewDelegate = viewDelegate
                
                configuration.valueToReturnForVibrateOnReveal = false
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
            context("when shake to reveal is disabled") {
                beforeEach {
                    configuration.valueToReturnForShakeToReveal = false
                }
                context("and card is not flipped") {
                    it("does not flip the card") {
                        sut.flipCardWhenShakingIfNeeded()
                        expect(viewDelegate.isFlipCardCalled) == false
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
        
        describe("close") {
            beforeEach {
                sut = CardViewModel(card: Card(text: ""), configuration: configuration, hapticFeedbackGenerator: generator)
                sut.delegate = delegate
            }
            it("notifies delegate") {
                sut.close(from: CardViewController())
                expect(delegate.isDidTapCloseCalled) == true
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleConfiguration: ScrumPoker.Configuration {
    var valueToReturnForShakeToReveal: Bool!
    var valueToReturnForVibrateOnReveal: Bool!
    override func getValue(for preference: Preference<Bool>) -> Bool {
        switch preference {
        case .shakeToReveal:
            return valueToReturnForShakeToReveal
        case .vibrateOnReveal:
            return valueToReturnForVibrateOnReveal
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

private class DoubleDelegate: CardViewModelDelegate {
    var isDidTapCloseCalled = false
    func didTapClose(from viewController: CardViewController) {
        isDidTapCloseCalled = true
    }
}
