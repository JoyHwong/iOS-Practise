import UIKit
import Contacts

class ViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var contactDAO: ContactDAO!
    var listContacts: Array<CNContact>!
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactDAO = ContactDAO()

        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        
        DispatchQueue.global().async {
            self.listContacts = self.contactDAO.findAllContacts()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.tableView.reloadData()
        let searchBar = searchController.searchBar
        let searchText = searchBar.text
        if (searchText == nil || searchText?.characters.count == 0) {
            self.listContacts = self.contactDAO.findAllContacts()
        } else {
            self.listContacts = self.contactDAO.findContactByName(name: searchText!)
        }
        self.tableView.reloadData()
    }
    
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.listContacts == nil) {
            return 0
        }
        return self.listContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellIfentifier", for: indexPath)
        cell.textLabel?.text = "\(self.listContacts[indexPath.row].givenName)  \(self.listContacts[indexPath.row].familyName)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddContact") {
            
        } else if (segue.identifier == "ShowContact") {
            let showContact = segue.destination as! ShowContactViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            showContact.contact = self.listContacts[indexPath.row]
        }
    }
}
