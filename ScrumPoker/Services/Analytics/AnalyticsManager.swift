//
//  AnalyticsManager.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

enum AnalyticsEvent {
    case foo // TODO add real events
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
