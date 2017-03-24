import UIKit
import WebKit

class RootViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screen = UIScreen.main.bounds
        
        // Button bar
        let buttonBarWidth: CGFloat = 316
        let buttonBar = UIView(frame: CGRect(x: (screen.size.width - buttonBarWidth) / 2, y: 20, width: buttonBarWidth, height: 30))
        self.view.addSubview(buttonBar)
        
        // Add load html string button
        let buttonLoadHTMLString = UIButton(type: UIButtonType.system)
        buttonLoadHTMLString.setTitle("LoadHTMLString", for: UIControlState.normal)
        buttonLoadHTMLString.frame = CGRect(x: 0, y: 0, width: 117, height: 30)
        buttonLoadHTMLString.addTarget(self, action: #selector(RootViewController.testLoadHTMLString(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadHTMLString)
        
        // Add load data button
        let buttonLoadData = UIButton(type: UIButtonType.system)
        buttonLoadData.setTitle("LoadData", for: UIControlState.normal)
        buttonLoadData.frame = CGRect(x: 137, y: 0, width: 67, height: 30)
        buttonLoadData.addTarget(self, action: #selector(RootViewController.testLoadData(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadData)
        
        // add load request button
        let buttonLoadRequest = UIButton(type: UIButtonType.system)
        buttonLoadRequest.setTitle("LoadRequest", for: UIControlState.normal)
        buttonLoadRequest.frame = CGRect(x: 224, y: 0, width: 92, height: 30)
        buttonLoadRequest.addTarget(self, action: #selector(RootViewController.testLoadRequest(_:)), for: .touchUpInside)
        buttonBar.addSubview(buttonLoadRequest)
        
        // add WKWebView
        self.webView = WKWebView(frame: CGRect(x: 0, y: 60, width: screen.size.width, height: screen.size.height - 80))
        self.view.addSubview(self.webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testLoadHTMLString(_ sender: AnyObject) -> Void {
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let bundleUrl = NSURL.fileURL(withPath: Bundle.main.bundlePath)
        
        do {
            let html = try String(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8)
            self.webView.loadHTMLString(html, baseURL: bundleUrl)
        } catch let error as NSError {
            NSLog(error.description)
        }
    }
    
    func testLoadData(_ sender: AnyObject) -> Void {
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let bundleUrl = NSURL.fileURL(withPath: Bundle.main.bundlePath)
        do {
            let htmlData = try NSData(contentsOfFile: htmlPath!) as Data
            self.webView.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: bundleUrl)
        } catch let error as NSError {
            NSLog(error.description)
        }
    }
    
    func testLoadRequest(_ sender: AnyObject) -> Void {
        let url = URL(string: "https://joyhwong.com")
        let request = URLRequest(url: url!)
        self.webView.load(request)
        self.webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("Load Finish.")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("Start Loading.")
    }
}
