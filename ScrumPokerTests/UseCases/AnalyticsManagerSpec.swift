//
//  AnalyticsManagerSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/05.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class AnalyticsManagerSpec: QuickSpec {
    override func spec() {
        var engine: MockEngine!
        var sut: AnalyticsManager!
        
        describe("log") {
            beforeEach {
                engine = MockEngine()
                sut = AnalyticsManager(engine: engine)
            }
            it("sends right event to the engine") {
                let event = AnalyticsEvent.shareApp
                sut.log(event)
                expect(engine.analyticsEventSent) == event
            }
        }
    }
}

private class MockEngine: AnalyticsEngine {
    var analyticsEventSent: AnalyticsEvent!
    
    func sendAnalyticsEvent(_ event: AnalyticsEvent) {
        analyticsEventSent = event
    }
}
