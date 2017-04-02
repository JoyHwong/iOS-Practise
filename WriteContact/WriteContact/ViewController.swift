import UIKit
import Contacts

class ViewController: UITableViewController {
    
    var contactDAO: ContactDAO!
    var listContacts: Array<CNContact>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactDAO = ContactDAO()
        
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
            
            showContact.familyNameText = self.listContacts[indexPath.row].familyName
            showContact.givenNameText = self.listContacts[indexPath.row].givenName
        }
    }
    
}

