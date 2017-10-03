import UIKit
import Foundation

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var information : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoLabel.text = information
    }
    
}
    
