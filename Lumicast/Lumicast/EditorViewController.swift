import UIKit
import FirebaseDatabase

class EditorViewController: UIViewController {
    
    var myList : [String] = []
    
    var editPost : [String: String?] = [:]
    
    @IBOutlet weak var categoryTextField: UITextField!

    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBAction func submit(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        myVC.incoming = categoryTextField.text!
        
        let key = String(arc4random_uniform(1000))
        let roomNum = String(arc4random_uniform(1000))
        let time = String(describing: Date())
        
        
        
        //creating artist with the given values
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
