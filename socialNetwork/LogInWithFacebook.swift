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
    
    private var userInfo: NSDictionary?
    
    public init() {}
    
    public func login(vc: UIViewController, completed: (userInfo: NSDictionary?, cancelled: Bool, failed: Bool, declinePermissions: Bool, token: String?) -> Void) -> Void {
        
        let loginManager: LoginManager = LoginManager()
        
        loginManager.logIn([.PublicProfile, .Email], viewController: vc) { result -> Void in
            
            switch result {
            case .Cancelled:
                completed(userInfo: nil, cancelled: true, failed: false, declinePermissions: false, token: nil)
                debugPrint("Cancelled")
            case .Failed(let error):
                completed(userInfo: nil, cancelled: false, failed: true, declinePermissions: false, token: nil)
                debugPrint("error : \(error)")
            case .Success(let grantedPermissions, let declinedPermissions, _):
                debugPrint("granted permissions : \(grantedPermissions)")
                debugPrint("declined permissions : \(declinedPermissions)")

                if !declinedPermissions.isEmpty {
                    completed(userInfo: nil, cancelled: false, failed: false, declinePermissions: true, token: nil)
                }
                
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name"], httpMethod: .GET)
                
                graphRequest.start { (httpResponse, result) -> Void in
                    switch result {
                    case .Success(let response):
                        
                        let token = AccessToken.current?.authenticationToken
                        completed(userInfo: response.dictionaryValue!, cancelled: false, failed: false, declinePermissions: false, token: token)
                        
                        debugPrint("Graph Request Succeeded: \(response)")
                        debugPrint("dico : \(response.dictionaryValue)")
                        
                        
                    case .Failed(let error):
                        debugPrint("Graph Request Failed: \(error)")
                    }
                    
                }
                
            }
        }
    }
    
    public func loginWithCustomParameters(vc: UIViewController, readParameters: [String], requestParameters: [String : AnyObject],completed: (userInfo: NSDictionary?, cancelled: Bool, failed: Bool, declinePermissions: Bool) -> Void) -> Void {
        
        let loginManager: LoginManager = LoginManager()
        var readPermission: [ReadPermission]?
        
        for string in readParameters {
            switch string {
            case "PublicProfile":
                readPermission?.append(.PublicProfile)
                break
            case "UserFriends":
                readPermission?.append(.UserFriends)
                break
            case "Email":
                readPermission?.append(.Email)
                break
            default:
                readPermission?.append(.Custom("\(string)"))
                break
            }
        }
        
        loginManager.logIn(readPermission!, viewController: vc) { result -> Void in
            
            switch result {
            case .Cancelled:
                completed(userInfo: nil, cancelled: true, failed: false, declinePermissions: false)
                debugPrint("Cancelled")
            case .Failed(let error):
                completed(userInfo: nil, cancelled: false, failed: true, declinePermissions: false)
                debugPrint("error : \(error)")
            case .Success(let grantedPermissions, let declinedPermissions, _):
                debugPrint("granted permissions : \(grantedPermissions)")
                debugPrint("declined : \(declinedPermissions)")
                
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: requestParameters, httpMethod: .GET)
                
                graphRequest.start { (httpResponse, result) -> Void in
                    switch result {
                    case .Success(let response):
                        
                        completed(userInfo: response.dictionaryValue!, cancelled: false, failed: false, declinePermissions: false)
                        
                        debugPrint("Graph Request Succeeded: \(response)")
                        debugPrint("dico : \(response.dictionaryValue)")
                        
                        
                    case .Failed(let error):
                        debugPrint("Graph Request Failed: \(error)")
                    }
                    
                }
                
            }
        }
    }
    
    
    public func getFacebookIdFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo: NSDictionary) -> String {
        return "\(userInfo["id"]!)"
    }
    
    public func getUserEmailFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo: NSDictionary) -> String {
        return "\(userInfo["email"]!)"
    }
    
    public func getUserFirstNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo: NSDictionary) -> String {
        return "\(userInfo["first_name"]!)"
    }
    
    public func getUserLastNameFromUserInfoInTheCompletionHandlerFromLoginFunction(userInfo: NSDictionary) -> String {
        return "\(userInfo["last_name"]!)"
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