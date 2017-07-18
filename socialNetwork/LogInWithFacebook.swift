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

open class LogInWithFacebook {
    
    fileprivate var userInfo: NSDictionary?
    
    public init() {}
    
    open func login(_ vc: UIViewController, completed: @escaping (_ userInfo: NSDictionary?, _ cancelled: Bool, _ failed: Bool, _ isDeclinePermissions: Bool) -> Void) -> Void {
        
        let loginManager: LoginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: vc) { result -> Void in
            switch result {
            case .cancelled:
                completed(nil, true, false, false)
                debugPrint("Cancelled")
            case .failed(let error):
                completed(nil, false, true, false)
                debugPrint("error : \(error)")
            case .success(let grantedPermissions, let declinedPermissions, _):
                debugPrint("granted permissions : \(grantedPermissions)")
                debugPrint("declined permissions : \(declinedPermissions)")

                if !declinedPermissions.isEmpty {
                    completed(nil, false, false, true)
                }
                
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name"], httpMethod: .GET)
                
                graphRequest.start { (httpResponse, result) -> Void in
                    switch result {
                    case .success(let response):
                        
                        completed(response.dictionaryValue! as NSDictionary?, false, false, false)
                        
                        debugPrint("Graph Request Succeeded: \(response)")
                        debugPrint("dico : \(String(describing: response.dictionaryValue))")
                        
                        
                    case .failed(let error):
                        debugPrint("Graph Request Failed: \(error)")
                    }
                    
                }
                
            }
        }
    }
    
    open func loginWithCustomParameters(_ vc: UIViewController, readParameters: [String], requestParameters: [String : AnyObject],completed: @escaping (_ userInfo: NSDictionary?, _ cancelled: Bool, _ failed: Bool, _ isDeclinePermissions: Bool, _ declinePermission: Set<Permission>?) -> Void) -> Void {
        
        let loginManager: LoginManager = LoginManager()
        var readPermission: [ReadPermission]?
        
        for string in readParameters {
            switch string {
            case "PublicProfile":
                readPermission?.append(.publicProfile)
                break
            case "UserFriends":
                readPermission?.append(.userFriends)
                break
            case "Email":
                readPermission?.append(.email)
                break
            default:
                readPermission?.append(.custom("\(string)"))
                break
            }
        }
                
        loginManager.logIn(readPermissions: readPermission!, viewController: vc) { result -> Void in
            
            switch result {
            case .cancelled:
                completed(nil, true, false, false, nil)
                debugPrint("Cancelled")
            case .failed(let error):
                completed(nil, false, true, false, nil)
                debugPrint("error : \(error)")
            case .success(let grantedPermissions, let declinedPermissions, _):
                debugPrint("granted permissions : \(grantedPermissions)")
                debugPrint("declined : \(declinedPermissions)")
                
                if !declinedPermissions.isEmpty {
                    completed(nil, false, false, true, declinedPermissions)
                }
                
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: requestParameters, httpMethod: .GET)
                
                graphRequest.start { (httpResponse, result) -> Void in
                    switch result {
                    case .success(let response):
                        
                        completed(response.dictionaryValue! as NSDictionary?, false, false, false, nil)
                        
                        debugPrint("Graph Request Succeeded: \(response)")
                        debugPrint("dico : \(String(describing: response.dictionaryValue))")
                        
                    case .failed(let error):
                        debugPrint("Graph Request Failed: \(error)")
                    }
                    
                }
                
            }
        }
    }
    
    
    open func getFacebookIdFromUserInfoInTheCompletionHandlerFromLoginFunction(_ userInfo: NSDictionary) -> String {
        return "\(userInfo["id"]!)"
    }
    
    open func getUserEmailFromUserInfoInTheCompletionHandlerFromLoginFunction(_ userInfo: NSDictionary) -> String {
        return "\(userInfo["email"]!)"
    }
    
    open func getUserFirstNameFromUserInfoInTheCompletionHandlerFromLoginFunction(_ userInfo: NSDictionary) -> String {
        return "\(userInfo["first_name"]!)"
    }
    
    open func getUserLastNameFromUserInfoInTheCompletionHandlerFromLoginFunction(_ userInfo: NSDictionary) -> String {
        return "\(userInfo["last_name"]!)"
    }
    
    open func getFacebookProfileImageUrl(_ facebookId: String?, profileImage: UIImage) -> UIImage? {
        if facebookId != nil {
            let url =  URL(string: "http://graph.facebook.com/\(facebookId!)/picture?type=normal")
            
            let data = try? Data(contentsOf: url!)
            
            if data != nil {
                return UIImage(data: data!)
            }
        }
        
        return nil
    }
    
    open func getFacebookProfileImageUrlAsync(_ facebookId: String?, completed: @escaping (_ image: UIImage) -> Void) -> Void {
        if facebookId != nil {
            let url =  URL(string: "http://graph.facebook.com/\(facebookId!)/picture?type=normal")
            DispatchQueue.global(qos: .background).async {
                let data = try? Data(contentsOf: url!)
                
                if data != nil {
                    completed(UIImage(data: data!)!)
                }
            }
        }
    }
    
}
