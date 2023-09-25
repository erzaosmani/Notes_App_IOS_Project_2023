import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupCellAppearance()
    }
    
    // Function to set up the cell's appearance
    private func setupCellAppearance() {
        self.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.textColor = UIColor.black
    }
}
