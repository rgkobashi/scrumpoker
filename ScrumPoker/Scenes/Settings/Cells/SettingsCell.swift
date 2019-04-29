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
                break
            case let .switch(isSelected):
                let s = UISwitch()
                s.isOn = isSelected
                self.accessoryView = s
            case .action:
                break
            }
        }
    }
    
    private var rowType: TableRowType {
        return viewModel.type
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switch rowType {
        case .checkmark:
            self.accessoryType = selected ? .checkmark : .none
        case .switch:
            return
        case .action:
            return
        }
    }
}

extension SettingsCell: NibLoadableView {}
