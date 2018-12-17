

import UIKit
import Firebase


class Login: UIViewController {

    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pass.isSecureTextEntry = true

        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x:0, y:0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "chat")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: mail.text!, password: pass.text!) { (user, error) in
            self.reloadInputViews()
            if error != nil{
                print(error!)
            }
            else {
                    self.performSegue(withIdentifier: "SignIn", sender: self)
            }
        }
    }
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoSignUp", sender: self)
    }
    
   
}
