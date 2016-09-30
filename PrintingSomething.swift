//
//  PrintingSomething.swift
//  
//
//  Created by Sabrine Elbahri on 09/09/16.
//
//

import Foundation
import UIKit
import SVProgressHUD
import FacebookShare
import FacebookLogin
import FacebookCore

open class PrintingSomething {
    
    public init () {
    }
    
    open func youhou() -> Void {
        print("social network")
        SVProgressHUD.showSuccess(withStatus: "Social Network")
    
    }
}
