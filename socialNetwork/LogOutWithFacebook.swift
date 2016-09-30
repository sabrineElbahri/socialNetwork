//
//  LogOutWithFacebook.swift
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

open class LogOutWithFacebook {
    public init() {}
    
    open func logOut() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
}
