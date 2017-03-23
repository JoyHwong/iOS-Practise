import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!    
    
    @IBOutlet weak var sliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchValueChanged(_ sender: AnyObject) {
        let withSwitch = sender as! UISwitch
        let setting = withSwitch.isOn
        
        self.leftSwitch.setOn(setting, animated: true)
        self.rightSwitch.setOn(setting, animated: true)
    }
    
    @IBAction func touchDown(_ sender: AnyObject) {
        let segmentControl = sender as! UISegmentedControl
        
        if segmentControl.selectedSegmentIndex == 0 {
            self.leftSwitch.isHidden = false
            self.rightSwitch.isHidden = false
        } else {
            self.leftSwitch.isHidden = true
            self.rightSwitch.isHidden = true
        }
    }
    
    @IBAction func sliderValueChange(_ sender: AnyObject) {
        let slider = sender as! UISlider
        self.sliderValue.text = String(format: "%d", Int(slider.value))
    }
}
