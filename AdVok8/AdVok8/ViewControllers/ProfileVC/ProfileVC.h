//
//  ProfileVC.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/7/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbl_View;
@property(nonatomic)BOOL isFromMyActivity;
@property (nonatomic,strong) NSString* userId;
@property bool isOther;

@end
