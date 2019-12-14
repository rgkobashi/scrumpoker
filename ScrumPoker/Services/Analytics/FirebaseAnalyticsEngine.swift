//
//  FirebaseAnalyticsEngine.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/15.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Firebase

class FirebaseAnalyticsEngine: AnalyticsEngine {
    
    private let analytics: Analytics.Type
    
    init(analytics: Analytics.Type = Analytics.self) {
        self.analytics = analytics
    }
    
    func sendAnalyticsEvent(_ event: AnalyticsEvent) {
        switch event {
        case .selectedDeck(let sd):
            analytics.logEvent(event.name, parameters: [
                "id": sd.id
            ])
        case .preference(let p):
            analytics.logEvent(event.name, parameters: [
                "id": p.id
//                "value" : p.value // TODO get value from preference
            ])
        case .shareApp, .writeReview, .feedback, .contribute, .donate:
            analytics.logEvent(event.name, parameters: nil)
        }
    }
}
