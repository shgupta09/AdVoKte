//
//  TextFieldFooter.h
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldFooter : UITextField
@property IBInspectable int maxCharLimit;

@property(nonatomic,strong)UIView* baseLine ;
//-(void)updateFrame:(CGFloat)width;
@end
