import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var listTeams: Array<Dictionary<String, String>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!) as! Array<Dictionary<String, String>>!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")!
        
        let row = indexPath.row
        
        cell.textLabel?.text = listTeams[row]["name"]
        cell.imageView?.image = UIImage(named: listTeams[row]["image"]! + ".png")
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

