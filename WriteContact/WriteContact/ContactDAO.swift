import Contacts

class ContactDAO {
    
    func findAllContacts() -> Array<CNContact> {
        let store = CNContactStore()
        
        let keyToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
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
    
    func findContactByName(name: String) -> Array<CNContact> {
        let store = CNContactStore()
        
         let keyToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
        let predict = CNContact.predicateForContacts(matchingName: name);
        do {
            return try store.unifiedContacts(matching: predict, keysToFetch: keyToFetch)
        } catch {
            return Array<CNContact>()
        }
    }
    
    func updateContact(contact: CNMutableContact) {
        let request = CNSaveRequest()
        request.update(contact)
        
        let store = CNContactStore()
        do {
          try  store.execute(request)
        } catch {
            NSLog("Error to update contact.")
        }
    }
}
