//
//  Case.h
//  AdVok8
//
//  Created by Shagun Verma on 11/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Case : NSObject

@property(nonatomic) int mycaseId;
@property(nonatomic ,strong) NSString *caseId;
@property(nonatomic ,strong) NSString *PetitionerName;
@property(nonatomic ,strong) NSString *advid;
@property(nonatomic ,strong) NSString *rnm;
@property(nonatomic ,strong) NSString *radvnm;
@property(nonatomic ,strong) NSString *dof;
@property(nonatomic ,strong) NSString *lld;
@property(nonatomic ,strong) NSString *upcominghearingDate;
@property(nonatomic ,strong) NSString *dsc;
@property(nonatomic ,strong) NSString *dod;
@property(nonatomic ,strong) NSString *st;
@property(nonatomic ,strong) NSString *caseyear;
@property(nonatomic ,strong) NSString *casetype;
@property(nonatomic ,strong) NSString *caseact;
@property(nonatomic) int appointmentId;
@property(nonatomic ,strong) NSString *fromdate;
@property(nonatomic ,strong) NSString *todate;
@property(nonatomic ,strong) NSString *type;
@property(nonatomic ,strong) NSString *BriefDesc;
@property(nonatomic ,strong) NSString *ClientDirection;
@property(nonatomic ,strong) NSString *Description;

@end
