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
        cell.viewModel = viewModel.rowViewModel(for: indexPath)
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return viewModel.shouldHighlightRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else {
            return
        }
        guard viewModel.shouldDeselectWhenSelecting(at: indexPath) else {
            return
        }
        let indexPathsToDeselect = viewModel.indexPathsToDeselectWhenSelecting(at: indexPath, selectedIndexPaths: selectedIndexPaths)
        indexPathsToDeselect.forEach {
            tableView.deselectRow(at: $0, animated: true)
        }
    }
}
