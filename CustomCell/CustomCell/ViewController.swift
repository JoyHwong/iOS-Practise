import UIKit

class ViewController: UITableViewController {
    
    var listTeams: Array<Dictionary<String, String>>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!) as! Array<Dictionary<String, String>>
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! CustomTableViewCell
        
        let row = indexPath.row
        
        cell.myLabel.text = self.listTeams[row]["name"]
        cell.myImageView.image = UIImage(named: self.listTeams[row]["image"]! + ".png")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }
}

