//
//  TextFieldBaselineWithLeftRight
//  TatabApp
//
//  Created by NetprophetsMAC on 1/31/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldBaselineWithLeftRight : UITextField
@property (strong,nonatomic) UIImageView* leftImgView;
@property (strong,nonatomic) UIImageView* rightImgView;
@property (strong,nonatomic) IBInspectable UIImage* leftImage;
@property IBInspectable int maxCharLimit;

@end
