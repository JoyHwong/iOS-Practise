import Contacts

class ContactDAO {
    
    func findAllContacts() -> Array<CNContact> {
        let store = CNContactStore()
        
        let keyToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToFetch);
        
        var contacts = Array<CNContact>()
        do {
            
            try store.enumerateContacts(with: fetchRequest, usingBlock: {
                (contact,stop) -> Void in
                contacts.append(contact)
            })
        } catch {
            NSLog("Can't Find All Contacts.")
        }
        return contacts
    }
}
