//
//  User.h
//  AdVok8
//
//  Created by Shagun Verma on 15/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *FirstName;
@property(nonatomic ,strong) NSString *LastName;
@property(nonatomic ,strong) NSString *AddLine1;
@property(nonatomic ,strong) NSString *ContactNo;
@property(nonatomic ,strong) NSString *EmailId;
@property(nonatomic ,strong) NSString *AddLine2;
@property(nonatomic ,strong) NSString *Street;
@property(nonatomic ,strong) NSString *Landmark;
@property(nonatomic ,strong) NSString *City;
@property(nonatomic ,strong) NSString *State;
@property(nonatomic ,strong) NSString *Country;
@property(nonatomic ,strong) NSString *Pincode;
@property(nonatomic ,strong) NSString *AlternateContactNo;
@property(nonatomic ,strong) NSString *OTP;
@property(nonatomic ,strong) NSString *OTPdatetime;
@property(nonatomic ,strong) NSString *Active;
@property bool PaidStatus;
@property(nonatomic ,strong) NSString *DOB;
@property(nonatomic ,strong) NSString *Gender;
@property(nonatomic ,strong) NSString *LastUpdated;
@property(nonatomic ,strong) NSString *CreatedDate;
@property(nonatomic ,strong) NSString *password;
@property(nonatomic ,strong) NSString *type;
@property(nonatomic ,strong) NSString *lastpassword;

@end
