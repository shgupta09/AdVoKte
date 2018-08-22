//
//  WorkingExperience.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkingExperience : NSObject
@property(nonatomic) int ExperienceId;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *Company;
@property(nonatomic ,strong) NSString *Duration;
@property(nonatomic ,strong) NSString *Designation;
@end
