//
//  SettingsCell.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var viewModel: TableRowViewModel! {
        didSet {
            self.textLabel?.text = viewModel.text
            self.selectionStyle = .none
            switch viewModel.type {
            case .checkmark:
                self.accessoryView = nil
            case .switch:
                self.accessoryView = switchControl
            case .unspecified:
                self.accessoryView = nil
            }
        }
    }
    
    private lazy var switchControl: UISwitch = {
        let s = UISwitch()
        s.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        return s
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switch viewModel.type {
        case .checkmark:
            self.accessoryType = selected ? .checkmark : .none
        case .switch:
            (self.accessoryView as? UISwitch)?.isOn = selected
        case .unspecified:
            break
        }
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch) { // needed to treat switch changes as if the cell was selected/unselected
        guard let tv = self.superview as? UITableView, let ip = tv.indexPath(for: self) else {
            fatalError("Unable to cast self.superview as UITableView or get indexPath")
        }
        setSelected(sender.isOn, animated: true)
        if sender.isOn {
            tv.delegate?.tableView?(tv, didSelectRowAt: ip)
        } else {
            tv.delegate?.tableView?(tv, didDeselectRowAt: ip)
        }
    }
}

extension SettingsCell: NibLoadableView {}
