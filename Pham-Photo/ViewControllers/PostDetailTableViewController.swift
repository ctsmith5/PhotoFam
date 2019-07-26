//
//  PostDetailTableViewController.swift
//  Pham-Photo
//
//  Created by Colin Smith on 7/21/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var postPicture: UIImageView!
    
    var post: Post? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let post = post else {return}
        PostController.shared.fetchComments(for: post) { (comments) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
                guard let comments = comments else {return}
                post.comments = comments
            }
        }
    }

    func updateViews(){
        guard let post = post else {return}
        postPicture.image = post.photo
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let post = post else {return 0}
        return post.comments.count
    }

    @IBAction func postCommentButtonPressed(_ sender: UIButton) {
        guard let postToAppend = post else {return}
        let commentAlert = UIAlertController(title: "Add New Comment", message: "What would you like to say about this photo?", preferredStyle: .alert)
        commentAlert.addTextField { (textfield) in
            textfield.placeholder = "Enter Comment"
        }
        
        let postAction = UIAlertAction(title: "Post", style: .default) { (post) in
            //here we will use this completion block to take the text field string and append it as a comment
            guard let newCommentText = commentAlert.textFields?.first?.text else {return}
            if newCommentText != "" {
                PostController.shared.addComment(with: newCommentText, to: postToAppend) { (comment) in
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            commentAlert.dismiss(animated: true, completion: nil)
        }
        
        commentAlert.addAction(cancelAction)
        commentAlert.addAction(postAction)
        present(commentAlert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell else {return UITableViewCell()}
        let comment = post?.comments[indexPath.row]
        cell.bodyTextLabel.text = comment?.text
        cell.timestampLabel.text = comment?.timestamp.formatDate()
        cell.userLabel.text = "hardcoded"
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
