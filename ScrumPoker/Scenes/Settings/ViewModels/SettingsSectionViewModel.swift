//
//  SettingsSectionViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/12/07.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct SettingsSectionViewModel {
    let title: String?
    let selectionType: TableSectionSelectionType
    let rows: [TableRowViewModel]
}
