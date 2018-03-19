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
#define LOGINUSER @"loginUsername"
#define LOGINUSER_TYPE @"loginUsertype"
#define LOGINUSER_AD @"advocate"
#define LOGINUSER_UR @"user"
static NSString* const API_BASE_URL = @"http://www.advok8.in/AdvocateAPI.asmx/";
static NSString* const API_CONTENTS_BASE_URL = @"http://www.advok8.in";

// Consult APIS
static NSString* const API_GET_ALL_POSTS = @"get_Consult_APK";
static NSString* const API_GET_ALL_POSTS_FROM_LIBRARY = @"get_LibPosts_APK";
static NSString* const API_LIKE_POST = @"put_like";
static NSString* const API_SAVE_DELETE_POST_LIBRARY = @"SaveDeleteLibrary";
static NSString* const API_FETCH_COMMENTS_FOR_POST = @"get_IndPostComment";
static NSString* const API_FETCH_POST_FOR_POST_ID = @"get_indConsult";
static NSString* const API_POST= @"post_Consult";
static NSString* const API_UPLOAD_FILE= @"UploadFile";
static NSString* const API_GET_OTP = @"generateOTP";
static NSString* const API_REGISTER_USER = @"postAdvocateDetailsSignUp";
static NSString* const API_LOGIN = @"GetLogin";



// Dashoboard APIS
static NSString* const API_GET_ALL_CATEGORIES = @"Get_AllCategory";
static NSString* const API_GET_ALL_SPECIALIZATION = @"Get_Specialization_API";
static NSString* const API_GET_SUB_CATEGORY = @"Get_Category";
static NSString* const API_GET_ALL_ADVOCATES_FOR = @"search_AdvocateWeb";
static NSString* const API_ADVOCATE_PUBLICDATA = @"GetAdvocatePublicData";

static int const like_tag = 1000;
static int const save_tag = 2000;
static int const comment_tag = 3000;
static int const share_tag = 4000;

//Color

#define Primary_Blue @"27328C"
#define Bullet @"\u2022"

#endif /* Constant_h */




