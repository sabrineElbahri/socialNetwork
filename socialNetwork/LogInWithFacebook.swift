//
//  LogInWithFacebook.swift
//  socialNetwork
//
//  Created by Sabrine Elbahri on 10/09/16.
//  Copyright © 2016 3ie. All rights reserved.
//

import Foundation
import UIKit
import FacebookShare
import FacebookCore
import FacebookLogin

public class LogInWithFacebook {
    
    private var userId: String?
    private var userEmail: AnyObject?
    private var userFirstName: AnyObject?
    private var userLastName: AnyObject?
    
    
    public init() {}
    
    public func login(vc: UIViewController) {
        
        let loginManager: LoginManager = LoginManager()
        
        loginManager.logIn([.PublicProfile, .UserFriends, .Email], viewController: vc) { result -> Void in
            
            let alertController: UIAlertController
            
            switch result {
            case .Cancelled:
                alertController = UIAlertController(title: "Connexion annulée", message: "", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
            case .Failed(let error):
                alertController = UIAlertController(title: "Echec de la connexion", message: "", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
                debugPrint("error : \(error)")
            case .Success(let grantedPermissions, _, _):
                debugPrint("granted permissions : \(grantedPermissions)")
                
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name"], httpMethod: .GET)
                
                graphRequest.start { (httpResponse, result) -> Void in
                    switch result {
                    case .Success(let response):
                        
                        debugPrint("id: \(response.dictionaryValue?["id"])")
                        if let userId: String = response.dictionaryValue?["id"] as? String {
                            self.userId = userId
                        }
                        if let userEmail: AnyObject = response.dictionaryValue?["email"] {
                            self.userEmail = userEmail
                        }
                        
                        if let userFirstName: AnyObject = response.dictionaryValue?["first_name"] {
                            self.userFirstName = userFirstName
                        }
                        
                        if let userLastName: AnyObject = response.dictionaryValue?["last_name"] {
                            self.userLastName = userLastName
                        }
                        
                        debugPrint("Graph Request Succeeded: \(response)")
                        debugPrint("dico : \(response.dictionaryValue)")

                        
                    case .Failed(let error):
                        debugPrint("Graph Request Failed: \(error)")
                    }

                }
                
            }
        }
    }

    
    public func getFacebookId() -> String {
        return userId!
        
    }
    
    public func getFacebookEmail() -> String {
        return userEmail! as! String
    }
    
    public func getFacebookFirstName() -> String {
        return userFirstName! as! String
    }
    
    public func getFacebookLastName() -> String {
        return userLastName as! String
    }
    

    public func getFacebookProfileImageUrl(facebookId: String?, profileImage: UIImage) -> UIImage? {
        if facebookId != nil {
            let url =  NSURL(string: "http://graph.facebook.com/\(facebookId!)/picture?type=normal")
            
                let data = NSData(contentsOfURL: url!)
            
                    if data != nil {
                        return UIImage(data: data!)
                    }
        }
        
        return nil
    }
    
    public func getFacebookProfileImageUrlAsync(facebookId: String?, completed: (image: UIImage) -> Void) -> Void {
        if facebookId != nil {
            let url =  NSURL(string: "http://graph.facebook.com/\(facebookId!)/picture?type=normal")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    let data = NSData(contentsOfURL: url!)
                    
                    if data != nil {
                        completed(image: UIImage(data: data!)!)
                    }
            }
        }
    }
    
}