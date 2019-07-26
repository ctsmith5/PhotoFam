//
//  CommentTableViewCell.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/22/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
