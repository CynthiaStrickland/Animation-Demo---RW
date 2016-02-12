//
//  ViewController.swift
//  basic-uiview-animations
//
//  Created by Marin Todorov on 8/11/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit
import QuartzCore

//
// Util delay function
//
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {
    
    // MARK: ui outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further ui
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorization ...", "Sending credentials ...", "Failed"]
    
    // MARK: view controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        //add the button spinner
        spinner.frame = CGRect(x: -20, y: 6, width: 15, height: 15)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)

        //add the status banner
        status.hidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        //add the status label
        label.frame = CGRect(x: 0, y: 0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
    }

    //MARK:  ANIMATIONS
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //This moves the heading, username and password just outside the screen before it starts animating
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        loginButton.center.y += 30.0        //Moving a little bit down
        loginButton.alpha = 0.0             //Makes button invisible
        
//        loginButton.center.y += view.bounds.height
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut    , animations: {
            self.heading.center.x += self.view.bounds.width
            }, completion: nil )
        
                //Give username & password  a little delay
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            self.username.center.x += self.view.bounds.width
            }, completion: nil )
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: .CurveEaseOut, animations: {
            self.password.center.x += self.view.bounds.width
            }, completion: nil )
        
        UIView.animateWithDuration(4.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: {            
            
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
            }, completion: nil)
        
//        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
//            self.loginButton.center.y -= self.view.bounds.height
//            }, completion: nil )
    }
    
    @IBAction func login() {

        let b = self.loginButton.bounds
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options: .CurveEaseOut, animations: {
            
            //Enlarges LOGIN BUTTON each time it is pressed
            self.loginButton.bounds = CGRect(x: b.origin.x - 20, y: b.origin.y, width: b.size.width + 80, height: b.size.height)
            
            }, completion: {_ in
                self.showMessages(index: 0)
        })
        
            //This moves the login button down and puts spinner on the Login Button to the left.
        UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseIn, animations: {
            self.loginButton.center.y += 60
            self.spinner.alpha = 1.0
            self.spinner.center = CGPoint(x: 40, y: self.loginButton.frame.size.height/2)
            
            self.loginButton.backgroundColor = UIColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0)
            }, completion: nil)
    }
    
    func showMessages(index index: Int) {
        
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseIn, animations: {
            
            self.status.center.x += self.view.frame.size.width
            
            }, completion: {_ in
                
                self.status.hidden = true
                self.status.center.x -= self.view.frame.size.width
                self.label.text = self.messages[index]
                
                UIView.transitionWithView(self.status, duration: 0.3, options: [.CurveEaseOut, .TransitionCurlDown], animations: {
                    self.status.hidden = false
                    }, completion: {_ in
                        
                        delay(seconds: 2.0, completion: {
                        
                            if index < self.messages.count-1 {
                                self.showMessages(index: index+1)
                            }
                        })
                })
        })
    }
    
}


















