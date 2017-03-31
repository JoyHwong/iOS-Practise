import UIKit

class ContactViewController: UIViewController {
    
    
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    @IBOutlet weak var email1: UITextField!
    @IBOutlet weak var email2: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var phoneText1: String!
    var phoneText2: String!
    var emailText1: String!
    var emailText2: String!
    var nameText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.phone1.text = self.phoneText1
        self.phone2.text = self.phoneText2
        self.email1.text = self.emailText1
        self.email2.text = self.emailText2
        self.name.text = self.nameText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
