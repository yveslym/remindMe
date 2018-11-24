//
//  ReminderListTableViewCell.swift
//  remindMe
//
//  Created by Medi Assumani on 9/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class ReminderListTableViewCell: UITableViewCell {

    // - MARK: @IBOULETS
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderTypeLabel: UILabel! // Entry or Leave
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
