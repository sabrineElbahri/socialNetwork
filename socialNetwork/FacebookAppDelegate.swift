//
//  FacebookAppDelegate.swift
//  socialNetwork
//
//  Created by Sabrine Elbahri on 12/09/16.
//  Copyright © 2016 3ie. All rights reserved.
//

import Foundation
import UIKit
import FacebookShare
import FacebookCore
import FacebookLogin


open class FacebookAppDelegate {
    public init() {}
    
    open func launch(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Void {
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    // swift 2
    open func openUrl(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //only for iOS 9.0 et + with swift3
    @available(iOS 9.0, *)
    open func openUrl(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open: url, options: options)
    }
    
    open func didBecomeActive(_ application: UIApplication) -> Void {
        AppEventsLogger.activate(application)
    }
}
