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
    private let application: UIApplication
    private lazy var menuItems: [MenuSectionViewModel] = {
        let shareImage: UIImage?
        let feedbackImage: UIImage?
        let writeReviewImage: UIImage?
        let contributeImage: UIImage?
        let donateImage: UIImage?
        if #available(iOS 13.0, *) {
            shareImage = UIImage(systemName: "square.and.arrow.up")
            feedbackImage = UIImage(systemName: "envelope")
            writeReviewImage = UIImage(systemName: "star")
            contributeImage = UIImage(systemName: "chevron.left.slash.chevron.right")
            donateImage = UIImage(systemName: "dollarsign.circle")
        } else {
            shareImage = #imageLiteral(resourceName: "shareIcon")
            feedbackImage = #imageLiteral(resourceName: "feedbackIcon")
            writeReviewImage = #imageLiteral(resourceName: "writeReviewIcon")
            contributeImage = #imageLiteral(resourceName: "contributeIcon")
            donateImage = #imageLiteral(resourceName: "donateIcon")
        }
        return [MenuSectionViewModel(title: "Decks",
                                     selectionType: .single,
                                     rows: [
                                        DeckRowViewModel(deck: .fibonacci, configuration: configuration),
                                        DeckRowViewModel(deck: .standar, configuration: configuration)
                ]),
                MenuSectionViewModel(title: "Preferences",
                                     selectionType: .multiple,
                                     rows: [
                                        PreferenceRowViewModel(preference: .shakeToReveal, configuration: configuration),
                                        PreferenceRowViewModel(preference: .shakeOnReveal, configuration: configuration)
                ]),
                MenuSectionViewModel(title: nil,
                                     selectionType: .single,
                                     rows: [
                                        ActionRowViewModel<MenuViewController>(text: "Share", image: shareImage, action: { [weak self] vc in
                                            self?.share()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Write a review", image: writeReviewImage, action: { [weak self] vc in
                                            self?.writeReview()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Feedback", image: feedbackImage, action: { [weak self] vc in
                                            self?.sendFeedback(from: vc)
                                        })
                ]),
                MenuSectionViewModel(title: nil,
                                     selectionType: .single,
                                     rows: [
                                        ActionRowViewModel<MenuViewController>(text: "Contribute", image: contributeImage, action: { [weak self] vc in
                                            self?.contribute()
                                        }),
                                        ActionRowViewModel<MenuViewController>(text: "Donate", image: donateImage, action: { [weak self] vc in
                                            self?.donate()
                                        }),
                ])
        ]
    }()
    
    weak var delegate: MenuViewModelDelegate?
    weak var viewDelegate: MenuViewModelViewDelegate?
    var versionText: String {
        return "Version \(appInformation.version) (\(appInformation.build))"
    }
    
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
            let message = "Please send an email to \(appInformation.feedbackEmail)"
            viewDelegate?.showAlert(title: nil, message: message, action: nil)
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
    
    private func share() {
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
