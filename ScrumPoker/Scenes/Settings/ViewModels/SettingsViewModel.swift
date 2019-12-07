//
//  SettingsViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    private let settings: [SettingsSectionViewModel]
    private let configuration: Configuration
    
    init(settings: [SettingsSectionViewModel], configuration: Configuration) {
        self.settings = settings
        self.configuration = configuration
    }
    
    // MARK: - Data source
    
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
    
    // MARK: - Delegate
    
    func shouldEnableRegularRowSelection(at indexPath: IndexPath) -> Bool {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case let dvm as DeckRowViewModel:
            return configuration.selectedDeck != dvm.deck
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel:
            return true
        default:
            fatalError("Non existent row to enable: \(indexPath)")
        }
    }
    
    func shouldDeselectAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = settings[indexPath.section]
        switch vm.selectionType {
        case .single:
            return true
        case .multiple, .none:
            return false
        }
    }
    
    func shouldDeselectRestOfSectionAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return true
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel:
            return false
        default:
            fatalError("Non existent row to deselect rest of section: \(indexPath)")
        }
    }
    
    func shouldDeselectItselfAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return false
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel:
            return true
        default:
            fatalError("Non existent row to deselect itself: \(indexPath)")
        }
    }
    
    // MARK: Actions
    
    func didSelectRow(at indexPath: IndexPath) {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case let dvm as DeckRowViewModel:
            configuration.selectedDeck = dvm.deck
        case let pvm as PreferenceRowViewModel:
            configuration.setValue(true, for: pvm.preference)
        case let avm as ActionRowViewModel:
            avm.action()
        default:
            fatalError("Non existent row selected: \(indexPath)")
        }
    }
    
    func didDeselectRow(at indexPath: IndexPath) {
        let vm = settings[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            break
        case let pvm as PreferenceRowViewModel:
            configuration.setValue(false, for: pvm.preference)
        case is ActionRowViewModel:
            break
        default:
            fatalError("Non existent row deselected: \(indexPath)")
        }
    }
}