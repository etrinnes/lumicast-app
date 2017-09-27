import UIKit
import FirebaseDatabase

class ListViewController: UITableViewController {
    
    var incoming : String = ""
    
    var post : [String: String?] = [:]
    
    var postArray : [[String: String?]] = []
    
    var testList : [String] = []
    
    
    @IBOutlet var myTableView: UITableView!

    
    var ref : FIRDatabaseReference?
    var handle : FIRDatabaseHandle?
    
    override func viewDidAppear(_ animated: Bool) {
        print(testList)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return myList.count
        return testList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //  cell.textLabel?.text = myList[indexPath.row]
        cell.textLabel?.text = testList[indexPath.row]
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if incoming != ""{
            ref?.child("list").childByAutoId().setValue(incoming)
            incoming = ""
        }
        
        if !(post.isEmpty){
            
            ref = FIRDatabase.database().reference().child("list");
            
            //generating a new key inside lists node
            //and also getting the generated key
            let key = ref?.childByAutoId().key
            
            ref?.child(key!).setValue(post)
            
            post = [:]
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ListViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTableView.reloadData()
        
        ref = FIRDatabase.database().reference()
        
        handle = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            
            if let item = snapshot.value as? String{
                
                self.testList.append(item)
                self.myTableView.reloadData()
                
            }else{
                // Print all non-string items to the console
                for childSnap in  snapshot.children.allObjects {
                    print("New child!")
                    let snap = childSnap as! FIRDataSnapshot
                    if let snapshotValue = snapshot.value as? NSDictionary, let snapVal = snapshotValue[snap.key] as Any? {
                        print("\(snap.key): \(snapVal)")
                    }
                }
                
            }
            
        })
        
        
    }
    
    func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
