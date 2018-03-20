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

@end
