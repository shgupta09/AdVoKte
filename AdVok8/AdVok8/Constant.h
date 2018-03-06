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
static NSString* const API_FETCH_COMMENTS_FOR_POST = @"get_IndPostComment";
static NSString* const API_GET_OTP = @"generateOTP";
static NSString* const API_REGISTER_USER = @"postAdvocateDetailsSignUp";
static NSString* const API_LOGIN = @"GetLogin";

static int const like_tag = 1000;
static int const save_tag = 2000;
static int const comment_tag = 3000;
static int const share_tag = 4000;

#endif /* Constant_h */



