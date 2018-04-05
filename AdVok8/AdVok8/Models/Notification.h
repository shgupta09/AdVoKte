//
//  Notification.h
//  AdVok8
//
//  Created by Shagun Verma on 20/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property(nonatomic ,strong) NSString *PostID;
@property(nonatomic ,strong) NSString *UserID;
@property(nonatomic ,strong) NSString *ToUserId;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *Like;
@property(nonatomic ,strong) NSString *share;
@property(nonatomic ,strong) NSString *comment;
@property(nonatomic ,strong) NSString *message;
@property(nonatomic ,strong) NSString *NotificationType;
@property(nonatomic ,strong) NSString *Detail;

@end
