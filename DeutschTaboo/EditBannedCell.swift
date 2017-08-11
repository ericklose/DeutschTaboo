//
//  EditBannedCell.swift
//  DeutschTaboo
//
//  Created by Eric Klose on 6/23/17.
//  Copyright © 2017 Eric Klose. All rights reserved.
//

import UIKit

class EditBannedCell: UITableViewCell {
    
    @IBOutlet weak var editBannedWordTextField: UITextField!
    @IBOutlet weak var editBannedEnglishTextField: UITextField!
    @IBOutlet weak var editBannedDifficulty: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(bannedWord: BannedWord) {
        self.editBannedWordTextField.text = "Loaded"
        self.editBannedEnglishTextField.placeholder = "write here"
        editBannedDifficulty.text = "3"
        
    }

}
