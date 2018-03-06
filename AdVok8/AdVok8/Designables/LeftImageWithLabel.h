//
//  LeftImageWithLabel.h
//  AdVok8
//
//  Created by shubham gupta on 3/2/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftImageWithLabel : UILabel
@property (strong,nonatomic) IBInspectable UIImage* leftImage;
-(void)setText:(NSString *)text;

@end
