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
        var feedbackSender: DoubleFeedbackSender!
        var analyticsEngine: DoubleAnalyticsEngine!
        var application: DoubleApplication!
        var delegate: DoubleDelegate!
        var viewDelegate: DoubleViewDelegate!
        var sut: MenuViewModel!
        
        beforeEach {
            configuration = DoubleConfiguration()
            feedbackSender = DoubleFeedbackSender()
            analyticsEngine = DoubleAnalyticsEngine()
            application = DoubleApplication()
            delegate = DoubleDelegate()
            viewDelegate = DoubleViewDelegate()
            sut = MenuViewModel(appInformation: AppInformation(),
                                feedbackSender: feedbackSender,
                                configuration: configuration,
                                analyticsManager: AnalyticsManager(engine: analyticsEngine),
                                application: application)
            sut.delegate = delegate
            sut.viewDelegate = viewDelegate
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
            context("for decks section") {
                it("returns true") {
                    expect {
                        decksIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectAfterSelectingRow(at: ip) == true
                        }
                    } == true
                }
            }
            context("for preferences section") {
                it("returns false") {
                    expect {
                        preferencesIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectAfterSelectingRow(at: ip) == false
                        }
                    } == true
                }
            }
            context("for actions sections") {
                it("returns true") {
                    expect {
                        actionsIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectAfterSelectingRow(at: ip) == true
                        }
                    } == true
                }
            }
        }
        describe("shouldDeselectRestOfSectionAfterSelectingRow") {
            context("for decks section") {
                it("returns true") {
                    expect {
                        decksIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == true
                        }
                    } == true
                }
            }
            context("for preferences section") {
                it("returns false") {
                    expect {
                        preferencesIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == false
                        }
                    } == true
                }
            }
            context("for actions sections") {
                it("returns false") {
                    expect {
                        actionsIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectRestOfSectionAfterSelectingRow(at: ip) == false
                        }
                    } == true
                }
            }
        }
        describe("shouldDeselectItselfAfterSelectingRow") {
            context("for decks section") {
                it("returns false") {
                    expect {
                        decksIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == false
                        }
                    } == true
                }
            }
            context("for preferences section") {
                it("returns false") {
                    expect {
                        preferencesIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == false
                        }
                    } == true
                }
            }
            context("for actions sections") {
                it("returns true") {
                    expect {
                        actionsIndexPaths.allSatisfy { ip -> Bool in
                            return sut.shouldDeselectItselfAfterSelectingRow(at: ip) == true
                        }
                    } == true
                }
            }
        }
        
        describe("didSelectRow") {
            context("for decks section") {
                beforeEach {
                    sut.didSelectRow(at: decksIndexPaths.first!, from: MenuViewController())
                }
                it("updates deck") {
                    expect(configuration.selectedDeckSet).toNot(beNil())
                }
                it("sends analytics event") {
                    expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                }
                it("notify delegate") {
                    expect(delegate.isDidUpdateDeckCalled) == true
                }
            }
            context("for preferences section") {
                beforeEach {
                    sut.didSelectRow(at: preferencesIndexPaths.first!, from: MenuViewController())
                }
                it("sends analytics event") {
                    expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                }
                it("stores value in configuration") {
                    expect(configuration.isSetValueCalled) == true
                }
            }
            context("for actions sections") {
                context("share row") {
                    beforeEach {
                        sut.didSelectRow(at: actionsIndexPaths[0], from: MenuViewController())
                    }
                    it("sends analytics event") {
                        expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                    }
                    it("notifies view") {
                        expect(viewDelegate.isShareAppCalled) == true
                    }
                }
                context("feedback row") {
                    it("sends analytics event") {
                        sut.didSelectRow(at: actionsIndexPaths[1], from: MenuViewController())
                        expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                    }
                    context("if mail client configured") {
                        beforeEach {
                            feedbackSender.shouldThrowWhenSendFeedback = false
                            sut.didSelectRow(at: actionsIndexPaths[1], from: MenuViewController())
                        }
                        it("opens mail client") {
                            expect(feedbackSender.isSendFeedbackCalled) == true
                        }
                        it("does not notifies view") {
                            expect(viewDelegate.isShowAlertCalled) == false
                        }
                    }
                    context("if mail client not configured") {
                        beforeEach {
                            feedbackSender.shouldThrowWhenSendFeedback = true
                            sut.didSelectRow(at: actionsIndexPaths[1], from: MenuViewController())
                        }
                        it("notifies view") {
                            expect(viewDelegate.isShowAlertCalled) == true
                        }
                    }
                }
                context("write a review row") {
                    beforeEach {
                        sut.didSelectRow(at: actionsIndexPaths[2], from: MenuViewController())
                    }
                    it("sends analytics event") {
                        expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                    }
                    it("opens url") {
                        expect(application.isOpenCalled) == true
                    }
                }
                context("contribute row") {
                    beforeEach {
                        sut.didSelectRow(at: actionsIndexPaths[3], from: MenuViewController())
                    }
                    it("sends analytics event") {
                        expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                    }
                    it("opens url") {
                        expect(application.isOpenCalled) == true
                    }
                }
            }
        }
        describe("didDeselectRow"){
            context("for decks section") {
                it("throws assertion") {
                    decksIndexPaths.forEach { ip in
                        expect {
                            sut.didDeselectRow(at: ip, from: MenuViewController())
                        }.to(throwAssertion())
                    }
                }
            }
            context("for preferences section") {
                beforeEach {
                    sut.didDeselectRow(at: preferencesIndexPaths.first!, from: MenuViewController())
                }
                it("sends analytics event") {
                    expect(analyticsEngine.isSendAnalyticsEventCalled) == true
                }
                it("stores value in configuration") {
                    expect(configuration.isSetValueCalled) == true
                }
            }
            context("for actions sections") {
                it("throws assertion") {
                    actionsIndexPaths.forEach { ip in
                        expect {
                            sut.didDeselectRow(at: decksIndexPaths.first!, from: MenuViewController())
                        }.to(throwAssertion())
                    }
                }
            }
        }
    }
}

// MARK: - Test doubles

private class DoubleFeedbackSender: FeedbackSender {
    var isSendFeedbackCalled = false
    var shouldThrowWhenSendFeedback = false
    override func sendFeedback(_ type: FeedbackType, completion: FeedbackSender.CompletionType? = nil) throws {
        if shouldThrowWhenSendFeedback {
            throw FeedbackSender.Error.mailClientNotConfigured
        }
        isSendFeedbackCalled = true
    }
}

private class DoubleConfiguration: ScrumPoker.Configuration {
    var selectedDeckToReturn: Deck!
    var selectedDeckSet: Deck?
    var isSetValueCalled = false
    override var selectedDeck: Deck {
        set { selectedDeckSet = newValue }
        get { return selectedDeckToReturn }
    }
    
    override func setValue(_ value: Bool, for preference: Preference<Bool>) {
        isSetValueCalled = true
    }
}

private class DoubleAnalyticsEngine: AnalyticsEngine {
    var isSendAnalyticsEventCalled = false
    func sendAnalyticsEvent(_ event: AnalyticsEvent) {
        isSendAnalyticsEventCalled = true
    }
}

private class DoubleApplication: ApplicationType {
    var isOpenCalled = false
    var keyWindow: UIWindow?
    var isIdleTimerDisabled: Bool = false
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        isOpenCalled = true
    }
}

private class DoubleDelegate: MenuViewModelDelegate {
    var isDidUpdateDeckCalled = false
    func didUpdateDeck(_ deck: Deck, from viewController: MenuViewController) {
        isDidUpdateDeckCalled = true
    }
}

private class DoubleViewDelegate: MenuViewModelViewDelegate {
    var isShowAlertCalled = false
    var isShareAppCalled = false
    func showAlert(title: String?, message: String, action: (() -> Void)?) {
        isShowAlertCalled = true
    }
    
    func shareApp(_ url: URL) {
        isShareAppCalled = true
    }
}
