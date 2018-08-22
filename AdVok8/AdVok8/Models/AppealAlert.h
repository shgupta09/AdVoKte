//
//  AppealAlert.h
//  AdVok8
//
//  Created by Shagun Verma on 14/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppealAlert : NSObject

@property(nonatomic ,strong) NSString *AppealId;
@property(nonatomic ,strong) NSString *CaseNo;
@property(nonatomic ,strong) NSString *CaseYear;
@property(nonatomic ,strong) NSString *CourtName;
@property(nonatomic ,strong) NSString *CaseType;
@property(nonatomic ,strong) NSString *JudgementData;
@property(nonatomic ,strong) NSString *EntryDate;
    
@end
