//
//  AnalyticsEvent.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2020/03/02.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

import Foundation

enum AnalyticsEvent: Equatable {
    case selectedDeck(Deck)
    case preferenceBool(Preference<Bool>, Bool)
    case shareApp
    case writeReview
    case feedback
    case contribute
    
    var name: String {
        switch self {
        case .selectedDeck:
            return "selected_deck"
        case .preferenceBool:
            return "preference_bool"
        case .shareApp:
            return "share_app"
        case .writeReview:
            return "write_review"
        case .feedback:
            return "feedback"
        case .contribute:
            return "contribute:"
        }
    }
}
