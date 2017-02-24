//
//  LoginViewController.swift
//  Parse Client
//
//  Created by Kyle Leung on 2/23/17.
//  Copyright © 2017 Kyle Leung. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func signup() {
        var user = PFUser()
        user.username = emailField.text
        user.password = passField.text
        user.email = emailField.text
        // other fields can be set just like with PFObject

        
        user.signUpInBackground { (succeeded: Bool, error : Error?) in
            if error != nil
            {
                let errorString = error!.localizedDescription
                let alertView = UIAlertController(title:"Error", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertView, animated:true, completion: nil)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
        }
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
