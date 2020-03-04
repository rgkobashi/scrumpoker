//
//  HapticFeedbackGeneratorSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/05.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class HapticFeedbackGeneratorSpec: QuickSpec {
    override func spec() {
        var generator: MockGenerator!
        var sut: HapticFeedbackGenerator!
        
        describe("generate") {
            context("success type") {
                beforeEach {
                    generator = MockGenerator()
                    sut = HapticFeedbackGenerator(generator: generator)
                }
                it("calls prepare") {
                    sut.generate(.success)
                    expect(generator.isPrepareCalled) == true
                }
                it("occurres success type") {
                    sut.generate(.success)
                    expect(generator.notificationTypeOccurred) == .success
                }
            }
        }
    }
}

private class MockGenerator: UINotificationFeedbackGenerator {
    var isPrepareCalled = false
    var notificationTypeOccurred: UINotificationFeedbackGenerator.FeedbackType?
    
    override func prepare() {
        isPrepareCalled = true
    }
    
    override func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        notificationTypeOccurred = notificationType
    }
}
