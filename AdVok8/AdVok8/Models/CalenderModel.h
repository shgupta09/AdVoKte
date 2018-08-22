//
//  CalenderModel.h
//  AdVok8
//
//  Created by NetprophetsMAC on 5/3/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderModel : NSObject
@property (nonatomic,strong) NSString * type;
@property(nonatomic ,strong) CaseList *caseObj;
@property(nonatomic ,strong) Event *eventObj;
@property(nonatomic , strong) CauseListModel *causeObj;
@end
