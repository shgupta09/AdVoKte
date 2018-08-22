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
#define BoolValueKey @"BoolValue"
#define AlertKey @"Alert"
#define USERDATA @"userData"

#define Cause_List_Data_Calender @"CauseListData"
#define Event_List_Data_Calender @"EventList"
#define Case_List_Data_Calender @"caseList"


static NSString* const API_BASE_URL = @"https://www.advok8.in/AdvocateAPI.asmx/";
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
static NSString* const API_DeleteUser = @"Deluser";
static NSString* const API_PUT_COMMENT = @"put_Comment";
static NSString* const API_GET_ALL_NOTIFICATIONS = @"get_NotificationUser";
static NSString* const API_SEARCH_USERS = @"search_users";
static NSString* const API_GET_POSTS_FOR_USER = @"get_Posts_APK";
static NSString* const API_GET_ALL_APPOINTMENTS_USER = @"get_UserAppointment";
static NSString* const API_GET_ALL_APPOINTMENTS_ADVOCATE = @"get_AdvocateAppointment";
static NSString* const API_GET_ALL_APPEAL_ALERTS = @"getAppealAlert";
static NSString* const API_Delete_APPEAL_ALERT = @"deleteAppealAlert";
static NSString* const API_Insert_APPEAL_ALERT = @"insertAppealAlert";
static NSString* const API_TO_GET_CASES = @"GetCauseListWithCase";
static NSString* const API_GET_ALL_Court = @"getcourtMaster";
static NSString* const API_GET_ALL_CaseType = @"getCasetypeMaster";
static NSString* const API_PUT_SHARE = @"put_Share";
static NSString* const API_GET_USER_DETAILS = @"GetUserDetail";
static NSString* const API_GET_TASK_LIST = @"getEvent";
static NSString* const API_GET_DISPLAYLIST = @"getDisplayBoard";
static NSString* const API_GET_LIKE_LIST = @"get_IndPostLikes";
static NSString* const API_BOOK_APPOINTMENT = @"BookAppointment";
static NSString* const API_DELETE_EVENT = @"DeleteEvent";
static NSString* const API_INSERT_UPDATE_EVENT = @"insertupdateEvent";
static NSString* const API_GET_ADVOCATE_CALENDAR = @"GetAdvDashboard";
static NSString* const API_GET_CASELIST = @"getcaseData";
static NSString* const API_GET_CauseListWithCase = @"GetCauseListWithCase";
static NSString* const API_Call_Request = @"callrequest";
static NSString* const API_GET_ADVOCATE_PROFILE = @"get_Advocate";
static NSString* const API_ADD_NEW_CASE = @"Ins_CaseReg";
static NSString* const API_GET_ACHEIVEMENT = @"getAcievement";
static NSString* const API_PUT_ACHEIVEMENT = @"putAcheivement";
static NSString* const API_SAVE_PROFILE = @"PutAdvocateUpdate";
static NSString* const API_PUT_AVAILABILITY = @"updateAdvocateAvailabilty";

// Dashoboard APIS
static NSString* const API_GET_ALL_CATEGORIES = @"Get_AllCategory";
static NSString* const API_GET_ALL_SPECIALIZATION = @"Get_Specialization_API";
static NSString* const API_GET_SUB_CATEGORY = @"Get_Category";
static NSString* const API_GET_ALL_ADVOCATES_FOR = @"search_AdvocateWeb";
static NSString* const API_ADVOCATE_PUBLICDATA = @"GetAdvocatePublicData";
static NSString* const API_RATING = @"InsertUpdateRating";
static NSString* const API_UPDATE_USER_PROFILE = @"UpdateUserRegistrationDetail";

//Changes
static NSString* const API_CHECK_PAYMENT = @"CheckUserPayment";


static int const like_tag = 1000;
static int const save_tag = 2000;
static int const comment_tag = 3000;
static int const share_tag = 4000;

// define macro
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
//Color

#define Primary_Blue @"27328C"
#define Bullet @"\u2022"

//PlaceHolder

#define PlaceHolder_TextView_Feedbck @"Tip: A great review explains why you are recommending the lawyer and support it with relevant stories which you think will be helpful to the user. Please write a minimum of 100 characters"

#define NO_INTERNET_MESSAGE @"No Network Connectivity"
//ProfilePic


#endif /* Constant_h */




