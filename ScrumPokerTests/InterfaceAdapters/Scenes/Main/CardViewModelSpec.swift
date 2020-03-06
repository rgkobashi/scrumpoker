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
