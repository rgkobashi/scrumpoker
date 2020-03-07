//
//  ConfigurationSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/05.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble

class ConfigurationSpec: QuickSpec {
    override func spec() {
        var app: ApplicationType!
        var userDefaults: DoubleUserDefaults!
        var sut: ScrumPoker.Configuration!
        
        beforeEach {
            app = DoubleApplication(keyWindow: nil, isIdleTimerDisabled: false)
            userDefaults = DoubleUserDefaults()
            sut = ScrumPoker.Configuration(application: app, userDefaults: userDefaults)
        }
        
        describe("loadPreferences") {
            it("sets isIdleTimerDisabled") {
                userDefaults.valueToReturnAsBool = true
                sut.loadPreferences()
                expect(app.isIdleTimerDisabled) == true
            }
        }
        
        // MARK: Settings
        
        describe("selectedDeck") {
            context("setter") {
                it("persist deck") {
                    let deck = Deck.fibonacci
                    sut.selectedDeck = deck
                    expect(userDefaults.valueSetAsAny as? String) == deck.name
                }
            }
            context("getter") {
                it("fetch deck from persistance") {
                    let deck = Deck.fibonacci
                    userDefaults.valueToReturnAsString = deck.name
                    expect(sut.selectedDeck.name) == deck.name
                }
            }
        }
        describe("setValue for preference bool") {
            it("persists it") {
                let value = true
                sut.setValue(value, for: .shakeToReveal)
                expect(userDefaults.valueSetAsBool) == value
            }
        }
        describe("getValue for preference bool") {
            it("fetch value from persistance") {
                let value = true
                userDefaults.valueToReturnAsBool = value
                expect(sut.getValue(for: .shakeToReveal)) == value
            }
        }
    }
}

private class DoubleApplication: ApplicationType {
    var keyWindow: UIWindow?
    var isIdleTimerDisabled: Bool
    
    init(keyWindow: UIWindow?, isIdleTimerDisabled: Bool) {
        self.keyWindow = keyWindow
        self.isIdleTimerDisabled = isIdleTimerDisabled
    }
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {}
}

private class DoubleUserDefaults: UserDefaults {
    var valueSetAsAny: Any?
    var valueToReturnAsString: String?

    override func set(_ value: Any?, forKey defaultName: String) {
        valueSetAsAny = value
    }
    override func string(forKey defaultName: String) -> String? {
        return valueToReturnAsString
    }
    
    var valueSetAsBool: Bool?
    var valueToReturnAsBool: Bool?
    
    override func set(_ value: Bool, forKey defaultName: String) {
        valueSetAsBool = value
    }
    override func bool(forKey defaultName: String) -> Bool {
        return valueToReturnAsBool!
    }
}
