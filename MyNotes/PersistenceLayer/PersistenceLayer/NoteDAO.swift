import UIKit
import CoreData

public class NoteDAO: CoreDataDAO {
    
    public func modify(model: Note) -> Int {
        let context = self.persistenceContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest) as! Array<NotesManagedObject>
            if listData.count > 0 {
                listData[0].content = model.content
                self.saveContext()
            }
        } catch {
            NSLog("Failure to update")
        }
        
        return 0
    }
    
    public func remove(model: Note) -> Int {
        let context = self.persistenceContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest) as! Array<NotesManagedObject>
            if (listData.count > 0) {
                context.delete(listData[0])
                self.saveContext()
            }
        } catch {
            NSLog("Failure to delete")
        }
        
        return 0
    }
    
    public func create(model: Note) -> Int {
        let context = self.persistenceContainer.viewContext
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! NotesManagedObject
        
        note.date = model.date
        note.content = model.content
        
        self.saveContext()
        return 0
    }
    
    public func findById(model: Note) -> Note? {
        let context = self.persistenceContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        fetchRequest.predicate = NSPredicate(format: "date = %@", model.date)
        
        do {
            let listData = try context.fetch(fetchRequest) as! Array<NotesManagedObject>
            
            if listData.count > 0 {
                return Note(date: listData[0].date!, content: listData[0].content!)
            }
            
        } catch {
            NSLog("Failure to query \(model.date) \(model.content)")
        }
        
        return nil
    }
    
    public func findAll() -> Array<Note>? {
        let context = self.persistenceContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let listData = try context.fetch(fetchRequest) as! Array<NotesManagedObject>
            var resListData = Array<Note>()
            if (listData.count > 0) {
                for item in listData {
                    resListData.append(Note(date: item.date!, content: item.content!))
                }
            }
            return resListData
        } catch {
            NSLog("Failure to query")
            return nil
        }
    }
}
