//
//  Constant.h
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define isLoggedIn @"isLoggedIn"
static NSString* const API_BASE_URL = @"http://www.advok8.in/AdvocateAPI.asmx/";

// Consult APIS
static NSString* const API_GET_ALL_POSTS = @"get_Consult_APK";
static NSString* const API_GET_ALL_POSTS_FROM_LIBRARY = @"get_LibPosts_APK";
static NSString* const API_LIKE_POST = @"put_like";
static NSString* const API_SAVE_DELETE_POST_LIBRARY = @"SaveDeleteLibrary";
static NSString* const API_GET_OTP = @"generateOTP";
static NSString* const API_REGISTER_USER = @"postAdvocateDetailsSignUp";
static NSString* const API_LOGIN = @"GetLogin";


#endif /* Constant_h */


