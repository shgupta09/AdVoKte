//
//  CauseBaseVC.h
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CauseBaseVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_Container_First;
@property (weak, nonatomic) IBOutlet UIView *view_Container_Second;
@property (weak, nonatomic) IBOutlet UIView *view_FirstSelection;
@property (weak, nonatomic) IBOutlet UIView *view_SecondSelection;
@property (nonatomic) BOOL isFirstSelected;
@end
