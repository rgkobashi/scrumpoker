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
    let configuration: Configuration
    var text: String {
        return deck.name
    }
    var type: TableRowType {
        return .checkmark(configuration.selectedDeck == deck)
    }
}

struct PreferenceRowViewModel: TableRowViewModel {
    let preference: Preference<Bool>
    let configuration: Configuration
    var isSelected: Bool {
        return configuration.getValue(for: preference)
    }
    var text: String {
        return preference.name
    }
    var type: TableRowType {
        return .switch(isSelected)
    }
    
    func toggle() {
        configuration.setValue(!isSelected, for: preference)
    }
}

struct ActionRowViewModel: TableRowViewModel {
    let text: String
    let action: () -> ()
    var type: TableRowType {
        return .unspecified
    }
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
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return configuration.selectedDeck.name != vm.text
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel:
            return true
        default:
            fatalError("Non existent row selected")
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case let dvm as DeckRowViewModel:
            configuration.selectedDeck = dvm.deck
        case is PreferenceRowViewModel:
            break
        case let rvm as ActionRowViewModel:
            rvm.action()
        default:
            fatalError("Non existent row selected")
        }
    }
    
    func shouldDeselectItselfWhenSelecting(at indexPath: IndexPath) -> Bool {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return false
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel:
            return true
        default:
            fatalError("Non existent row selected")
        }
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
