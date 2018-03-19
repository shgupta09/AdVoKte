//
//  DocumentModel.h
//  AdVok8
//
//  Created by Shagun Verma on 19/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentModel : NSObject

@property int DocId;//, value-0
@property int AppointId;// , value-0
@property int CaseId;// , value-0
@property(nonatomic ,strong) NSString *UploadedById;// , value-" "
@property(nonatomic ,strong) NSString *AttachmentName;// , value-" "
@property(nonatomic ,strong) NSString *viewFilename;// , value-File name With Extension
@property(nonatomic ,strong) NSString *AttachmentPath;// , value-Base64String
@property(nonatomic ,strong) NSString *UserName;// , value-Username
@property(nonatomic ,strong) NSString *cty;// , value-File Extension Without(.) like                                 jpg,png,etc,
@property(nonatomic ,strong) NSString *DocumentType;// , value-advocatepic/userpic
@property bool editable;// , value-false
@property(nonatomic ,strong) NSString *fileSize;//,value- Size of File

@end


