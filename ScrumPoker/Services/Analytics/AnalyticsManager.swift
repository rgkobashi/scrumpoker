//
//  AnalyticsManager.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

enum AnalyticsEvent {
    case selectedDeck(Deck)
    case preference(Preference<Bool>)
    case shareApp
    case writeReview
    case feedback
    case contribute
    case donate
    
    var name: String {
        switch self {
        case .selectedDeck:
            return "selected_deck"
        case .preference:
            return "preference"
        case .shareApp:
            return "share_app"
        case .writeReview:
            return "write_review"
        case .feedback:
            return "feedback"
        case .contribute:
            return "contribute:"
        case .donate:
            return "donate"
        }
    }
}

protocol AnalyticsEngine {
    func sendAnalyticsEvent(_ event: AnalyticsEvent)
}

class AnalyticsManager {
    
    private let engine: AnalyticsEngine
    
    init(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func log(_ event: AnalyticsEvent) {
        engine.sendAnalyticsEvent(event)
    }
}
