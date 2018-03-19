//
//  Education.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Education : NSObject
@property(nonatomic) int EducationId;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *FromYear;
@property(nonatomic ,strong) NSString *ToYear;
@property(nonatomic ,strong) NSString *College;
@property(nonatomic ,strong) NSString *DegreeName;
@end
