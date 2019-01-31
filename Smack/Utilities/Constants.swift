//
//  Constants.swift
//  Smack
//
//  Created by Zeyad Taher on 1/28/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import Foundation

typealias ComplitionHandler = (_ Success : Bool) -> ()

// URL constants

let BASE_URL = "https://smack-chat-app-zeyad.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//segues

let TO_LOGIN = "toLoginVC"
let TO_SIGNUP = "toSignUpVC"
let UNWIND_TO_CHANNEL = "unWindTochannel"

//user defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "LoggedIn"
let USER_EMAIL = "userEmail"
