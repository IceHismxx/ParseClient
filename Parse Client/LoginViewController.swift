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
    
    @IBAction func signUpButtonTapped(_ sender: UIButton)
    {
        var user = PFUser()
        user.username = emailField.text
        print("emailField.text = \(emailField.text)")
        user.password = passField.text
        print("passField.text = \(passField.text)")
        user.email = emailField.text
        print("emailField.text = \(emailField.text)")
        
        // other fields can be set just like with PFObject

        
        user.signUpInBackground { (succeeded: Bool, error : Error?) in
            if error != nil
            {
                /* show alert controller with error string */
                let errorString = error!.localizedDescription
                let alertController = UIAlertController(title:"Error", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
                let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) {
                    (result : UIAlertAction) -> Void in
                    print("Destructive")
                }
                
                // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                alertController.addAction(DestructiveAction)
                alertController.addAction(okAction)
                
                self.present(alertController, animated:true, completion: nil)
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
                print("sign up succeeded")
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton)
    {
        let username = emailField.text!
        print("emailField.text = \(emailField.text)")
        let password = passField.text!
        print("passField.text = \(passField.text)")
        
        let user = PFUser.logInWithUsername(inBackground: username, password: password)
        print("user = \(user)")
        
        if (PFUser.current()?.isAuthenticated)!
        {
            print("current user authenticated")
            self.presentChatVC()
        }
    }
    
    func presentChatVC()
    {
        performSegue(withIdentifier: "modalSegue", sender: nil)
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
