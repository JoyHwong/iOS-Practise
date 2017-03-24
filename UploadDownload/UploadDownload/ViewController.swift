import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func startToMove(_ sender: AnyObject) {
        if (self.activityIndicatorView.isAnimating) {
            self.activityIndicatorView.stopAnimating()
        } else {
            self.activityIndicatorView.startAnimating()
        }
    }

    @IBAction func downloadProgress(_ sender: AnyObject) {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {
            (timer) ->Void in
            self.progressView.progress = self.progressView.progress + 0.1
            if (self.progressView.progress == 1.0) {
                timer.invalidate()
                
                let alertController: UIAlertController = UIAlertController(title: "download completed! ", message: "", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
}

