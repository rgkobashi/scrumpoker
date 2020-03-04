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
    
    private let generator: UINotificationFeedbackGenerator
    
    init(generator: UINotificationFeedbackGenerator = .init()) {
        self.generator = generator
    }
    
    func generate(_ type: HapticFeedbackGeneratorType) {
        switch type {
        case .success:
            processNotificationType(.success)
        }
    }
    
    private func processNotificationType(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
