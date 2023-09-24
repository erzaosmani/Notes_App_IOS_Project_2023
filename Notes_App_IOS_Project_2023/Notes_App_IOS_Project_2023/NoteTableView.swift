import UIKit
 var noteList = [Note]()
class NoteTableView:UITableViewController{
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell

		let thisNote: Note!
		thisNote = noteList[indexPath.row]

		noteCell.titleLabel.text = thisNote.title
		noteCell.descLabel.text = thisNote.desc

		return noteCell
	}
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return noteList.count
	}
    
}
