import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var textUserName: UITextField!

    @IBOutlet weak var textPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(_ sender: AnyObject) {
        if (self.textUserName.text == "admin" && self.textPassword.text == "admin") {
            NSLog("Enter...")
            self.textPassword.resignFirstResponder()
            self.textUserName.resignFirstResponder()
        }
    }
}

