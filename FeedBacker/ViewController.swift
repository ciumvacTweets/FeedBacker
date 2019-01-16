//
//  ViewController.swift
//  FeedBacker
//
//  Created by Victor Ciumac on 9/19/18.
//  Copyright © 2018 CV. All rights reserved.
//

import UIKit

struct Feedback {
    let LikeStatus: Bool?
    let comment: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    private var feedbacks = [Feedback]()
    private var liked: Bool?
    private var tapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialSetup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FeedbackTableViewController {
            destination.items = feedbacks
        }
    }
    
    private func initialSetup(){
        submitButton.isEnabled = false
        commentTextField.delegate = self
    }
    
    @IBAction func likeButtonTap(_ sender: Any) {
        submitButton.isEnabled = true
        view.subviews.forEach{ if let button = $0 as? UIButton { button.isSelected = false } }
        (sender as? UIButton)?.isSelected = true
        liked = true
    }
    
    @IBAction func dislikeButtonTap(_ sender: Any) {
        submitButton.isEnabled = true
        view.subviews.forEach{ if let button = $0 as? UIButton { button.isSelected = false } }
        (sender as? UIButton)?.isSelected = true
        liked = false
    }
    
    @IBAction func submitButtonTap(_ sender: Any) {
        feedbacks.append(Feedback(LikeStatus: liked, comment: commentTextField.text))
        submitButton.isEnabled = false
        commentTextField.text = nil
        view.subviews.forEach{ if let button = $0 as? UIButton { button.isSelected = false } }
        liked = nil
    }

    @IBAction func hiddenButtotTap(_ sender: Any) {
        tapCount += 1
        if tapCount % 5 == 0 {
            performSegue(withIdentifier: "showFeedback", sender: nil)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let count = textField.text?.count, count > 1 {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = liked != nil
        }
        return true
    }
}
