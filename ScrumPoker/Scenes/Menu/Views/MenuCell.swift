//
//  MenuCell.swift
//  ScrumPoker
//
//  Created by Rogelio Kobashi on 2019/04/29.
//  Copyright © 2019 rgkobashi. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    var viewModel: TableRowViewModel! {
        didSet {
            self.textLabel?.text = viewModel.text
            self.textLabel?.adjustsFontSizeToFitWidth = true
            switch viewModel.type {
            case .checkmark:
                self.accessoryView = nil
                self.selectionStyle = .none
            case .switch:
                self.accessoryView = switchControl
                self.selectionStyle = .none
            case .unspecified(let image):
                self.accessoryView = UIImageView(image: image)
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

extension MenuCell: NibLoadableView {}
