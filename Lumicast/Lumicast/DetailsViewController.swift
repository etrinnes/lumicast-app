import UIKit
import Foundation

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var timeSubmittedLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var information : String = ""
    
    var details : String = ""
    
    var room : String = ""
    
    var time : String = ""
    
    var status : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = information
        detailsLabel.text = details
        roomLabel.text = room
        timeSubmittedLabel.text = time
        statusLabel.text = status
        
    }
    
}
    
