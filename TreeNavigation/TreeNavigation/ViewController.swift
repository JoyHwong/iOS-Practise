import UIKit

class ViewController: UITableViewController {

    var dictData: Dictionary<String, Array<Dictionary<String, String>>>!
    var listData: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: plistPath!) as! Dictionary<String, Array<Dictionary<String, String>>>
        
        self.listData = Array<String>()
        for item in self.dictData {
            self.listData.append(item.key)
        }
        self.title = "Provinces"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = self.listData[row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowSelectedProvince") {
            let indexPath = self.tableView.indexPathForSelectedRow
            let selectedIndex = indexPath?.row
            let citiesViewController = segue.destination as! CitiesViewController
            let selectName = self.listData[selectedIndex!]
            citiesViewController.listData = self.dictData[selectName]
            citiesViewController.title = selectName
        }
    }
}

