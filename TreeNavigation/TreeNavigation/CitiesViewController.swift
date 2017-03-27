import UIKit

class CitiesViewController: UITableViewController {
    
    var listData: Array<Dictionary<String, String>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let row = indexPath.row
        cell.textLabel?.text = self.listData[row]["name"]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowSelectedCity") {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.urlString = self.listData[indexPath.row]["url"]
            detailViewController.title = self.listData[indexPath.row]["name"]
            
        }
    }
}
