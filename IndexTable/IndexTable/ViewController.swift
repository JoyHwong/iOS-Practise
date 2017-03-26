import UIKit

class ViewController: UITableViewController {
    
    var dictData: Dictionary<String, Array<String>>!
    var listGroupname: Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team_dictionary", ofType: "plist")
        
        self.dictData = NSDictionary(contentsOfFile: plistPath!) as! Dictionary<String, Array<String>>
        
        listGroupname = Array<String>()
        for data in self.dictData {
            listGroupname.append(data.key)
        }
        listGroupname.sort(by: <)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.listGroupname.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupName = self.listGroupname[section]
        return self.dictData[groupName]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")!
        
        let groupName = self.listGroupname[indexPath.section]
        
        cell.textLabel?.text = self.dictData[groupName]?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listGroupname[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitles = [String]()
        for item in self.listGroupname {
            listTitles.append("\(item[item.startIndex])")
        }
        return listTitles
    }
}

