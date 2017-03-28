import UIKit
import CoreData

public class CoreDataDAO {
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = NSPersistentContainer(name: "CoreDataDAO")
        
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) -> Void in
            fatalError("\(error)")
        })
        
        return container
    }()
    
    func saveContext() {
        let viewContext = self.persistenceContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError(nserror.description)
            }
        }
    }
}
