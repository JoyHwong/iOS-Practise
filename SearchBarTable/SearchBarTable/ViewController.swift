import UIKit

class ViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    var listTeams: Array<Dictionary<String, String>>!
    
    var listFilterTeams: Array<Dictionary<String, String>>!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        self.listTeams = NSArray(contentsOfFile: plistPath!) as! Array<Dictionary<String, String>>
        
        filterContentForSearchText(searchText: "", scope: -1)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.scopeButtonTitles = ["中文", "English"]
        self.searchController.searchBar.delegate = self
        
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchBar.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFilterTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! CustomTableViewCell
        
        let row = indexPath.row
        
        cell.textLabel?.text = listFilterTeams[row]["name"]
        cell.imageView?.image = UIImage(named: listFilterTeams[row]["image"]! + ".png")
        cell.detailTextLabel?.text = listFilterTeams[row]["image"]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.updateSearchResults(for: self.searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        self.filterContentForSearchText(searchText: searchString!, scope: self.searchController.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText(searchText: String, scope: Int) -> Void {
        if (searchText.characters.count == 0) {
            self.listFilterTeams = self.listTeams
            return
        }
        
        if (scope == 0) {
            self.listFilterTeams = self.listTeams.filter({
                (team) -> Bool in
                return (team["name"]!.contains(searchText))
                
            })
        } else if (scope == 1) {
            self.listFilterTeams = self.listTeams.filter({
                (team) -> Bool in
                return team["image"]!.contains(searchText)
            })
        } else {
            self.listFilterTeams = self.listTeams
        }
    }
}

