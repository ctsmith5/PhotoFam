//
//  Comment.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit
import CloudKit

class Comment {
    let text: String
    let timestamp: Date
    //Since a post object contains a reference to each of its comments, the post property here must be weak. This allows us to avoid any retain cycle between comment and post objects.
    weak var post: Post?
    //Comments must have a record ID to be saved to CloudKit
    let recordID: CKRecord.ID
    
    //This will generate a reference to each comments respective Post.  We can use this reference when saving commments to CloudKit
    var postReference: CKRecord.Reference? {
        guard let post = post else { return nil }
        return CKRecord.Reference(recordID: post.recordID, action: .deleteSelf)
    }
    
    init(text: String, post: Post, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.post = post
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord, post: Post){
        guard let text = ckRecord[CommentConstants.textKey] as? String,
            let timestamp = ckRecord[CommentConstants.timestampKey] as? Date else { return nil }
        self.init(text: text, post: post, timestamp: timestamp, recordID: ckRecord.recordID)
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return text.contains(searchTerm)
    }
}
