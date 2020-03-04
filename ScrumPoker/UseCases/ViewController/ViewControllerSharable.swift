//
//  ViewControllerSharable.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/14.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol ViewControllerSharable where Self: UIViewController {
    func showShareActivity(with items: [Any])
}

extension ViewControllerSharable {
    func showShareActivity(with items: [Any]) {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
