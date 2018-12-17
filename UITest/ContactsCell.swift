//
//  ContactsCell.swift
//  UITest
//
//  Created by Ahmed El-elaimy on 12/16/18.
//  Copyright © 2018 Ahmed El-elaimy. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
