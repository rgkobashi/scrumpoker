//
//  FeedbackSenderSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/04.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import MessageUI
import Quick
import Nimble

class FeedbackSenderSpec: QuickSpec {
    override func spec() {
        var sut: FeedbackSender!
        
        describe("sendFeedback") {
            context("mail type") {
                context("if Mail is configured") {
                    beforeEach {
                        DoubleMailComposeVC.canSendMailToReturn = true
                        sut = FeedbackSender(mailComposeViewControllerType: DoubleMailComposeVC.self)
                    }
                    it("shows mail compose screen") {
                        let vc = DoubleVC()
                        try? sut.sendFeedback(.mail(recipients: [""], subject: "", message: "", from: vc))
                        expect(vc.isPresentViewControllerCalled) == true
                    }
                }
                context("if Mail is not configured") {
                    beforeEach {
                        DoubleMailComposeVC.canSendMailToReturn = false
                        sut = FeedbackSender(mailComposeViewControllerType: DoubleMailComposeVC.self)
                    }
                    it("throws Error.mailClientNotConfigured") {
                        expect {
                            try sut.sendFeedback(.mail(recipients: [""], subject: "", message: "", from: UIViewController()))
                        }.to(throwError(FeedbackSender.Error.mailClientNotConfigured))
                    }
                }
            }
            
        }
    }
}

private class DoubleMailComposeVC: MFMailComposeViewController {
    static var canSendMailToReturn: Bool!
    
    override class func canSendMail() -> Bool {
        return canSendMailToReturn
    }
}

private class DoubleVC: UIViewController {
    var isPresentViewControllerCalled = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        isPresentViewControllerCalled = true
    }
}
