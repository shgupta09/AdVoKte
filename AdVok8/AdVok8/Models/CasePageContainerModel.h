//
//  CasePageContainerModel.h
//  AdVok8
//
//  Created by Shagun Verma on 10/05/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CasePageContainerModel : NSObject

@property (nonatomic,strong) NSMutableArray *CaseDetail;
@property (nonatomic,strong) NSMutableArray *CaseHistoryList;
@property (nonatomic,strong) NSMutableArray *CaseOrderList;
@property (nonatomic,strong) NSMutableArray *ContactList;
@property (nonatomic,strong) NSMutableArray *DocumentList;
@property (nonatomic,strong) NSMutableArray *TaskList;
@property (nonatomic,strong) NSMutableArray *objCauseListData;
@property (nonatomic,strong) NSMutableArray *WebLinkList;

@end
