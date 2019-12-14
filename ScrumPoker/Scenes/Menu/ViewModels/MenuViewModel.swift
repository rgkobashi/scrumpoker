//
//  MenuViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol MenuViewModelDelegate: class {
    func didUpdateDeck(_ deck: Deck, from viewController: MenuViewController)
}

class MenuViewModel {
    private let appInformation: AppInformation
    private let feedbackSender: FeedbackSender
    private let configuration: Configuration
    private let application: UIApplication
    private lazy var menuItems: [MenuSectionViewModel] = {
        return [MenuSectionViewModel(title: nil, // Decks
                                     selectionType: .single,
                                     rows: [
                                        DeckRowViewModel(deck: .fibonacci, configuration: configuration),
                                        DeckRowViewModel(deck: .standar, configuration: configuration)
                ]),
                MenuSectionViewModel(title: nil, // Preferences
                                     selectionType: .multiple,
                                     rows: [
                                        PreferenceRowViewModel(preference: .shakeToReveal, configuration: configuration),
                                        PreferenceRowViewModel(preference: .shakeOnReveal, configuration: configuration)
                ]),
                MenuSectionViewModel(title: nil,
                                     selectionType: .single,
                                     rows: [
                                        ActionRowViewModel<MenuViewController>(text: "Feedback", action: { [weak self] vc in // TODO localize
                                            self?.sendFeedback(from: vc)
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Contribute", action: { [weak self] vc in // TODO localize
                                            self?.contribute()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Write a review", action: { [weak self] vc in // TODO localize
                                            self?.writeReview()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Donate", action: { [weak self] vc in // TODO localize
                                            self?.donate()
                                        })
                ])
        ]
    }()
    
    weak var delegate: MenuViewModelDelegate?
    
    init(appInformation: AppInformation, feedbackSender: FeedbackSender, configuration: Configuration, application: UIApplication = .shared) {
        self.appInformation = appInformation
        self.feedbackSender = feedbackSender
        self.configuration = configuration
        self.application = application
    }
    
    private func updateDeck(_ deck: Deck, from viewController: MenuViewController) {
        configuration.selectedDeck = deck
        delegate?.didUpdateDeck(deck, from: viewController)
    }
    
    private func sendFeedback(from viewController: MenuViewController) {
        do {
            try feedbackSender.sendFeedback(.mail(recipients: [appInformation.feedbackEmail],
                                                  subject: "[\(appInformation.name) v\(appInformation.version) (\(appInformation.build))]", // TODO review this subject
                                                  message: "",
                                                  from: viewController))
        } catch {
            // TODO
        }
    }
    
    private func contribute() {
        application.open(appInformation.contributeURL, options: [:])
    }
    
    private func writeReview() {
        application.open(appInformation.writeReviewURL, options: [:])
    }
    
    private func donate() {
        application.open(appInformation.donateURL, options: [:])
    }
}

// MARK: - Data Source

extension MenuViewModel {
    var numberOfSections: Int {
        return menuItems.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return menuItems[section].rows.count
    }
    
    func headerTitle(in section: Int) -> String? {
        return menuItems[section].title
    }
    
    func rowViewModel(for indexPath: IndexPath) -> TableRowViewModel {
        return menuItems[indexPath.section].rows[indexPath.row]
    }
}

// MARK: - Delegate

extension MenuViewModel {
    func shouldEnableRegularRowSelection(at indexPath: IndexPath) -> Bool {
        let vm = menuItems[indexPath.section].rows[indexPath.row]
        switch vm {
        case let dvm as DeckRowViewModel:
            return configuration.selectedDeck != dvm.deck
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel<MenuViewController>:
            return true
        default:
            fatalError("Non existent row to enable: \(indexPath)")
        }
    }
    
    func shouldDeselectAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = menuItems[indexPath.section]
        switch vm.selectionType {
        case .single:
            return true
        case .multiple:
            return false
        }
    }
    
    func shouldDeselectRestOfSectionAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = menuItems[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return true
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel<MenuViewController>:
            return false
        default:
            fatalError("Non existent row to deselect rest of section: \(indexPath)")
        }
    }
    
    func shouldDeselectItselfAfterSelectingRow(at indexPath: IndexPath) -> Bool {
        let vm = menuItems[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            return false
        case is PreferenceRowViewModel:
            return false
        case is ActionRowViewModel<MenuViewController>:
            return true
        default:
            fatalError("Non existent row to deselect itself: \(indexPath)")
        }
    }
    
    // MARK: Actions
    
    func didSelectRow(at indexPath: IndexPath, from viewController: MenuViewController) {
        let vm = menuItems[indexPath.section].rows[indexPath.row]
        switch vm {
        case let dvm as DeckRowViewModel:
            updateDeck(dvm.deck, from: viewController)
        case let pvm as PreferenceRowViewModel:
            configuration.setValue(true, for: pvm.preference)
        case let avm as ActionRowViewModel<MenuViewController>:
            avm.action(viewController)
        default:
            fatalError("Non existent row selected: \(indexPath)")
        }
    }
    
    func didDeselectRow(at indexPath: IndexPath, from viewController: MenuViewController) {
        let vm = menuItems[indexPath.section].rows[indexPath.row]
        switch vm {
        case is DeckRowViewModel:
            fatalError("Deselecting DeckRowViewModel at \(indexPath) due its section allows multiple selection")
        case let pvm as PreferenceRowViewModel:
            configuration.setValue(false, for: pvm.preference)
        case is ActionRowViewModel<MenuViewController>:
            fatalError("Deselecting ActionRowViewModel at \(indexPath) due its section allows multiple selection")
        default:
            fatalError("Non existent row deselected: \(indexPath)")
        }
    }
}
