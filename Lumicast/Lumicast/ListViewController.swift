import UIKit
import FirebaseDatabase

class ListViewController: UITableViewController {
    
    var incoming : String = ""
    
    var post : [String: String?] = [:]
    
    var postArray : [[String: String?]] = []
    
    var testList : [String] = []
    
    public var posts = [Post]()
    
    
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
        
        
        var blah : Position = Position()
        print(blah.mapId)
        
        let temp : LumicastSdk = LumicastSdk()
        
        
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ListViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myTableView.reloadData()
        
        
        var topic : String = ""
        var details : String = ""
        var id : String = ""
        var room : String = ""
        var time : String = ""
        var status : String = ""
        
        
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
                        if snap.key == "category"{
                            topic = snapVal as! String
                        }else if snap.key == "details"{
                            details = snapVal as! String
                        }else if snap.key == "id"{
                            id = snapVal as! String
                        }else if snap.key == "room"{
                            room = snapVal as! String
                        }else if snap.key == "time"{
                            time = snapVal as! String
                        }else if snap.key == "status"{
                            status = snapVal as! String
                        }
                        
                        self.posts.append(Post(topic, details, id, room, time, status))
                    }
                }
                
            }
            
        })
        
        
    }
    func findPost(_ indicator: String)->Post?{
    
        for post in posts{
            if(post.topic == indicator){
                return post
            }
        }
        return nil
    }
    
    func back(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        performSegue(withIdentifier: "ShowRequestDetails", sender: self)

    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("inside prepare for segue")
        if segue.identifier == "ShowRequestDetails"{
            print("We know the identifier...")
            if let path = self.tableView.indexPathForSelectedRow{

              //  let destination = segue.destination.childViewControllers[0] as! DetailsViewController

                let destination = segue.destination as! DetailsViewController
                let currentCell = tableView.cellForRow(at: path)! as UITableViewCell
                
                let currentPost : Post = findPost((currentCell.textLabel?.text)!)!
                
              // destination.information = (currentCell.textLabel?.text)!
                destination.information = currentPost.topic
                destination.details = currentPost.details
              //  destination.id = currentPost.id
                destination.room = currentPost.room
                destination.time = currentPost.time
                destination.status = currentPost.status
                
            }
            
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

