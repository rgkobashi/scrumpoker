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
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SettingsCell: NibLoadableView {}
