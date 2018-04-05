//
//  Appointment.h
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appointment : NSObject

@property(nonatomic ,strong) NSString *AppId;
@property(nonatomic ,strong) NSString *advunm;
@property(nonatomic ,strong) NSString *userunm;
@property(nonatomic ,strong) NSString *fname;
@property(nonatomic ,strong) NSString *lname;
@property(nonatomic ,strong) NSString *date;
@property(nonatomic ,strong) NSString *Status;
@property(nonatomic ,strong) NSString *desc;
@property(nonatomic ,strong) NSString *time;
@property(nonatomic ,strong) NSString *count;
@property(nonatomic ,strong) NSString *contenttype;
@property(nonatomic ,strong) NSString *ViewFileName;
@property(nonatomic ,strong) NSString *AttachmentPath;
@property(nonatomic ,strong) NSString *FileSize;


@end
