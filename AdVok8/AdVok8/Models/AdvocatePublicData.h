//
//  AdvocatePublicData.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvocatePublicData : NSObject
@property (nonatomic,strong) NSMutableArray *Rating;
@property (nonatomic,strong) NSMutableArray *AdvocateTime;
@property (nonatomic,strong) NSMutableArray *AdvocateDetails;
@property (nonatomic,strong) NSMutableArray *Education;
@property (nonatomic,strong) NSMutableArray *WorkingExperience;
@property (nonatomic,strong) NSMutableArray *Membership;
@property(nonatomic) int Status;
@property(nonatomic ,strong) NSString *Errormsg;
@end
