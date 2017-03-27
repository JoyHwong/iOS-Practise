import UIKit

class ViewController: UITableViewController {

    var dictData: Dictionary<String, Array<Dictionary<String, String>>>!
    var listData: Array<Dictionary<String, String>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "provinces_cities", ofType: "plist")
        self.dictData = NSDictionary(contentsOfFile: plistPath!) as! Dictionary<String, Array<Dictionary<String, String>>>
        
        let navigationController = self.parent as! UINavigationController
        let selectProvinces = navigationController.tabBarItem.title!
        
        if (selectProvinces == "Hei Long Jiang") {
            self.listData = self.dictData["黑龙江省"]
            self.navigationItem.title = "Hei Long Jiang"
        } else if (selectProvinces == "Ji Lin") {
            self.listData = self.dictData["吉林省"]
            self.navigationItem.title = "Ji Lin"
        } else {
            self.listData = self.dictData["辽宁省"]
            self.navigationItem.title = "Liao Ning"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        cell.textLabel?.text = self.listData[indexPath.row]["name"]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetail") {
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.urlString = self.listData[indexPath.row]["url"]
            detailViewController.title = self.listData[indexPath.row]["name"]
        }
    }
}

