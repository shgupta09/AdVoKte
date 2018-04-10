//
//  CreatePostViewController.h
//  AdVok8
//
//  Created by Shagun Verma on 07/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldFooter.h"
@interface PublishArticleViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_txtViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPost;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtCategory;
@property (weak, nonatomic) IBOutlet TextFieldFooter *txtArticleTitle;

@end
