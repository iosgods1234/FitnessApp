//
//  WorkoutsViewController.swift
//  FitnessApp
//
//  Created by Anubhav Saxena on 3/21/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WorkoutsViewController: UIViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    

    var ref:DatabaseReference?
    var list = [String]()
    @IBOutlet weak var workoutTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        var databaseHandle: DatabaseHandle?
        databaseHandle = ref?.child("Exercises").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post{
                print(self.list)
                print(actualPost)
                self.list.append(actualPost)
                self.workoutTableView.reloadData()
            }
            
        })
        dump(list)
        
        //workoutTableView.delegate = self
        //workoutTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) {
        
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
