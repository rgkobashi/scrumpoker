//
//  MenuViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/07.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class MenuViewModelSpec: QuickSpec {
    override func spec() {
        let decksIndexPaths = [IndexPath(row: 0, section: 0),
                               IndexPath(row: 1, section: 0)
        ]
        let preferencesIndexPaths = [IndexPath(row: 0, section: 1),
                                     IndexPath(row: 1, section: 1),
                                     IndexPath(row: 2, section: 1)
        ]
        let actionsIndexPaths = [IndexPath(row: 0, section: 2),
                                 IndexPath(row: 1, section: 2),
                                 IndexPath(row: 0, section: 3),
                                 IndexPath(row: 1, section: 3)
        ]
        var sut: MenuViewModel!
        
        beforeEach {
            sut = MenuViewModel(appInformation: AppInformation(),
                                feedbackSender: FeedbackSender(),
                                configuration: Configuration(),
                                analyticsManager: AnalyticsManager(engine: FirebaseAnalyticsEngine()))
        }
        
        describe("shouldEnableRegularRowSelection") {
            it("returns XXX for decks items") {}
            it("returns false for preferences items") {
                expect {
                    preferencesIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldEnableRegularRowSelection(at: ip) == false
                    }
                } == true
            }
            it("returns true for actions items") {
                expect {
                    actionsIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldEnableRegularRowSelection(at: ip) == true
                    }
                } == true
            }
        }
        describe("shouldDeselectAfterSelectingRow") {
            it("returns false for preferences items") {
                expect {
                    preferencesIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectAfterSelectingRow(at: ip) == false
                    }
                } == true
            }
            it("returns true for the rest") {
                expect {
                    decksIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectAfterSelectingRow(at: ip) == true
                    }
                } == true
                expect {
                    actionsIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectAfterSelectingRow(at: ip) == true
                    }
                } == true
            }
        }
        describe("shouldDeselectRestOfSectionAfterSelectingRow") {
            it("returns true for decks items") {
                expect {
                    decksIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == true
                    }
                } == true
            }
            it("returns false for the rest") {
                expect {
                    preferencesIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == false
                    }
                } == true
                expect {
                    actionsIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == false
                    }
                } == true
            }
        }
        describe("shouldDeselectItselfAfterSelectingRow") {
            it("returns true for actions items") {
                expect {
                    actionsIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == true
                    }
                } == true
            }
            it("returns false for the rest") {
                expect {
                    decksIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == false
                    }
                } == true
                expect {
                    preferencesIndexPaths.allSatisfy { ip -> Bool in
                        return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == false
                    }
                } == true
            }
        }
    }
}
