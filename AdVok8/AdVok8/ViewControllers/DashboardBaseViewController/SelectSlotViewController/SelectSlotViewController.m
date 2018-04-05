//
//  SelectSlotViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 05/04/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "SelectSlotViewController.h"

@interface SelectSlotViewController ()
{

    NSMutableArray* arrDays;
    NSMutableArray* arrTime;
    
}
@end

@implementation SelectSlotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* dayTime = _obj.DayTime;
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backTapped{
    [self dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - Collection View Delegates methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SlotCollectionViewCell *cell = (SlotCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:@"SlotCollectionViewCell" forIndexPath:indexPath];
    
    Specialization* obj = [Specialization new];
    
    cell.lblTime.text = obj.name;
    
    //    [[cell.contentView layer] addSublayer:layering];
    //    [[cell.contentView layer] setMask:layering];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 2.5 ; //Replace the divisor with the column count requirement. Make sure to have it in float.
    LawyerCategoryTableViewCell *cell = (LawyerCategoryTableViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGFloat maxLabelWidth = 100;
    Specialization* obj = [Specialization new];
    
    cell.lblName.text = obj.name;
    CGSize neededSize = [cell.lblName sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(cellWidth, neededSize.height + 10 + 80);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
