import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screen = UIScreen.main.bounds
        
        let buttonAlertView = UIButton(type: UIButtonType.system)
        buttonAlertView.setTitle("Test AlertView", for: UIControlState.normal)
        
        let buttonAlertViewWidth: CGFloat = 100
        let buttonAlertViewHeight: CGFloat = 30
        let buttonAlertViewTopView: CGFloat = 130
        
        buttonAlertView.frame = CGRect(x: (screen.size.width - buttonAlertViewWidth) / 2, y: buttonAlertViewTopView, width: buttonAlertViewWidth, height: buttonAlertViewHeight)
        buttonAlertView.addTarget(self, action: #selector(ViewController.testAlertView(_:)), for: .touchUpInside)
        self.view.addSubview(buttonAlertView)
        
        
        let buttonActionSheet = UIButton(type: UIButtonType.system)
        buttonActionSheet.setTitle("Test ActionSheet", for: UIControlState.normal)
        
        let buttonActionSheetWidth: CGFloat = 150
        let buttonActionSheetHeight: CGFloat = 30
        let buttonActionSheetTopView: CGFloat = 260
        
        buttonActionSheet.frame = CGRect(x: (screen.size.width - buttonActionSheetWidth) / 2, y: buttonActionSheetTopView, width: buttonActionSheetWidth, height: buttonActionSheetHeight)
        buttonActionSheet.addTarget(self, action: #selector(ViewController.testActionSheet(_:)), for: .touchUpInside)
        self.view.addSubview(buttonActionSheet)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testAlertView(_ sender: AnyObject) -> Void {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "Alert text goes here", preferredStyle: UIAlertControllerStyle.alert)
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: {
            (alertAction) -> Void in
                NSLog("Tap No Button")
        })
        
        let yesAction = UIAlertAction(title: "YES", style: .default, handler: {
            (alertAction) -> Void in
                NSLog("Tap Yes Button")
        })
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func testActionSheet(_ sender: AnyObject) -> Void {
        let actionSheetController: UIAlertController = UIAlertController()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alertAction) -> Void in
                NSLog("Tap Cancel Button")
        })
        
        let destructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.destructive, handler: {
            (alertAction) -> Void in
                NSLog("Tap Destructive Button")
        })
        
        let otherAction = UIAlertAction(title: "Sina", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
                NSLog("Tap Sina Button")
        })
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(destructiveAction)
        actionSheetController.addAction(otherAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
}
