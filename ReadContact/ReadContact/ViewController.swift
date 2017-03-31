import UIKit
import Contacts

class ViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var searchController: UISearchController!
    var listContacts: Array<CNContact>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.delegate = self
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchBar.sizeToFit()
        
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
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            self.listContacts = self.findAllContacts()
            self.tableView.reloadData()
        } else {
            let searchName = searchController.searchBar.text
            self.listContacts = self.findContactsByName(searchName: searchName)
            self.tableView.reloadData()
        }
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.listContacts == nil) {
            return 0
        }
        return self.listContacts.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContact" {
            let contactViewController = segue.destination as! ContactViewController
            let indexpath = self.tableView.indexPathForSelectedRow!
            let contact = self.listContacts[indexpath.row];
            contactViewController.nameText = "\(contact.familyName) \(contact.givenName)"
            for emailProperty in contact.emailAddresses {
                if emailProperty.label == CNLabelWork {
                    contactViewController.emailText1 = emailProperty.value as String
                } else if emailProperty.label == CNLabelHome {
                    contactViewController.emailText2 = emailProperty.value as String
                }
            }
            for phoneProperty in contact.phoneNumbers {
                if phoneProperty.label == CNLabelPhoneNumberMobile {
                    contactViewController.phoneText1 = phoneProperty.value.stringValue
                } else if phoneProperty.label == CNLabelPhoneNumberiPhone {
                    contactViewController.phoneText2 = phoneProperty.value.stringValue
                }
            }
        }
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
        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
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
        let keysToFetch = [CNContactFamilyNameKey, CNContactGivenNameKey, CNLabelHome, CNLabelWork] as [CNKeyDescriptor]
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

