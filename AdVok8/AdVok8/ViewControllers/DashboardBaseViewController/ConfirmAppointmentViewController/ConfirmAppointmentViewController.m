//
//  ConfirmAppointmentViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "ConfirmAppointmentViewController.h"

@interface ConfirmAppointmentViewController ()
{
    LoderView* loderObj;
}
@end

@implementation ConfirmAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Confirm Appointment" isCrossBusston:false];

    _lblDate.text = _dateString;
    _lblDayName.text = _dayString;
    
    _lblLawyerName.text = [NSString stringWithFormat:@"%@ %@", _obj.fname,_obj.lname];
    _lblSubtitle.text = _obj.AOP;
    
    User *dataObj = [CommonFunction objectFromDataWithKey:@"userData"];
    
    _txtName.text = [NSString stringWithFormat:@"%@ %@", dataObj.FirstName,dataObj.LastName];
    _txtEmail.text = dataObj.EmailId;
    _txtMobile.text = dataObj.ContactNo;
    _txtDescription.placeholder = @"Description";
    
    [_imgViewProfile sd_setImageWithURL:[CommonFunction getProfilePicURLString:_obj.username]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
// _ap.advunm, _ap.userunm, _ap.date, _ap.time, _ap.desc, _ap.ViewFileName, _ap.contenttype,_ap.FileSize ,_ap.AttachmentPath
- (IBAction)btnDoneclicked:(id)sender {
    
    [self hitApiToConfirmAppointment];
    
}

#pragma mark - Api Related
-(void)hitApiToConfirmAppointment{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:_obj.username forKey:@"advunm"];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"userunm"];
    [dictRequest setValue:_dayString forKey:@"date"];
    [dictRequest setValue:_dateString forKey:@"time"];
    [dictRequest setValue:_txtDescription.text forKey:@"desc"];
 
    [parameter setValue:dictRequest forKey:@"_ap"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_BOOK_APPOINTMENT]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    [self.navigationController dismissViewControllerAnimated:true completion:nil];
                }else
                {
                    
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
                    
                }
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
            
            
            [self removeloder];
        }];
    } else {
        
        [self removeloder];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
    }
}

-(void)addLoder{
    self.view.userInteractionEnabled = NO;
    //  loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
    loderObj = [[LoderView alloc] initWithFrame:self.view.frame];
    loderObj.lbl_title.text = @"Please wait...";
    [self.view addSubview:loderObj];
}

-(void)removeloder{
    //loderObj = nil;
    [loderObj removeFromSuperview];
    //[loaderView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}


@end
