//
//  FadeAlert.m
//  AdVok8
//
//  Created by Shagun Verma on 21/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//


#define ToastPadding    20
#define ToastMaxWidth   ([UIScreen mainScreen].applicationFrame.size.width) - (ToastPadding * 2)
#define ToastMinHeight  30.0
#define ToastMaxHeight  ([UIScreen mainScreen].applicationFrame.size.height) - 100
#define ToastDelayTime  4.0
#define ToastFontSize   16.0
#define ToastTextFont   [UIFont systemFontOfSize:16.0]
#define ToastTextcolor   [UIColor whiteColor]
#define ToastBackgroundColor    [UIColor darkGrayColor]

#import "FadeAlert.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation FadeAlert
@synthesize timerToast;
@synthesize toastLabel;

static FadeAlert *toast = nil;

+ (FadeAlert *) getInstance
{
    @synchronized(self)
    {
        if (toast == nil)
        {
            toast = [[self alloc] init];
            [toast initToast];
        }
        return toast;
    }
    return nil;
}

- (void) initToast
{
    [self createLabelForToast];
    [self addSubview:toastLabel];
}

- (void) displayToastWithMessage:(NSString *) message
{
    if (!message || ([message isEqualToString:@""])||([message isEqual:[NSNull null]]))
    {
        message = @"Invalid Message For Toast";
    }
    CGRect rect = [message textRectWithFontSize:ToastFontSize andMaxWidth:ToastMaxWidth andMaxHeight:ToastMaxHeight];
    CGFloat width = rect.size.width + ToastPadding;
    CGFloat height = rect.size.height + ToastPadding;
    CGRect aRect = CGRectMake(0, 0, width, height);
    self.frame = CGRectMake((([UIScreen mainScreen].applicationFrame.size.width)-width)/2, ([UIScreen mainScreen].applicationFrame.size.height)-(height)-70, width, height);
    
    toastLabel.frame = aRect;
    toastLabel.text = message;
    
    [self fadeIn];
    timerToast = [NSTimer scheduledTimerWithTimeInterval:ToastDelayTime target:self selector:@selector(close) userInfo:nil repeats:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self close];
}

-(void) fadeOut
{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished){
        [self removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void) fadeIn
{
    [self setAlpha:0.0];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [UIView beginAnimations: @"Fade In" context:nil];
    // wait for time before begin
    [UIView setAnimationDelay:0];
    // druation of animation
    [UIView setAnimationDuration:1.0];
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void) createLabelForToast
{
    toastLabel = [[UILabel alloc] init];
    [toastLabel setText:@""];
    [toastLabel setFont:ToastTextFont];
    [toastLabel setTextColor:ToastTextcolor];
    [toastLabel setBackgroundColor:ToastBackgroundColor];
    [toastLabel setAdjustsFontSizeToFitWidth:NO];
    [toastLabel setNumberOfLines:50];
    [toastLabel setTextAlignment:NSTextAlignmentCenter];
    [toastLabel.layer setBorderColor: [UIColor whiteColor].CGColor];
    [toastLabel.layer setBorderWidth: 0.4];
    [toastLabel.layer setMasksToBounds:YES];
    [toastLabel.layer setCornerRadius:4.0];
}

- (void) close
{
    [self.timerToast invalidate];
    self.timerToast = nil;
    [self fadeOut];
}

@end

@implementation NSString (StringToast)

#pragma mark - For Text Rect
- (CGRect)textRectWithFontSize:(CGFloat)size andMaxWidth:(CGFloat)maxWidth andMaxHeight:(CGFloat)maxHeight
{
    CGSize maximumLabelSize = CGSizeMake(maxWidth, maxHeight);
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:size]};
    CGRect expectedLabelSize = [self boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    return expectedLabelSize;
}

@end
