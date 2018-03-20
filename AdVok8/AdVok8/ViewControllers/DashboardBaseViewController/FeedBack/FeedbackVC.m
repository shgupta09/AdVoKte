//
//  FeedbackVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/19/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "FeedbackVC.h"

@interface FeedbackVC ()

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
    // Do any additional setup after loading the view from its nib.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

#pragma mark- TextView Delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _txtView_Feedback.text = @"";
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
    
    switch (((UIButton *)sender).tag) {
        case 0:
             [_btn1 setSelected:true];
            break;
        case 1:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            break;
        case 2:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            break;
        case 3:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            [_btn4 setSelected:true];
            break;
        case 4:
            [_btn1 setSelected:true];
            [_btn2 setSelected:true];
            [_btn3 setSelected:true];
            [_btn4 setSelected:true];
            [_btn5 setSelected:true];
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
            }else{
                [_btn8 setSelected:true];
            }
            break;
        case 1:
            if (_btn9.isSelected == true) {
                 [_btn9 setSelected:false];
            }else{
                [_btn9 setSelected:true];
            }
            break;
        case 2:
            if (_btn10.isSelected == true) {
                 [_btn10 setSelected:false];
            }else{
                [_btn10 setSelected:true];
            }
            break;
        case 3:
            if (_btn11.isSelected == true) {
                [_btn11 setSelected:false];
            }else{
                [_btn11 setSelected:true];
            }
            break;
        case 4:
            if (_btn12.isSelected == true) {
                 [_btn12 setSelected:false];
            }else{
                [_btn12 setSelected:true];
            }
            break;
    }
    
}
- (IBAction)btnAction_Share:(id)sender {
    if (![_txtView_Feedback.text isEqualToString:@""] || ![_txtView_Feedback.text isEqualToString:PlaceHolder_TextView_Feedbck] )
    {
    NSArray *objectsToShare = @[_txtView_Feedback.text, _img_Profile.image];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    }
}

- (IBAction)btnAction_Submit:(id)sender {
}

@end
