//
//  FadeAlert.h
//  AdVok8
//
//  Created by Shagun Verma on 21/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadeAlert : UIView

@property (nonatomic, strong) NSTimer *timerToast;
@property (nonatomic, strong) UILabel *toastLabel;

+ (FadeAlert *)getInstance;
- (void) displayToastWithMessage:(NSString *) message;
- (void) close;

@end

@interface NSString (StringToast)

- (CGRect)textRectWithFontSize:(CGFloat)size andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight;


@end
