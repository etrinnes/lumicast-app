//
//  AppDelegate.swift
//  Lumicast
//
//  Created by Liz Trinnes on 9/26/17.
//  Copyright © 2017 Liz Trinnes. All rights reserved.
//

import UIKit
import CoreData
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var aggTimer = Timer();
    var sLumicastSdk = LumicastSdk.init();
    //var mLumicastSdk = LumicastSdk.init();
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        

        //Initialize SDK
       
        var error : NSError?
        //mLumicastSdk!.initialize("Z4rZsmpK",eid: "default", configTag: "nil", lights: "./lights.json",error: &error)
        sLumicastSdk?.initializeSimulationMode("./testPostions.json", error: &error);
        if let myError = error{
            print(myError.localizedDescription);
        }
        
        sLumicastSdk!.enableForegroundPositioning(&error)
        if let myError = error{
            print(myError.localizedDescription);
        }
        
        //Aggregate Data Collection
        aggTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.sendAggData), userInfo: nil, repeats: true)
        /*
        if let path = Bundle.main.path(forResource: "lights", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonDictionary =  jsonResult as! Dictionary<String,Any>
                
                // print out key-value from json
                for (key, value) in jsonDictionary {
                    
                    print("\(key) - \(value) ")
                    
                }
                
                //Initialize SDK
                var error : NSError?
                var isInitialized = false
                
                 isInitialized = mLumicastSdk!.initialize("Z4rZsmpK", eid: "default", configTag: nil, lights: "./lights.json", error: &error)
                
                // -(void)onLumicastInitialized:(bool)success resultString:(NSString*)resultString;
                
              /*  var lumicastListener : LumicastEventListener
                
                var success = false
                var eventString : String = "test"
                
                lumicastListener = LumicastEventListener()
                
                lumicastListener.onLumicastInitialized(success, resultString: eventString as String!)
                
                
                print("Success from inititalized: \(success)")
                print("Result string? \(eventString)")*/
           
                
                
                if let myError = error{
                    print("### Error on SDK initialization.")
                    print(myError.localizedDescription);
                }
                print("Is initialized? \(isInitialized)")
            
                
                
                sleep(2);
                var error2 : NSError?
                let codeWord = mLumicastSdk!.getCentralFixtureCodeword()
                print("Code word: \(String(codeWord))")
                
                let test : NSDictionary = mLumicastSdk!.buildInfo() as NSDictionary
                print("##### ABOUT TO PRINT BUILD INFO")
                for (key, value) in test{
                    print("\(key): \(value)")
                }
                
                
                mLumicastSdk!.enableForegroundPositioning(&error2)
                if let myError = error2{
                    print("### Error on enabling foreground positioning.")
                    print(myError.localizedDescription);
                }
                
         //Aggregate Data Collection
         aggTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(AppDelegate.sendAggData), userInfo: nil, repeats: true)

            } catch {
                // handle error
            }
        }
        */
        
            FIRApp.configure()

            sendAggData()               //send location on application load
        
            return true
    }
    
    func sendAggData(){
        
        
        //let myPosition = Position.init()
        let myPosition2 = Position.init(position: 34, mapId: 4, x: 10.4, y: 12.3, z: 2.3, timestamp: 1600)
        let xLoc = String(myPosition2!.x)
        let yLoc = String(myPosition2!.y)
        
        var ref : FIRDatabaseReference?
        ref = FIRDatabase.database().reference().child("TestAggData");
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz1234567890"
        var key = ""
        for _ in 0 ..< 9 {
            let rand = arc4random_uniform(36);
            var nextChar = letters.character(at: Int(rand));
            key += NSString(characters: &nextChar, length: 1) as String
        }
        let time = String(describing: Date());
        let locPost = ["id":key,
                       "xLoc": xLoc,
                       "yLoc": yLoc,
                       "time": time,
                       ] as [String : Any]
        ref?.child(key).setValue(locPost)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        var error : NSError?
        sLumicastSdk!.disableForegroundPositioning(&error);
        if let myError = error{
            print(myError.localizedDescription);
        }
        sLumicastSdk!.enableBackgroundPositioning(&error);
        if let myError = error{
            print(myError.localizedDescription);
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        var error : NSError?
        sLumicastSdk!.disableBackgroundPositioning(&error);
        if let myError = error{
            print(myError.localizedDescription);
        }
        sLumicastSdk!.enableForegroundPositioning(&error);
        if let myError = error{
            print(myError.localizedDescription);
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
        aggTimer.invalidate()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Lumicast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

