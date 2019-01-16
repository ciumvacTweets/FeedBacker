//
//  FeedbackTableViewController.swift
//  FeedBacker
//
//  Created by Victor Ciumac on 9/19/18.
//  Copyright © 2018 CV. All rights reserved.
//

import UIKit

class FeedbackTableViewController: UITableViewController {
    
    var items: [Feedback]!
    private var cellItems: [Feedback] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items.forEach { if $0.comment?.count ?? 0 > 0 { cellItems.append($0) } }
        cellItems.sort{ $0.comment!.count > $1.comment!.count }
        cellItems.append(totalFeedback())
    }
    
    private func totalFeedback() -> Feedback {
        let likes =  items.filter{$0.LikeStatus == true}.count
        let dislikes = items.filter{$0.LikeStatus == false}.count
        
        return Feedback(LikeStatus: false, comment: "Total: Likes \(likes), Dislikes \(dislikes)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = cellItems[indexPath.row].comment
        return cell
    }
}
