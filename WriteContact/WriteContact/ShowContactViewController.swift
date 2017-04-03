import UIKit
import Contacts

class ShowContactViewController: UITableViewController {

    @IBOutlet weak var givenName: UITextField!
    @IBOutlet weak var familyName: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var iphone: UITextField!
    @IBOutlet weak var homeEmail: UITextField!
    @IBOutlet weak var workEmail: UITextField!
    
    var contact: CNContact!
    var contactDAO: ContactDAO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.givenName.text = contact.givenName
        self.familyName.text = contact.familyName
        for item in contact.phoneNumbers {
            if item.label == CNLabelHome {
                self.iphone.text = item.value.stringValue
            } else if item.label == CNLabelPhoneNumberMobile {
                self.mobile.text = item.value.stringValue
            }
        }
       
        for item in contact.emailAddresses {
            if item.label == CNLabelHome {
                self.homeEmail.text = "\(item.value)"
            } else if item.label == CNLabelWork {
                self.workEmail.text = "\(item.value)"
            }
        }
        
        self.contactDAO = ContactDAO()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    @IBAction func onClick(_ sender: Any) {
        let newContact = CNMutableContact()
        
        let newMobile = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: self.mobile.text!))
        
        let newIphone = CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: self.iphone.text!))
        newContact.phoneNumbers = [newMobile, newIphone]
        
        self.contactDAO.updateContact(contact: newContact)
    }
    
}
