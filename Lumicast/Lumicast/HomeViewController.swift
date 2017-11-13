import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    @IBAction func viewAllRequests(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func clickSubmit(_ sender: UIButton) {
        
        if emailText.text != "" && passwordText.text != ""{
            
            if segment.selectedSegmentIndex == 0{   // Login user
                
                FIRAuth.auth()?.signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    
                    if user != nil{
                        print("SUCCESS")
                        self.errorLabel.text = "You have logged in successfully"
                        self.errorLabel.textColor = UIColor.green
                        
                    }else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                            self.errorLabel.text = myError
                            self.errorLabel.textColor = UIColor.red
                        }else{
                            print("ERROR")
                            self.errorLabel.text = "Unexpected error"
                            self.errorLabel.textColor = UIColor.red
                        }
                    }
                
                
                })
                
            }else{
                
                FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    
                    if user != nil{
                        print("SUCCESS")
                        self.errorLabel.text = "You have been registered successfully"
                        self.errorLabel.textColor = UIColor.green
                        
                    }else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                            self.errorLabel.text = myError
                            self.errorLabel.textColor = UIColor.red
                        }else{
                            print("ERROR")
                            self.errorLabel.text = "Unexpected error"
                            self.errorLabel.textColor = UIColor.red
                        }
                    }

                    
                    
                })
                
            }
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func unwindToHomeViewController(segue: UIStoryboardSegue){
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

