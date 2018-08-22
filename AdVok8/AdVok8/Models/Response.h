//
//  Response.h
//  AdVok8
//
//  Created by Shagun Verma on 15/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property int Status;
@property(nonatomic ,strong) NSString *ErrMsg;
@property(nonatomic ,strong)  NSMutableArray* _adr;

@end
