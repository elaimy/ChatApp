
import UIKit
import Firebase

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    
    var messageArray : [Message] = [Message]()

    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var topButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: "ContactsCell", bundle: nil) , forCellReuseIdentifier: "ContactsCell")
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tableViewTapped))

        contactsTableView.addGestureRecognizer(tapGesture)
        configureTableView()
        
        
        retrieveMessages()
        
        contactsTableView.separatorStyle = .none

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! ContactsCell
        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.borderWidth = 3.0


        cell.Message.text = messageArray[indexPath.row].message
        cell.Name.text = messageArray[indexPath.row].sender
        
        if cell.Name.text == Auth.auth().currentUser?.email! {
            cell.Message.textAlignment = .right
            cell.Name.textAlignment = .right
        }
        else {
            cell.Message.textAlignment = .left
            cell.Name.textAlignment = .left
        }
    

       
        return cell
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func configureTableView() {
        contactsTableView.rowHeight = UITableView.automaticDimension
        contactsTableView.estimatedRowHeight = 600.0
        let tempImageView = UIImageView(image: UIImage(named: "chat"))
        tempImageView.frame = self.contactsTableView.frame
        self.contactsTableView.backgroundView = tempImageView;
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 308
//            self.view.layoutIfNeeded()
//        }
//    }
//
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.5) {
//            self.heightConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
//    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextfield.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Message saved successfully!")
            }
            self.messageTextfield.isEnabled = true
            self.sendButton.isEnabled = true
            self.messageTextfield.text = ""
        }
    }
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.message = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            
            self.configureTableView()
            self.contactsTableView.reloadData()
            
            
            
        }
        
    }
    
    
    
    
    
    

   

}
