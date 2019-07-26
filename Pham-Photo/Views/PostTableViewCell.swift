//
//  PostTableViewCell.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    
    
    
    var post: Post?{
        didSet{
            updateViews()
        }
    }
    
    func updateViews(){
        guard let post = post else {return}
        postPicture.image = post.photo
        captionLabel.text = post.caption
        commentCountLabel.text = "Comments: \(post.commentCount)"
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
