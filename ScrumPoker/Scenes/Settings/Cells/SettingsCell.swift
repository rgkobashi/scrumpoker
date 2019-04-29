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
            switch rowType {
            case .checkmark:
                self.accessoryView = nil
            case .switch:
                self.accessoryView = switchControl
            case .unspecified:
                self.accessoryView = nil
            }
        }
    }
    
    private var rowType: TableRowType {
        return viewModel.type
    }
    
    private lazy var switchControl: UISwitch = {
        let s = UISwitch()
        s.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        return s
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switch rowType {
        case .checkmark:
            self.accessoryType = selected ? .checkmark : .none
        case .switch:
            switchControl.isOn = selected
        case .unspecified:
            break
        }
    }
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        self.isSelected = sender.isOn
    }
}

extension SettingsCell: NibLoadableView {}
