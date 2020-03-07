//
//  MenuViewModel.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

protocol MenuViewModelViewDelegate: class {
    func showAlert(title: String?, message: String, action: (() -> Void)?)
    func shareApp(_ url: URL)
}

protocol MenuViewModelDelegate: class {
    func didUpdateDeck(_ deck: Deck, from viewController: MenuViewController)
}

class MenuViewModel {
    private let appInformation: AppInformation
    private let feedbackSender: FeedbackSender
    private let configuration: Configuration
    private let analyticsManager: AnalyticsManager
    private let application: ApplicationType
    private lazy var menuItems: [TableSectionViewModel] = {
        return [TableSectionViewModel(title: "Decks",
                                      selectionType: .single,
                                      rows: [
                                        DeckRowViewModel(deck: .fibonacci, configuration: configuration),
                                        DeckRowViewModel(deck: .standar, configuration: configuration)
                ]),
                TableSectionViewModel(title: "Preferences",
                                      selectionType: .multiple,
                                      rows: [
                                        PreferenceBoolRowViewModel(preference: .shakeToReveal, configuration: configuration),
                                        PreferenceBoolRowViewModel(preference: .shakeOnReveal, configuration: configuration),
                                        PreferenceBoolRowViewModel(preference: .disableAutoLock, configuration: configuration)
                ]),
                TableSectionViewModel(title: nil,
                                      selectionType: .single,
                                      rows: [
                                        ActionRowViewModel<MenuViewController>(text: "Share", image: nil, action: { [weak self] vc in
                                            self?.share()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Feedback", image: nil, action: { [weak self] vc in
                                            self?.sendFeedback(from: vc)
                                        })
                ]),
                TableSectionViewModel(title: nil,
                                      selectionType: .single,
                                      rows: [
                                        ActionRowViewModel<MenuViewController>(text: "Write a review", image: nil, action: { [weak self] vc in
                                            self?.writeReview()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Contribute", image: nil, action: { [weak self] vc in
                                            self?.contribute()
                                        })
                ])
        ]
    }()
    
    weak var delegate: MenuViewModelDelegate?
    weak var viewDelegate: MenuViewModelViewDelegate?
    var versionText: String {
        return "Version \(appInformation.version)"
    }
    
    init(appInformation: AppInformation, feedbackSender: FeedbackSender, configuration: Configuration, analyticsManager: AnalyticsManager, application: ApplicationType = UIApplication.shared) {
        self.appInformation = appInformation
        self.feedbackSender = feedbackSender
        self.configuration = configuration
        self.analyticsManager = analyticsManager
        self.application = application
    }
    
    private func updateDeck(_ deck: Deck, from viewController: MenuViewController) {
        configuration.selectedDeck = deck
        analyticsManager.log(.selectedDeck(deck))
        delegate?.didUpdateDeck(deck, from: viewController)
    }
    
    private func selectPreferenceBool(_ preference: Preference<Bool>) {
        analyticsManager.log(.preferenceBool(preference, true))
        configuration.setValue(true, for: preference)
    }
    
    private func deselectPreferenceBool(_ preference: Preference<Bool>) {
        analyticsManager.log(.preferenceBool(preference, false))
        configuration.setValue(false, for: preference)
    }
    
    private func sendFeedback(from viewController: MenuViewController) {
        analyticsManager.log(.feedback)
        do {
            try feedbackSender.sendFeedback(.mail(recipients: [appInformation.feedbackEmail],
                                                  subject: "\(appInformation.name) v\(appInformation.version)",
                                                  message: "",
                                                  from: viewController))
        } catch {
            let message = "Please send an email to \(appInformation.feedbackEmail)"
            viewDelegate?.showAlert(title: nil, message: message, action: nil)
        }
    }
    
    private func contribute() {
        analyticsManager.log(.contribute)
        application.open(appInformation.contributeURL, options: [:], completionHandler: nil)
    }
    
    private func writeReview() {
        analyticsManager.log(.writeReview)
        application.open(appInformation.writeReviewURL, options: [:], completionHandler: nil)
    }
    
    private func share() {
        analyticsManager.log(.shareApp)
        viewDelegate?.shareApp(appInformation.appURL)
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
        case is PreferenceBoolRowViewModel:
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
        case is PreferenceBoolRowViewModel:
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
        case is PreferenceBoolRowViewModel:
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
        case let pvm as PreferenceBoolRowViewModel:
            selectPreferenceBool(pvm.preference)
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
        case let pvm as PreferenceBoolRowViewModel:
            deselectPreferenceBool(pvm.preference)
        case is ActionRowViewModel<MenuViewController>:
            fatalError("Deselecting ActionRowViewModel at \(indexPath) due its section allows multiple selection")
        default:
            fatalError("Non existent row deselected: \(indexPath)")
        }
    }
}
