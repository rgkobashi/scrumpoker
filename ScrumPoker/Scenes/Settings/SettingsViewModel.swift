//
//  SettingsViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

enum TableSectionSelectionStyle {
    case single
    case multiple
    case disable
}

struct SettingsSectionViewModel {
    let title: String?
    let selectionStyle: TableSectionSelectionStyle
    let rows: [RowViewModel]
}

struct SettingsRowViewModel: RowViewModel {
    let text: String
    let type: RowType
}

class SettingsViewModel {
    
    private let settings: [SettingsSectionViewModel]
    private lazy var singleSelectionSections: [Int] = {
        return settings
            .enumerated()
            .map { (index, setting) -> Int? in
                setting.selectionStyle == .single ? index : nil
            }
            .compactMap { $0 }
    }()
    
    init(settings: [SettingsSectionViewModel]) {
        self.settings = settings
    }
    
    var numberOfSections: Int {
        return settings.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return settings[section].rows.count
    }
    
    func headerTitle(in section: Int) -> String? {
        return settings[section].title
    }
    
    func rowViewModel(for indexPath: IndexPath) -> RowViewModel {
        return settings[indexPath.section].rows[indexPath.row]
    }
    
    func shouldHighlightRow(at indexPath: IndexPath) -> Bool {
        return settings[indexPath.section].selectionStyle != .disable
    }
    
    func shouldDeselectWhenSelecting(at indexPath: IndexPath) -> Bool {
        return singleSelectionSections.contains(indexPath.section)
    }
    
    func indexPathsToDeselectWhenSelecting(at lastSelectedIndexPath: IndexPath, selectedIndexPaths: [IndexPath]) -> [IndexPath] {
        return selectedIndexPaths.filter {
            $0.section == lastSelectedIndexPath.section && $0.row != lastSelectedIndexPath.row
        }
    }
}
