//
//  ViewController.swift
//  Lumicast
//
//  Created by Liz Trinnes on 9/19/17.
//  Copyright © 2017 Liz Trinnes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newRequestButton: UIButton!
    
    @IBOutlet weak var pastRequestButton: UIButton!
    
    @IBAction func clickNewRequest(_ sender: UIButton) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowList"{
            
           // let destination = segue.destination.childViewControllers[0] as! MasterViewController
            let destination = segue.destination.childViewControllers[0]
            
        }
        
    }


}

