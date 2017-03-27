import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.signCompletion(notification:)), name: NSNotification.Name(rawValue: "SignInCompletionNotification"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        NotificationCenter.default.removeObserver(self)
    }

    func signCompletion(notification: Notification) {
        let theData = notification.userInfo! as! Dictionary<String, String>
        let username = theData["userId"]!;
        NSLog(username)
    }

}

