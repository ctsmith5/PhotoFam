//
//  Post.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//


import UIKit
import CloudKit

class Post: SearchableRecord {
    
    var photoData: Data?
    let timestamp: Date
    var caption: String
    var comments: [Comment]
    var commentCount: Int = 0
    let recordID: CKRecord.ID
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirecotryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirecotryURL.appendingPathComponent(recordID.recordName).appendingPathExtension("jpg")
                do {
                    try photoData?.write(to: fileURL)
                } catch let error {
                    print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    
    var photo: UIImage? {
        get {
        guard let photoData = photoData else {return nil}
           return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photo: UIImage, caption: String, timestamp: Date = Date(), comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), commentCount: Int = 0) {
        self.caption = caption
        self.timestamp = timestamp
        self.comments = comments
        self.recordID = recordID
        self.commentCount = commentCount
        self.photo = photo
    }
    init?(ckRecord: CKRecord) {
        do{
            guard let caption = ckRecord[PostConstants.captionKey] as? String,
                let timestamp = ckRecord[PostConstants.timestampKey] as? Date,
                let photoAsset = ckRecord[PostConstants.photoKey] as? CKAsset,
                let commentCount = ckRecord[PostConstants.commentCountKey] as? Int
                else { return nil}
            
            let photoData = try Data(contentsOf: photoAsset.fileURL!)
            self.caption = caption
            self.timestamp = timestamp
            self.photoData = photoData
            self.recordID = ckRecord.recordID
            self.commentCount = commentCount
            self.comments = []
        }catch {
            print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
            return nil
        }
    }
    func matches(searchTerm: String) -> Bool {
        return self.caption.contains(searchTerm) ? true : false
    }
}

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: PostConstants.typeKey, recordID: post.recordID)
        self.setValue(post.caption, forKey: PostConstants.captionKey)
        self.setValue(post.timestamp, forKey: PostConstants.timestampKey)
        self.setValue(post.imageAsset, forKey: PostConstants.photoKey)
        self.setValue(post.commentCount, forKey: PostConstants.commentCountKey)
    }
    
    convenience init(comment: Comment) {
        self.init(recordType: CommentConstants.recordType, recordID: comment.recordID)
        self.setValue(comment.postReference, forKey: CommentConstants.postReferenceKey)
        self.setValue(comment.text, forKey: CommentConstants.textKey)
        self.setValue(comment.timestamp, forKey: CommentConstants.timestampKey)
    }
}

struct CommentConstants {
    static let recordType = "Comment"
    static let textKey = "text"
    static let timestampKey = "timestamp"
    static let postReferenceKey = "post"
}

struct PostConstants {
    static let typeKey = "Post"
    static let captionKey = "caption"
    static let timestampKey = "timestamp"
    static let commentsKey = "comments"
    static let photoKey = "photo"
    static let commentCountKey = "commentCount"
}

