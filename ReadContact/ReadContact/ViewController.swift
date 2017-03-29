import UIKit
import Contacts

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var listContacts: Array<CNContact>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.searchBar.delegate = self
        
        DispatchQueue.global(qos: .background).async {
            self.listContacts = self.findAllContacts()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchName = searchBar.text
        self.listContacts = self.findContactsByName(searchName: searchName)
        self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.listContacts == nil) {
            return 0
        }
        return self.listContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")!
        
        let contact = self.listContacts[indexPath.row]
        let firstName = contact.givenName
        let lastName = contact.familyName
        
        cell.textLabel?.text = "\(firstName) \(lastName)"
        
        return cell
    }
    
    func findAllContacts() -> Array<CNContact> {
        var contacts = Array<CNContact>()
        let keysToFetch = [CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        let contactStore = CNContactStore()
        
        do {
            try contactStore.enumerateContacts(with: request, usingBlock: {
                (contact, stop) -> Void in
                contacts.append(contact)
            })
        } catch let error as NSError {
            NSLog(error.localizedDescription)
        }
        
        return contacts
    }
    
    func findContactsByName(searchName: String?) -> Array<CNContact> {
        if (searchName == nil || searchName?.characters.count == 0) {
            return self.findAllContacts()
        }
        
        let predicate = CNContact.predicateForContacts(matchingName: searchName!)
        let keysToFetch = [CNContactFamilyNameKey as CNKeyDescriptor, CNContactGivenNameKey as CNKeyDescriptor]
        let contactStore = CNContactStore()
        do {
            let contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            return contacts
        } catch {
            NSLog("\(error.localizedDescription)")
            return self.findAllContacts()
        }
    }
}

