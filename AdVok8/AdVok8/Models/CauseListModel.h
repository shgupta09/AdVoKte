//
//  CauseListModel.h
//  AdVok8
//
//  Created by NetprophetsMAC on 5/3/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CauseListModel : NSObject
@property int CaseId;
@property int CaseNo;
@property int CaseTypeID;
@property int CaseYear;
@property int CauseID;
@property int CourtMasterId;
@property int CourtNo;


@property(nonatomic ,strong) NSString *BenchName;
@property(nonatomic ,strong) NSString *CaseSeqNo;
@property(nonatomic ,strong) NSString *CaseType;
@property(nonatomic ,strong) NSString *CauseListIds;
@property(nonatomic ,strong) NSString *CourtName;
@property(nonatomic ,strong) NSString *HearingDate;
@property(nonatomic ,strong) NSString *PetitionerAdvocate;
@property(nonatomic ,strong) NSString *PetitionerName;
@property(nonatomic ,strong) NSString *RespondentAdvocate;
@property(nonatomic ,strong) NSString *RespondentName;

@end
