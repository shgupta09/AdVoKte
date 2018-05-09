//
//  CaseList.h
//  AdVok8
//
//  Created by shubham gupta on 5/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseList : NSObject
@property(nonatomic ,strong) NSNumber  *mycaseId;
@property(nonatomic ,strong) NSNumber  *caseId;
@property(nonatomic ,strong) NSNumber *CaseTypeId;
@property(nonatomic ,strong) NSNumber *CourtId;
@property(nonatomic ,strong) NSNumber *appointmentId;
@property(nonatomic ,strong) NSString *unm;
@property(nonatomic ,strong) NSString *advid;
@property(nonatomic ,strong) NSString *rnm;
@property(nonatomic ,strong) NSString *radvnm;
@property(nonatomic ,strong) NSString *dof;
@property(nonatomic ,strong) NSString *lld;
@property(nonatomic ,strong) NSString *upcominghearingDate;
@property(nonatomic ,strong) NSString *dsc;
@property(nonatomic ,strong) NSString *dod;
@property(nonatomic ,strong) NSString *st;
@property(nonatomic ,strong) NSString *CourtName;
@property(nonatomic ,strong) NSString *CaseTypeName;
@property(nonatomic ,strong) NSString *CreatedOn;
@property(nonatomic ,strong) NSString *FileNo;
@property(nonatomic ,strong) NSString *RespondantName;
@property(nonatomic ,strong) NSString *RespondantAdvocateName;
@property(nonatomic ,strong) NSString *PetitionerAdvocateName;
@property(nonatomic ,strong) NSString *BilligRate;
@property(nonatomic ,strong) NSString *PetitionerName;
@property(nonatomic ,strong) NSString *Description;
@property(nonatomic ,strong) NSString *BillMethod;
@property(nonatomic ,strong) NSString *ClientDirection;
@property(nonatomic ,strong) NSString *Billable;
@property(nonatomic ,strong) NSString *BriefDesc;
@property(nonatomic ,strong) NSString *type;
@property(nonatomic ,strong) NSString *todate;
@property(nonatomic ,strong) NSString *fromdate;
@property(nonatomic ,strong) NSString *caseyear;
@property(nonatomic ,strong) NSString *caseact;
@property(nonatomic ,strong) NSString *ClientName;
@property(nonatomic ,strong) NSString *casetype;
@end
