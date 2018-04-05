//
//  LawyersCategoryVC.h
//  AdVok8
//
//  Created by shubham gupta on 3/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawyersCategoryVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
