//
//  CheckPayment.h
//  AdVok8
//
//  Created by NetprophetsMAC on 8/18/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckPayment : NSObject
@property(nonatomic ) BOOL IsPaid;
@property(nonatomic ) BOOL allowAppealAdd;
@property(nonatomic ) BOOL allowCaseAdd;
@property(nonatomic ) BOOL allowDisplayBoard;
+(CheckPayment*) sharedInstance;
@end
