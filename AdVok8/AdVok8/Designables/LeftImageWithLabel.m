//
//  LeftImageWithLabel.m
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LeftImageWithLabel.h"

@implementation LeftImageWithLabel
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
//        imageAttachment.image = [UIImage imageNamed:@"Civil-1"];
//        CGFloat imageOffsetY = -5.0;
//        imageAttachment.bounds = CGRectMake(0, imageOffsetY, 20 , 20);
//        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
//        NSMutableAttributedString *completeText= [[NSMutableAttributedString alloc] initWithString:@""];
//        [completeText appendAttributedString:attachmentString];
//        NSMutableAttributedString *textAfterIcon= [[NSMutableAttributedString alloc] initWithString:@"Using attachment.bounds!"];
//        [completeText appendAttributedString:textAfterIcon];
//        self.textAlignment=NSTextAlignmentRight;
//        self.attributedText=completeText;
    }
    return self;
}



-(void)setleftImage:(UIImage *)image{
    _leftImage = image;
}
-(void)setText:(NSString *)text{
    NSTextAttachment *imageAttachment = [[NSTextAttachment alloc] init];
    imageAttachment.image = [_leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    CGFloat imageOffsetY = -5.0;
    imageAttachment.bounds = CGRectMake(0, imageOffsetY, 20 , 20);
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:imageAttachment];
    NSMutableAttributedString *completeText= [[NSMutableAttributedString alloc] initWithString:@""];
    [completeText appendAttributedString:attachmentString];
    NSMutableAttributedString *textAfterIcon= [[NSMutableAttributedString alloc] initWithString:text];
    [completeText appendAttributedString:textAfterIcon];
    self.textAlignment=NSTextAlignmentLeft;
    self.attributedText=completeText;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
