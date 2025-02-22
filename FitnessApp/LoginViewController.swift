//
//  LoginViewController.swift
//  FitnessApp
//
//  Created by Pallav Kamojjhala on 3/19/18.
//  Copyright © 2018 Pallav Kamojjhala. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func didTap(_ sender: Any) {
         view.endEditing(true)
    }
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        UIView.animate(withDuration: 1.0) {
            self.headLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
        }
        
        UIView.animate(withDuration: 2.0) {
            self.headLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut],
                       animations: {
                        self.headLabel.center.y -= self.view.bounds.height - 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.headLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.45, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.headLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLogin(_ sender: Any) {
        print("entered")
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        print(username)
        
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if username == "" || password == "" {
                let alert = UIAlertController(title: "Failed!" , message: "No password or username", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            if let error = error {
                let alert = UIAlertController(title: "Failed!" , message: "Failed to Login", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func didSignup(_ sender: Any) {
        
        if usernameField.text == "" || passwordField.text == "" {
            let alert = UIAlertController(title: "Failed!" , message: "No password or username", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let newUser = PFUser()
      
        let username = usernameField.text
        let password = passwordField.text
        // set user properties
        
        newUser.username = username
        newUser.password = password
      //  print(newUser.username!)
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alert = UIAlertController(title: "Failed!" , message: "Failed to SignUp", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
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
