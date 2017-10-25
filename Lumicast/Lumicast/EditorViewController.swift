import UIKit
import FirebaseDatabase
import MessageUI

class EditorViewController: UIViewController {
    
    var myList : [String] = []
    
    var editPost : [String: String?] = [:]
    
    var myPosition = Position.init();
    
    @IBOutlet weak var categoryTextField: UITextField!

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBAction func submit(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        myVC.incoming = categoryTextField.text!
        
        
        let key = String(arc4random_uniform(1000))
        //let roomNum = String(arc4random_uniform(1000))
        let roomNum = String(myPosition.x) + ", " + String(myPosition.y)
        let time = String(describing: Date())
        
        
        let request = ["id":key,
                       "category": categoryTextField.text!,
                       "details": detailsTextField.text!,
                       "room": roomNum,
                       "time": time,
                       "status": "Submitted"
        ]
        
        myVC.post = request
        
        
        // myVC.testList = myList
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

