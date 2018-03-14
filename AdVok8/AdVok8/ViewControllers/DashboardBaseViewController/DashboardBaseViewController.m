//
//  DashboardBaseViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 14/02/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "DashboardBaseViewController.h"

@interface DashboardBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray* arrOptions;
    NSArray* arrImages;
}
@end

@implementation DashboardBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"DashboardHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DashboardHomeCollectionViewCell"];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([CommonFunction getValueFromDefaultWithKey:@"loginUsertype"] && [[CommonFunction getValueFromDefaultWithKey:@"loginUsertype"]  isEqual:  @"advocate"]){
        arrImages = [[NSArray alloc] initWithObjects:@"CaseTracking.png",@"CaseTracking.png",@"CaseTracking.png",@"Appointment-1.png",@"Me.png",@"CaseTracking.png",@"CaseTracking.png",@"CaseTracking.png", nil];
        arrOptions = [[NSArray alloc] initWithObjects:@"Cause List",@"Calendar",@"Task",@"Appointment",@"Me",@"My Activity",@"Display Board",@"Appeal Alert", nil];
    }
    else
    {
        arrImages = [[NSArray alloc] initWithObjects:@"CaseTracking.png",@"CaseTracking.png",@"CaseTracking.png",@"Appointment-1.png",@"Me.png", nil];
        arrOptions = [[NSArray alloc] initWithObjects:@"Find Lawyers",@"Case Treacking",@"My Activity",@"Appointment",@"Me", nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegates methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrOptions.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DashboardHomeCollectionViewCell *cell = (DashboardHomeCollectionViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:@"DashboardHomeCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.layer.cornerRadius = 10;
    cell.imgView.clipsToBounds = true;
    CAShapeLayer* layering = [CAShapeLayer layer];
    [layering setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, cell.frame.size.width-20, cell.frame.size.height-20)] CGPath ]];
    [cell.imgView setImage:[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]]];
    cell.lblName.text = [arrOptions objectAtIndex:indexPath.row];
    
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
    float cellWidth = screenWidth / 3.0 ; //Replace the divisor with the column count requirement. Make sure to have it in float.
     DashboardHomeCollectionViewCell *cell = (DashboardHomeCollectionViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGFloat maxLabelWidth = 100;
    cell.lblName.text = [arrOptions objectAtIndex:indexPath.row];

    CGSize neededSize = [cell.lblName sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(cellWidth, neededSize.height + 10 +cellWidth);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        LawyersCategoryVC *lawyerVcOBJ = [[LawyersCategoryVC alloc]initWithNibName:@"LawyersCategoryVC" bundle:nil];
        [self.navigationController pushViewController:lawyerVcOBJ animated:true];
    }
    
    
}


@end
