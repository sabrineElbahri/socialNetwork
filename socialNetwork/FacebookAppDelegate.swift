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


public class FacebookAppDelegate {
    public init() {}
    
    public func launchApplication(application: UIApplication, launchOption: [NSObject: AnyObject]?) -> Void {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOption)
    }
    
    public func didBecomeActiveApplication(application: UIApplication) -> Void {
        AppEventsLogger.activate(application)
    }
    
    public func openUrlApplication(application: UIApplication, openURL: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return ApplicationDelegate.shared.application(application, openURL: openURL, sourceApplication: sourceApplication, annotation: annotation)
    }
}