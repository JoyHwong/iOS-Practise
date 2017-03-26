import UIKit

class ViewController: UITableViewController {

    var log: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.log = Array()
        self.log.insert("\(Date())", at: 0)
        
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "下拉刷新")
        rc.addTarget(self, action: #selector(ViewController.refreshTableView), for: UIControlEvents.valueChanged)
        self.refreshControl = rc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refreshTableView() {
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        
        self.log.insert("\(Date())", at: 0)
        
        self.refreshControl?.endRefreshing()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.log.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")!
        
        cell.textLabel?.text = self.log[indexPath.row]
        
        return cell
    }
    
}

