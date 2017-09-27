import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    
    @IBAction func viewAllRequests(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

