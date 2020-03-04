//
//  FeedbackSender.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/13.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import MessageUI

enum FeedbackType {
    case mail(recipients: [String], subject: String, message: String, from: UIViewController)
}

extension FeedbackSender {
    enum Error: Swift.Error {
        case mailClientNotConfigured
    }
}

class FeedbackSender {
    
    typealias CompletionType = (_ succeed: Bool) -> Void
    
    let mailComposeViewControllerType: MFMailComposeViewController.Type
    
    init(mailComposeViewControllerType: MFMailComposeViewController.Type = MFMailComposeViewController.self) {
        self.mailComposeViewControllerType = mailComposeViewControllerType
    }
    
    func sendFeedback(_ type: FeedbackType, completion: CompletionType? = nil) throws {
        switch type {
        case let .mail(recipients, subject, message, vc):
            try openMailComposer(recipients: recipients, subject: subject, message: message, from: vc, completion: completion)
        }
    }
    
    // MARK: Private
    
    private func openMailComposer(recipients: [String], subject: String, message: String, from viewController: UIViewController, completion: CompletionType?) throws {
        guard mailComposeViewControllerType.canSendMail() else {
            throw Error.mailClientNotConfigured
        }
        let mcvc = CustomMailComposeViewController(completion: completion)
        mcvc.mailComposeDelegate = mcvc
        mcvc.setToRecipients(recipients)
        mcvc.setSubject(subject)
        mcvc.setMessageBody(message, isHTML: false)
        viewController.present(mcvc, animated: true)
    }
}

// MARK: - Mail type

private class CustomMailComposeViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    let completion: FeedbackSender.CompletionType?
    
    init(completion: FeedbackSender.CompletionType?) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        controller.dismiss(animated: true) { [weak self] in
            self?.completion?({
                switch result {
                case .cancelled, .failed:
                    return false
                case .saved, .sent:
                    return true
                @unknown default:
                    fatalError("MFMailComposeResult not handled")
                }
                }()
            )
        }
    }
}

