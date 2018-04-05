//
//  CustomTFWithLeftRight.m
//  TatabApp
//
//  Created by NetprophetsMAC on 1/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TextFieldBaselineWithLeftRight.h"

@implementation TextFieldBaselineWithLeftRight

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.delegate = self;
        self.tintColor = [UIColor whiteColor];
         //self.layer.cornerRadius = self.bounds.size.height/2;
        self.clipsToBounds = YES;
        self.leftViewMode = UITextFieldViewModeAlways;
//        self.rightViewMode = UITextFieldViewModeAlways;
        UIView* paddingView = [[UIView alloc] initWithFrame:CGRectMake(0,0,50,45)];
        UIView* rightpaddingView = [[UIView alloc] initWithFrame:CGRectMake(0,0,50,45)];
        
        self.leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 10, 25, 25)]; // Set frame as per space required around icon
        self.leftImgView.contentMode =UIViewContentModeScaleAspectFit;
        _leftImgView.image =  _leftImage;
        [paddingView addSubview:self.leftImgView];
        self.leftView = paddingView;
        self.rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(12.5, 10, 25, 25)]; // Set frame as per space required around icon
        self.rightImgView.contentMode =UIViewContentModeScaleAspectFit;
        [rightpaddingView addSubview:self.rightImgView];
//        self.rightView = rightpaddingView;
        
        self.backgroundColor = [UIColor clearColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
        self.textColor = [UIColor darkGrayColor];
        
        UIView* baseLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        baseLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:baseLine];
    }
    return self;
}

- (void)setLeftImage:(UIImage*)leftImage {
    _leftImage = leftImage;
    self.leftImgView.tintColor = [UIColor orangeColor];
    self.leftImgView.image = leftImage;
    
}

-(void)setMaxCharLimit:(int)maxCharLimit{
    _maxCharLimit = maxCharLimit;
}

@end
