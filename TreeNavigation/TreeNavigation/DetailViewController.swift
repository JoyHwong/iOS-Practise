import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var urlString: String!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        self.webView.navigationDelegate = self
        
//        let url = URL(string: self.urlString)
        let url = URL(string: "https://joyhwong.com")
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("Loaded")
    }
}
