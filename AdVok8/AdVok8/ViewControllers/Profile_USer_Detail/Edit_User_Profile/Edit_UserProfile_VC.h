//
//  Edit_UserProfile_VC.h
//  AdVok8
//
//  Created by shubham gupta on 4/14/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Edit_UserProfile_VC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *txt_Date;
@property (weak, nonatomic) IBOutlet UITextField *txt_gender;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_AlterNumbr;
@property (weak, nonatomic) IBOutlet UITextField *txt_Number;
@property (weak, nonatomic) IBOutlet UITextField *txt_name;

@end
