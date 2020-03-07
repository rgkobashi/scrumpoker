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
        
        var configuration: DoubleConfiguration!
        var sut: MenuViewModel!
        
        beforeEach {
            configuration = DoubleConfiguration()
            sut = MenuViewModel(appInformation: AppInformation(),
                                feedbackSender: DoubleFeedbackSender(),
                                configuration: configuration,
                                analyticsManager: AnalyticsManager(engine: DoubleAnalyticsEngine()),
                                application: DoubleApplication())
        }
        
        describe("numberOfSections") {
            it("returns 4") {
                expect(sut.numberOfSections) == 4
            }
        }
        describe("numberOfRows") {
            context("for decks section") {
                it("returns 2") {
                    expect(sut.numberOfRows(in: 0)) == 2
                }
            }
            context("for preferences section") {
                it("returns 3") {
                    expect(sut.numberOfRows(in: 1)) == 3
                }
            }
            context("for first actions section") {
                it("returns 2") {
                    expect(sut.numberOfRows(in: 2)) == 2
                }
            }
            context("for second actions section") {
                it("returns 2") {
                    expect(sut.numberOfRows(in: 3)) == 2
                }
            }
        }
        describe("headerTitle") {
            context("for decks section") {
                it("returns value") {
                    expect(sut.headerTitle(in: 0)).toNot(beNil())
                }
            }
            context("for preferences section") {
                it("returns value") {
                    expect(sut.headerTitle(in: 1)).toNot(beNil())
                }
            }
            context("for first actions section") {
                it("returns nil") {
                    expect(sut.headerTitle(in: 2)).to(beNil())
                }
            }
            context("for second actions section") {
                it("returns nil") {
                    expect(sut.headerTitle(in: 3)).to(beNil())
                }
            }
        }
        describe("rowViewModel") {
            context("for decks section") {
                it("returns DeckRowViewModel") {
                    expect{
                        decksIndexPaths.allSatisfy { ip -> Bool in
                            return sut.rowViewModel(for: ip) is DeckRowViewModel
                        }
                    } == true
                }
            }
            context("for preferences section") {
                it("returns PreferenceBoolRowViewModel") {
                    expect{
                        preferencesIndexPaths.allSatisfy { ip -> Bool in
                            return sut.rowViewModel(for: ip) is PreferenceBoolRowViewModel
                        }
                    } == true
                }
            }
            context("for actions sections") {
                it("returns ActionRowViewModel") {
                    expect{
                        actionsIndexPaths.allSatisfy { ip -> Bool in
                            return sut.rowViewModel(for: ip) is ActionRowViewModel<MenuViewController>
                        }
                    } == true
                }
            }
        }
        
        describe("shouldEnableRegularRowSelection") {
            context("for decks section") {
                it("returns false when the deck is already selected") {
                    configuration.selectedDeckToReturn = .fibonacci
                    expect(sut.shouldEnableRegularRowSelection(at: decksIndexPaths[0])) == false
                }
                it("returns true when the deck is not selected yet") {
                    configuration.selectedDeckToReturn = .fibonacci
                    expect(sut.shouldEnableRegularRowSelection(at: decksIndexPaths[1])) == true
                }
            }
            context("for preferences section") {
                it("returns false") {
                    expect {
                        preferencesIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldEnableRegularRowSelection(at: ip) == false
                        }
                    } == true
                }
            }
            context("for actions sections") {
                it("returns true") {
                    expect {
                        actionsIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldEnableRegularRowSelection(at: ip) == true
                        }
                    } == true
                }
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
        
        describe("didDeselectRow") {
            it("throws assertion for deck items") {
                decksIndexPaths.forEach { (ip) in
                    expect {
                        sut.didDeselectRow(at: decksIndexPaths.first!, from: MenuViewController())
                    }.to(throwAssertion())
                }
            }
            it("does not throw assertion for preference items") {}
            it("throws assertion for actions items") {
                actionsIndexPaths.forEach { (ip) in
                    expect {
                        sut.didDeselectRow(at: actionsIndexPaths.first!, from: MenuViewController())
                    }.to(throwAssertion())
                }
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleFeedbackSender: FeedbackSender {
    override func sendFeedback(_ type: FeedbackType, completion: FeedbackSender.CompletionType? = nil) throws {}
}

private class DoubleConfiguration: ScrumPoker.Configuration {
    var selectedDeckToReturn: Deck!
    override var selectedDeck: Deck {
        set {}
        get { return selectedDeckToReturn }
    }
    
    override func setValue(_ value: Bool, for preference: Preference<Bool>) {}
}

private class DoubleAnalyticsEngine: AnalyticsEngine {
    func sendAnalyticsEvent(_ event: AnalyticsEvent) {}
}

private class DoubleApplication: ApplicationType {
    var keyWindow: UIWindow?
    var isIdleTimerDisabled: Bool = false
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {}
}
