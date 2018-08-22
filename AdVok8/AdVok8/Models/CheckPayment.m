//
//  CheckPayment.m
//  AdVok8
//
//  Created by NetprophetsMAC on 8/18/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CheckPayment.h"

@implementation CheckPayment
static CheckPayment* _sharedInstance = nil;

+(CheckPayment*) sharedInstance
{
    @synchronized([CheckPayment class])
    {
        if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        
        return _sharedInstance;
    }
    return nil;
}

@end
