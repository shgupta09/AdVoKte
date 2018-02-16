//
//  PostModel.h
//  AdVok8
//
//  Created by Shagun Verma on 16/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property(nonatomic ,strong) NSString *UserId;
@property(nonatomic ,strong) NSString *PostUserId;
@property(nonatomic ,strong) NSString *TagUserId;
@property(nonatomic ,strong) NSString *PostPic;
@property(nonatomic ,strong) NSString *ShareId;
@property(nonatomic ,strong) NSString *PostNote;
@property(nonatomic ,strong) NSString *TagUserName;
@property(nonatomic ,strong) NSString *UserName;
@property(nonatomic ,strong) NSString *Type;
@property(nonatomic ,strong) NSString *PostId;
@property(nonatomic ,strong) NSString *cntlike;
@property(nonatomic ,strong) NSString *cntcmt;
@property(nonatomic ,strong) NSString *useractv;
@property(nonatomic ,strong) NSString *Details;
@property(nonatomic ,strong) NSString *Days;
@property(nonatomic ,strong) NSString *shareuid;
@property(nonatomic ,strong) NSString *sharefname;
@property(nonatomic ,strong) NSString *CreditScore;
@property(nonatomic ,strong) NSString *posttype;
@property(nonatomic ,strong) NSString *postsubtype;
@property(nonatomic ,strong)  NSMutableArray* Answer;//Question type
@property(nonatomic ,strong)  NSMutableArray* Answers;//String type
@property(nonatomic ,strong) NSString *corrAns;
@property(nonatomic ,strong) NSString *Liked;
@property(nonatomic ,strong) NSString *data;
@property(nonatomic ,strong) NSString *AcceptedSt;
@property int StrtPnt;
@property int EndPnt;
@property(nonatomic ,strong) NSString *ArticleTitle;
@property(nonatomic ,strong)  NSMutableArray* _reply;//Reply type
@property(nonatomic ,strong)  NSMutableArray* _cmtlikes;//Comment Like tYpr

@end
