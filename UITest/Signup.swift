//
//  ViewController.swift
//  UITest
//
//  Created by Ahmed El-elaimy on 12/13/18.
//  Copyright © 2018 Ahmed El-elaimy. All rights reserved.
//

import UIKit
import Firebase

class SignUp: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var rePass: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        pass.isSecureTextEntry = true
        
        rePass.isSecureTextEntry = true

        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "chat")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }

    @IBAction func signUp(_ sender: UIButton) {
        
        if pass.text! == rePass.text {
            Auth.auth().createUser(withEmail: mail.text!, password: pass.text!) { (user, error) in
                if error != nil {
                    print(error!)
                } else {
                    self.performSegue(withIdentifier: "SignUp", sender: self)
                }
            }
            let userInformation = Database.database().reference().child("UserInfo")
            var userInformationDictionary = ["fName": firstName.text!, "lName": lastName.text!, "email": mail.text!, "pass": pass.text!]
            userInformation.childByAutoId().setValue(userInformationDictionary)
            
            
        }
        
    }
    
}

