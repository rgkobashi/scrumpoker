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
    let rows: [TableRowViewModel]
}

struct DeckRowViewModel: TableRowViewModel {
    let deck: Deck
    let type: TableRowType
    var text: String {
        return deck.name
    }
}

struct PreferenceRowViewModel: TableRowViewModel {
    let text: String
    let type: TableRowType
}

struct RegularRowViewModel: TableRowViewModel {
    let text: String
    let type: TableRowType
}

// MARK: -

class SettingsViewModel {
    
    private let settings: [SettingsSectionViewModel]
    private let configuration: Configuration
    private lazy var singleSelectionSections: [Int] = {
        return settings
            .enumerated()
            .map { (index, setting) -> Int? in
                setting.selectionStyle == .single ? index : nil
            }
            .compactMap { $0 }
    }()
    
    init(settings: [SettingsSectionViewModel], configuration: Configuration) {
        self.settings = settings
        self.configuration = configuration
    }
    
    private func selectDeck(name: String) {
        switch name {
        case Deck.fibonacci.name:
            configuration.selectedDeck = .fibonacci
        case Deck.standar.name:
            configuration.selectedDeck = .standar
        default:
            // assign custom deck from DB
            fatalError("Selected deck does not exists")
        }
    }
    
    // MARK: Data source
    
    var numberOfSections: Int {
        return settings.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return settings[section].rows.count
    }
    
    func headerTitle(in section: Int) -> String? {
        return settings[section].title
    }
    
    func rowViewModel(for indexPath: IndexPath) -> TableRowViewModel {
        return settings[indexPath.section].rows[indexPath.row]
    }
    
    // MARK: Delegate
    
    func shouldHighlightRow(at indexPath: IndexPath) -> Bool {
        return settings[indexPath.section].selectionStyle != .disable
    }
    
    func didSelectRow(at indexPath: IndexPath) {
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
