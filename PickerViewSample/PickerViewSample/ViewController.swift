import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    var pickerData: Dictionary<String, Array<String>>!
    var pickerProvincesData: Array<String>!
    var pickerCitiesData: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        self.pickerData = NSDictionary(contentsOfFile: plistPath!) as! Dictionary<String, Array<String>>
       
        pickerProvincesData = Array<String>()
        for key in pickerData.keys {
            pickerProvincesData.append(key)
        }
        
        
        self.pickerCitiesData = pickerData[pickerProvincesData[0]]
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onClick(_ sender: AnyObject) {
        
        let row1 = self.pickerView.selectedRow(inComponent: 0)
        let row2 = self.pickerView.selectedRow(inComponent: 1)
        
        let province = pickerProvincesData[row1]
        let city = pickerCitiesData[row2]
        
        self.label.text = province + " " + city
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.pickerProvincesData.count
        } else {
            return self.pickerCitiesData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return self.pickerProvincesData[row]
        } else {
            return self.pickerCitiesData[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            let selectedProvince = self.pickerProvincesData[row]
            self.pickerCitiesData = self.pickerData[selectedProvince]
            self.pickerView.reloadComponent(1)
        }
    }
}
