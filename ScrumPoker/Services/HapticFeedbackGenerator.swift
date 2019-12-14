//
//  HapticFeedbackGenerator.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

enum HapticFeedbackGeneratorType {
    case success
}

class HapticFeedbackGenerator {
    
    func generate(_ type: HapticFeedbackGeneratorType) {
        switch type {
        case .success:
            processNotificationType(.success)
        }
    }
    
    private func processNotificationType(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let g = UINotificationFeedbackGenerator()
        g.prepare()
        g.notificationOccurred(type)
    }
}
