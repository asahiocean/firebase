import Foundation
import CoreData
import Firebase

protocol CoreDataProtocol {
    var delegate: AppDelegate! { get }
    var context: NSManagedObjectContext! { get }
    /// Will store the identifier for the specified method
    func save(m method: AuthMethod, with value: AuthDataResult)
    /// Unloads the required objects from the database
    func load<T:NSManagedObject>(_ complation: @escaping (([T])->()))
}

class CoreData: CoreDataProtocol {
    
    weak var delegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    public static let shared = CoreData()
    
    func save(m method: AuthMethod, with value: AuthDataResult) {
        let object = Firebase(context: context)
        let key = method.title.letters.lowercased()
        object.setValue(value, forKey: key)
        let context = delegate.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
    
    func load<T:NSManagedObject>(_ complation: @escaping (([T])->())) {
        let request = T.fetchRequest() as! NSFetchRequest<T>
        request.returnsObjectsAsFaults = false
        // request.fetchLimit = 1
        
        // Creates asynchronous request with the fetch request and the completion closure
        let asyncFetch = NSAsynchronousFetchRequest(fetchRequest: request) { (results) in
            // Gets end result with array from Firebase entities
            guard let results = results.finalResult else { return }
            complation(results)
        }
        do {
            let context = delegate.persistentContainer.newBackgroundContext()
            try context.execute(asyncFetch)
        } catch let error as NSError {
            print("▸ NSAsynchronousFetchRequest error: \(error.localizedDescription)")
        }
    }
    
    fileprivate init() {
        delegate = (UIApplication.shared.delegate as! AppDelegate)
        context = delegate.persistentContainer.viewContext
    }
}
