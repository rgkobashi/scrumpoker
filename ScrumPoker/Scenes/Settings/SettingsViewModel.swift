//
//  SettingsViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

struct SettingsSectionViewModel {
    let title: String?
    let selectionStyle: TableSectionSelectionStyle
    let rows: [SettingsRowViewModel]
}

struct SettingsRowViewModel: TableRowViewModel {
    let text: String
    let type: TableRowType
    let isAutoDeselectable: Bool
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
    
    func rowViewModel(for indexPath: IndexPath) -> SettingsRowViewModel {
        return settings[indexPath.section].rows[indexPath.row]
    }
    
    func shouldHighlightRow(at indexPath: IndexPath) -> Bool {
        return settings[indexPath.section].selectionStyle != .disable
    }
    
    
    func shouldDeselectItselfWhenSelecting(at indexPath: IndexPath) -> Bool {
        return settings[indexPath.section].rows[indexPath.row].isAutoDeselectable
    }
    
    func shouldDeselectIndexPathsWhenSelecting(at indexPath: IndexPath) -> Bool {
        return singleSelectionSections.contains(indexPath.section)
    }
    
    func indexPathsToDeselectWhenSelecting(at lastSelectedIndexPath: IndexPath, selectedIndexPaths: [IndexPath]) -> [IndexPath] {
        return selectedIndexPaths.filter {
            $0.section == lastSelectedIndexPath.section && $0.row != lastSelectedIndexPath.row
        }
    }
}
