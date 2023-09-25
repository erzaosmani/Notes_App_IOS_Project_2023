import UIKit
import CoreData

class NoteDetailVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    
	var selectedNote: Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Customize the UITextField and UITextView
        titleTF.layer.borderWidth = 1.0
        titleTF.layer.borderColor = UIColor.blue.cgColor
        titleTF.layer.cornerRadius = 5.0 // Add rounded corners
        titleTF.backgroundColor = UIColor.white // Set the background color
        
        descTV.layer.borderWidth = 1.0
        descTV.layer.borderColor = UIColor.blue.cgColor
        descTV.layer.cornerRadius = 5.0
        descTV.backgroundColor = UIColor.white
        
        // Customize the Delete button
                deleteBtn.layer.borderWidth = 2.0
                deleteBtn.layer.borderColor = UIColor.blue.cgColor
                deleteBtn.layer.cornerRadius = 5.0
                deleteBtn.setTitleColor(UIColor.blue, for: .normal) // Set text color to red
        deleteBtn.backgroundColor = UIColor.white
        deleteBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        if selectedNote != nil {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
        
        // Set the background color of the whole view to light blue
        view.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
    }

    @IBAction func saveAction(_ sender: Any) {
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
    
    if(selectedNote == nil){
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
		} else{
			let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
			do {
				let results:NSArray = try context.fetch(request) as NSArray
				for result in results
				{
					let note = result as! Note
					if(note == selectedNote)
					{
						note.title = titleTF.text
						note.desc = descTV.text
						try context.save()
						navigationController?.popViewController(animated: true)
					}
				}
			}
			catch
			{
				print("Fetch Failed")
			}
		}

        let alertController = UIAlertController(title: "Note Saved", message: "Your note has been saved successfully.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)

    // Present the alert from the navigation controller if available, or from the current view controller
    if let navigationController = navigationController {
        navigationController.present(alertController, animated: true, completion: nil)
    } else {
        present(alertController, animated: true, completion: nil)
    }

    }
    
    @IBAction func DeleteNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! Note
                if(note == selectedNote)
                {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }   
        let alertController = UIAlertController(title: "Note Deleted", message: "Your note has been deleted.", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        // Navigate back after OK is pressed
        self.navigationController?.popViewController(animated: true)
    })
    alertController.addAction(okAction)

    // Present the alert from the navigation controller if available, or from the current view controller
    if let navigationController = navigationController {
        navigationController.present(alertController, animated: true, completion: nil)
    } else {
        present(alertController, animated: true, completion: nil)
    }
         }


}
	
