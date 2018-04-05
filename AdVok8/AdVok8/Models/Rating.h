//
//  Rating.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rating : NSObject
@property(nonatomic) int RatingId;
@property(nonatomic ) float *RatingFor;
@property(nonatomic ) float *UserRating;
@property(nonatomic ,strong) NSString *AdminRating;
@property(nonatomic ,strong) NSString *UserType;
@property(nonatomic ,strong) NSString *Feedback;
@property(nonatomic ,strong) NSString *CreatedBy;
@property(nonatomic ,strong) NSString *CreatedByName;
@property(nonatomic ,strong) NSString *Ans1;
@property(nonatomic ,strong) NSString *Ans3;
@end
