//
//  Membership.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Membership : NSObject
@property(nonatomic) int MembershipId;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *MembershipCompany;
@property(nonatomic ,strong) NSString *MembershipDuration;
@property(nonatomic ,strong) NSString *MembershipDesignation;
@end
