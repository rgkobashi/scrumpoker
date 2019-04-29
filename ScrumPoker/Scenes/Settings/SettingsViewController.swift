//
//  SettingsViewController.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/28.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsMultipleSelection = true
            tableView.register(SettingsCell.self)
        }
    }
    
    var viewModel: SettingsViewModel!
}

extension SettingsViewController: UITableViewDataSource {
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
        let cell: SettingsCell = tableView.dequeueReusableCell(for: indexPath)
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

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel.shouldHighlightRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        if viewModel.shouldDeselectIndexPathsWhenSelecting(at: indexPath), let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            viewModel
                .indexPathsToDeselectWhenSelecting(at: indexPath, selectedIndexPaths: selectedIndexPaths)
                .forEach {
                    tableView.deselectRow(at: $0, animated: true)
                }
        } else if viewModel.shouldDeselectItselfWhenSelecting(at: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
