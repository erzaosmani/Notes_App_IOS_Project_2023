import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func saveAction(_ sender: Any) {
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
	let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
	let newNote = Note(entity: entity!, insertInto: context)
	newNote.id = noteList.count as NSNumber
	newNote.title = titleTF.text
	newNote.desc = descTV.text
	do
		{
		try context.save()
		noteList.append(newNote)
		navigationController?.popViewController(animated: true)
		}
	    catch
		{
		print("context save error")
		}
	    
    }
}
	
