import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var textUserId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func save(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {
            NSLog("Click Save button")
            
            var dataDict = Dictionary<String, String>()
            dataDict["userId"] = self.textUserId.text
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SignInCompletionNotification"), object: nil, userInfo: dataDict)
            
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            NSLog("Click Cancel button.")
        })
    }

}
