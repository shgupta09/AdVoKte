//
//  FeedbackVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC (){
       LoderView *loderObj;
    NSNumber* currentRating;
    NSString* ans1;
    NSString* ans2;
    NSString* ans3;
    NSString* ans4;
    NSString* ans5;
}


@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonFunction setNavToController:self title:@"Feedback" isCrossBusston:false];
    _txtView_Feedback.text = PlaceHolder_TextView_Feedbck;
    _txtView_Feedback.textColor = [UIColor lightGrayColor];
    _txtView_Feedback.delegate = self;
    _lblName.text =  [NSString stringWithFormat:@"%@ %@",_obj.fname,_obj.lname];
  [_img_Profile sd_setImageWithURL:[CommonFunction getProfilePicURLString:_obj.username] placeholderImage:[UIImage imageNamed:@"dependentsuser"]];
    currentRating = [NSNumber numberWithFloat:0.0];
    ans1 = @"no";
    ans2 = @"no";
    ans3 = @"no";
    ans4 = @"no";
    ans5 = @"no";
    // Do any additional setup after loading the view from its nib.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

#pragma mark- TextView Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
//    _txtView_Feedback.text = @"";
    if ([_txtView_Feedback.text isEqualToString:PlaceHolder_TextView_Feedbck]){
        _txtView_Feedback.text = @"";
    }
    
    _txtView_Feedback.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_txtView_Feedback.text.length == 0){
        _txtView_Feedback.textColor = [UIColor lightGrayColor];
        _txtView_Feedback.text = PlaceHolder_TextView_Feedbck;
        [_txtView_Feedback resignFirstResponder];
    }
}

-(void) textViewShouldEndEditing:(UITextView *)textView
{    
    if(_txtView_Feedback.text.length == 0){
        _txtView_Feedback.textColor = [UIColor lightGrayColor];
        _txtView_Feedback.text = PlaceHolder_TextView_Feedbck;
        [_txtView_Feedback resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- BtnActions

- (IBAction)btnAction_Experience:(id)sender {
    [_btn1 setSelected:false];
    [_btn2 setSelected:false];
    [_btn3 setSelected:false];
    [_btn4 setSelected:false];
    [_btn5 setSelected:false];
    currentRating = [NSNumber numberWithFloat:0.0];;
    switch (((UIButton *)sender).tag) {
        case 0:
             [_btn1 setSelected:true];
            currentRating = [NSNumber numberWithFloat:1.0];;

            break;
        case 1:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            currentRating = [NSNumber numberWithFloat:2.0];;

            break;
        case 2:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            currentRating = [NSNumber numberWithFloat:3.0];;

            break;
        case 3:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            [_btn4 setSelected:true];
            currentRating = [NSNumber numberWithFloat:4.0];;

            break;
        case 4:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            [_btn4 setSelected:true];
            [_btn5 setSelected:true];
            currentRating = [NSNumber numberWithFloat:5.0];;

            break;
        default:
            break;
    }
  
}
- (IBAction)btnAction_Recommended:(id)sender {
    [_btn6 setSelected:false];
    [_btn7 setSelected:false];
    switch (((UIButton *)sender).tag) {
        case 0:
            [_btn6 setSelected:true];
            break;
        case 1:
            [_btn7 setSelected:true];
            break;
    }
}
- (IBAction)btnAction_HappyWith:(id)sender {
    switch (((UIButton *)sender).tag) {
    
        case 0:
            if (_btn8.isSelected == true) {
                 [_btn8 setSelected:false];
                ans1 = @"no";
            }else{
                [_btn8 setSelected:true];
                ans1 = @"yes";
            }
            break;
        case 1:
            if (_btn9.isSelected == true) {
                 [_btn9 setSelected:false];
                ans2 = @"no";
            }else{
                [_btn9 setSelected:true];
                ans2 = @"yes";
            }
            break;
        case 2:
            if (_btn10.isSelected == true) {
                 [_btn10 setSelected:false];
                ans3 = @"no";
            }else{
                [_btn10 setSelected:true];
                ans3 = @"yes";
            }
            break;
        case 3:
            if (_btn11.isSelected == true) {
                [_btn11 setSelected:false];
                ans4 = @"no";
            }else{
                [_btn11 setSelected:true];
                ans4 = @"yes";
            }
            break;
        case 4:
            if (_btn12.isSelected == true) {
                 [_btn12 setSelected:false];
                ans5 = @"no";
            }else{
                [_btn12 setSelected:true];
                ans5 = @"yes";
            }
            break;
    }
    
}
- (IBAction)btnAction_Share:(id)sender {
    if (![_txtView_Feedback.text isEqualToString:@""] && ![_txtView_Feedback.text isEqualToString:PlaceHolder_TextView_Feedbck] )
    {
    NSArray *objectsToShare = @[_txtView_Feedback.text, _img_Profile.image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter some feedback." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)btnAction_Submit:(id)sender {
    [self hitApiToGiveFeedbackRating];
}


#pragma mark - API related
//{"objRating":{"RatingId":"0","RatingFor":"8896292603","UserType":"advocate","UserRating":"5","AdminRating":"2","Feedback":"test","CreatedBy":"9560409501","Ans1":"yes","Ans3":"yes"}}
-(void)hitApiToGiveFeedbackRating{
    NSMutableDictionary* parameter = [NSMutableDictionary new];

    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:@"0" forKey:@"RatingId"];
    [dictRequest setValue:_obj.username forKey:@"RatingFor"];
    [dictRequest setValue:@"advocate" forKey:@"UserType"];
    [dictRequest setValue:currentRating forKey:@"UserRating"];
    [dictRequest setValue:@"0" forKey:@"AdminRating"];
    [dictRequest setValue:_txtView_Feedback.text forKey:@"Feedback"];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"CreatedBy"];
    if (_btn6.selected){
        [dictRequest setValue:@"yes" forKey:@"Ans1"];
    }
    else
    {
        [dictRequest setValue:@"no" forKey:@"Ans1"];
    }

    NSString* feedbackhappy = @"";
    if ([ans1 isEqualToString:@"yes"]){
       feedbackhappy = [feedbackhappy stringByAppendingString:@"Lawyer friendliness~"];
    }
    if ([ans2 isEqualToString:@"yes"]){
        feedbackhappy = [feedbackhappy stringByAppendingString:@"Value for money~"];
    }
    if ([ans3 isEqualToString:@"yes"]){
        feedbackhappy = [feedbackhappy stringByAppendingString:@"Wait time~"];
    }
    if ([ans4 isEqualToString:@"yes"]){
        feedbackhappy = [feedbackhappy stringByAppendingString:@"Explanation of the issue~"];
    }
    if ([ans5 isEqualToString:@"yes"]){
        feedbackhappy = [feedbackhappy stringByAppendingString:@"Understanding of issue"];
    }
    [dictRequest setValue:feedbackhappy forKey:@"Ans3"];

    [parameter setObject:dictRequest forKey:@"objRating"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_RATING]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                [self.navigationController popViewControllerAnimated:true];
               [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrMsg"]];
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
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
