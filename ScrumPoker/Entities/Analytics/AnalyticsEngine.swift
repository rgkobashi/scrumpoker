//
//  AnalyticsEngine.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2020/03/02.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

import Foundation

protocol AnalyticsEngine {
    func sendAnalyticsEvent(_ event: AnalyticsEvent)
}
