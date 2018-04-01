//
//  TextFieldFooter.m
//  AdVok8
//
//  Created by shubham gupta on 3/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TextFieldFooter.h"

@implementation TextFieldFooter

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        self.tintColor = [UIColor whiteColor];
        //self.layer.cornerRadius = self.bounds.size.height/2;
        self.clipsToBounds = YES;
        _baseLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        _baseLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_baseLine];
    }
    return self;
}
//-(void)updateFrame:(CGFloat)width{
//    self.baseLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, width, 1)];
//    _baseLine.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:_baseLine];
//}


-(void)setMaxCharLimit:(int)maxCharLimit{
    _maxCharLimit = maxCharLimit;
}
@end
