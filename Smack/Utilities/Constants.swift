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
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"

//notification

let NOTI_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

//segues

let TO_LOGIN = "toLoginVC"
let TO_SIGNUP = "toSignUpVC"
let UNWIND_TO_CHANNEL = "unWindTochannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//user defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "LoggedIn"
let USER_EMAIL = "userEmail"
