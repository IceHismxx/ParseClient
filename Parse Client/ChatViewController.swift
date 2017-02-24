//
//  ChatViewController.swift
//  Parse Client
//
//  Created by June Suh on 2/23/17.
//  Copyright © 2017 Kyle Leung. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var messageTextField: UITextField!
    
    
    @IBOutlet weak var messageTableView: UITableView!
    
    var refreshTimer : Timer?
    
    var messages : [PFObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if refreshTimer == nil
        {
            refreshTimer = Timer.scheduledTimer(timeInterval: 5,
                                                target: self,
                                                selector: "refresh",
                                                userInfo: nil,
                                                repeats: true)
            refresh()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if refreshTimer != nil
        {
            refreshTimer!.invalidate()
            refreshTimer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonTapped()
    {
        let messageString = messageTextField.text!
        
        let messageObj = PFObject(className: "Message")
        messageObj["text"] = messageString
        messageObj["user"] = PFUser.current()
        messageObj.saveInBackground { (succeeded: Bool, error : Error?) in
            if error != nil
            {
                print("message sage in background erro r= \(error!.localizedDescription )")
            }
            else if succeeded
            {
                print("succeeded message")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        cell.textLabel?.numberOfLines = 0
        let message = messages[indexPath.row]
        var messageString = message["text"] as! String?
        if message["user"] != nil
        {
            messageString = "\((message["user"] as! PFUser).username!) - \(messageString!)"
        }
        cell.textLabel?.text = messageString
        return cell
        
    }
    
    func refresh()
    {
        
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.limit = 20
        query.findObjectsInBackground { (objects : [PFObject]?, error : Error?) in
            if error == nil {
                self.messageTableView.reloadData()
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects
                    /*
                    for object in objects {
                        print(object.objectId)
                    }
                     */
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
        }

    }

}
