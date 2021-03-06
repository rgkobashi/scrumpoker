//
//  MenuViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit
import Reusable

class MenuViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Menu")
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsMultipleSelection = true
            tableView.tableFooterView = versionLabel
            tableView.register(cellType: MenuCell.self)
        }
    }
    
    var viewModel: MenuViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    private lazy var versionLabel: UILabel = {
        let l = UILabel()
        l.text = viewModel.versionText
        l.textAlignment = .center
        l.font = .systemFont(ofSize: 14)
        l.sizeToFit()
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = "MenuViewController.view"
    }
    
    private func deselectRestOfSection(for indexPath: IndexPath) {
        tableView
            .indexPathsForSelectedRows?.compactMap { $0 }
            .filter { $0.section == indexPath.section && $0.row != indexPath.row }
            .forEach { tableView.deselectRow(at: $0, animated: true) }
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tableView.dequeueReusableCell(for: indexPath)
        let vm = viewModel.rowViewModel(for: indexPath)
        cell.viewModel = vm
        switch vm.type {
        case .checkmark(let isSelected), .switch(let isSelected):
            if isSelected {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        case .unspecified:
            break
        }
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel.shouldEnableRegularRowSelection(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath, from: self)
        
        if viewModel.shouldDeselectAfterSelectingRow(at: indexPath) {
            if viewModel.shouldDeselectRestOfSectionAfterSelectingRow(at: indexPath) {
                deselectRestOfSection(for: indexPath)
            } else if viewModel.shouldDeselectItselfAfterSelectingRow(at: indexPath) {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.didDeselectRow(at: indexPath, from: self)
    }
}

extension MenuViewController: MenuViewModelViewDelegate {
    func showAlert(title: String?, message: String, action: (() -> Void)?) {
        showAlert(message: message, type: .informable(action: action))
    }
    
    func shareApp(_ url: URL) {
        showShareActivity(with: [url])
    }
}

extension MenuViewController: ViewControllerAlertable {}
extension MenuViewController: ViewControllerSharable {}
