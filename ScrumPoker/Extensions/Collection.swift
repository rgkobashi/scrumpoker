//
//  Collection.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/27.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

extension Collection where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var array: [Element] = []
        return self.compactMap {
            if array.contains($0) {
                return nil
            } else {
                array.append($0)
                return $0
            }
        }
    }
}
