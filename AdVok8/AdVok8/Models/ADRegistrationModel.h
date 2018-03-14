//
//  ADRegistrationModel.h
//  AdVok8
//
//  Created by Shagun Verma on 15/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADRegistrationModel : NSObject

@property(nonatomic ,strong) NSString *username;
@property(nonatomic ,strong) NSString *password;
@property(nonatomic ,strong) NSString *fname;
@property(nonatomic ,strong) NSString *lname;
@property(nonatomic ,strong) NSString *address;
@property(nonatomic ,strong) NSString *mobile;
@property(nonatomic ,strong) NSString *profPic;
@property(nonatomic ,strong) NSString *OTP;
@property int id;
@property(nonatomic ,strong) NSString *BarCodeId;
@property(nonatomic ,strong) NSString *Addline;
@property(nonatomic ,strong) NSString *EmailId;
@property(nonatomic ,strong) NSString *Addline2;
@property(nonatomic ,strong) NSString *Street;
@property(nonatomic ,strong) NSString *Landmark;
@property(nonatomic ,strong) NSString *City;
@property(nonatomic ,strong) NSString *State;
@property(nonatomic ,strong) NSString *Country;
@property(nonatomic ,strong) NSString *Pincode;
@property(nonatomic ,strong) NSString *AlternateMobile;
@property(nonatomic ,strong) NSString *AOP;
@property(nonatomic ,strong) NSString *DOB;
@property(nonatomic ,strong) NSString *Dsc;
@property(nonatomic ,strong) NSString *Education;
@property(nonatomic ,strong) NSString *Experience;
@property(nonatomic ,strong) NSString *PA;
@property(nonatomic ,strong) NSString *Gender;
@property(nonatomic ,strong) NSString *PSD;
@property(nonatomic ,strong) NSString *ConsultancyFees;

@end

