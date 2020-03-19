//
//  DeckLayoutSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/05.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class DeckLayoutSpec: QuickSpec {
    override func spec() {
        var sut: DeckLayout!
        
        describe("default which is 3x5") {
            context("with no need of horizontal scrolling") {
                it("formula result should be close to 1") {
                    sut = DeckLayout.default
                    let X: CGFloat = 3
                    let result = (sut.cardWidth * X) + (sut.horizontalCardSpacing * (X-1))
                    expect(result).to(beCloseTo(1, within: 0.02))
                }
            }
            context("with no need of vertical scrolling") {
                it("formula result should be close to 1") {
                    sut = DeckLayout.default
                    let Y: CGFloat = 5
                    let result = (sut.cardHeight * Y) + (sut.verticalCardSpacing * (Y-1))
                    expect(result).to(beCloseTo(1, within: 0.02))
                }
            }
        }
    }
}
