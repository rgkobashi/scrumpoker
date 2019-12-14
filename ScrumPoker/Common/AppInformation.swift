//
//  AppInformation.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

class AppInformation {
    private let bundle: Bundle
    private var appAppleId: String {
        return "1461657631"
    }
    
    var name: String {
        guard let n = bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            fatalError("Unable to get app name")
        }
        return n
    }
    var version: String {
        guard let v = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("Unable to get app version")
        }
        return v
    }
    var appURL: URL {
        return URL(string: "https://apps.apple.com/app/id\(appAppleId)")!
    }
    var donateURL: URL {
        return URL(string: "https://www.paypal.me/rgkobashi")!
    }
    var contributeURL: URL {
        return URL(string: "https://github.com/rgkobashi/scrumpoker")!
    }
    var writeReviewURL: URL {
        return URL(string: "itms-apps://itunes.apple.com/app/\(appAppleId)?action=write-review")!
    }
    var feedbackEmail: String {
        return "rgkobashi@gmail.com"
    }
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
}
