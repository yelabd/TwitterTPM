//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Youssef Elabd on 3/6/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        textView.delegate = self
        
        TwitterClient.sharedInstance?.currentAccount(success: { (user: User) in
            
            self.frontImageView.layer.cornerRadius = 3
            self.frontImageView.clipsToBounds = true
            
            self.frontImageView.setImageWith((user.profileUrl)!)
            self.nameLabel.text = user.name
            self.handleLabel.text = "@\(user.screenname)"
            
          
            
            print(user.name)
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated:
            true, completion: nil)

    }
    
    func textView(_ shouldChangeTextIntextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count // for Swift use count(newText)
        countLabel.text = String(describing: numberOfChars)
        print(numberOfChars)
        return numberOfChars < 140;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
