//
//  LawyersCategoryVC.m
//  AdVok8
//
//  Created by shubham gupta on 3/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "LawyersCategoryVC.h"
#import "LawyerListVC.h"
@interface LawyersCategoryVC ()
{

    NSMutableArray* arrData;
    LoderView *loderObj;

}
@end

@implementation LawyersCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [CommonFunction setNavToController:self title:@"Lawyer" isCrossBusston:true isAddRightButton:false];
    // Do any additional setup after loading the view from its nib.
    arrData = [NSMutableArray new];

    [_collectionView registerNib:[UINib nibWithNibName:@"LawyerCategoryTableViewCell" bundle:nil] forCellWithReuseIdentifier:@"LawyerCategoryTableViewCell"];
    [self hitApiToGetAllCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}

#pragma mark - Collection View Delegates methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return arrData.count;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LawyerCategoryTableViewCell *cell = (LawyerCategoryTableViewCell*)[_collectionView dequeueReusableCellWithReuseIdentifier:@"LawyerCategoryTableViewCell" forIndexPath:indexPath];
    cell.imgView.layer.cornerRadius = 10;
    cell.imgView.clipsToBounds = true;
    CAShapeLayer* layering = [CAShapeLayer layer];
    [layering setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, cell.frame.size.width-20, cell.frame.size.height-20)] CGPath ]];
    Specialization* obj = [Specialization new];
    obj = [arrData objectAtIndex:indexPath.row];
    if (![obj.iconImage isKindOfClass:[NSNull class]]){
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_CONTENTS_BASE_URL,obj.iconImage]]];
    }
    cell.lblName.text = obj.name;

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
    obj = [arrData objectAtIndex:indexPath.row];
    
    cell.lblName.text = obj.name;
    CGSize neededSize = [cell.lblName sizeThatFits:CGSizeMake(maxLabelWidth, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(cellWidth, neededSize.height + 10 + 80);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        LawyerListVC *lawyerVcOBJ = [[LawyerListVC alloc]initWithNibName:@"LawyerListVC" bundle:nil];
    Specialization* obj = [Specialization new];
    obj = [arrData objectAtIndex:indexPath.row];
    
    lawyerVcOBJ.Specialization = obj.name;
        [self.navigationController pushViewController:lawyerVcOBJ animated:true];
    
    
}



#pragma mark - API related

-(void)hitApiToGetAllCategories{
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_GET_ALL_SPECIALIZATION]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [self removeloder];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1) {
                    NSArray *tempArray = [NSArray new];
                    NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    tempArray = [json objectForKey:@"_special"];
                    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        Specialization *dataObj = [Specialization new];
                        [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                            @try {
                                [dataObj setValue:obj forKey:(NSString *)key];
                                
                            } @catch (NSException *exception) {
                                NSLog(exception.description);
                                //  Handle an exception thrown in the @try block
                            } @finally {
                                //  Code that gets executed whether or not an exception is thrown
                            }
                        }];
                        
                        [arrData addObject:dataObj];
                    }];
                    [_collectionView reloadData];
                }else
                {
                    //                    [self addAlertWithTitle:AlertKey andMessage:[responseObj valueForKey:@"message"] isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
                    [self removeloder];
                    //                    [self removeloder];
                }
                [self removeloder];
                
            }
            
            
            
        }];
    } else {
        [self removeloder];
        //        [self addAlertWithTitle:AlertKey andMessage:Network_Issue_Message isTwoButtonNeeded:false firstbuttonTag:100 secondButtonTag:0 firstbuttonTitle:OK_Btn secondButtonTitle:nil image:Warning_Key_For_Image];
    }
}


-(void)addLoder{
    self.view.userInteractionEnabled = NO;
    //  loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
    loderObj = [[LoderView alloc] initWithFrame:self.view.frame];
    loderObj.lbl_title.text = @"Please wait...";
    [self.view addSubview:loderObj];
}

-(void)removeloder{
    //loderObj = nil;
    [loderObj removeFromSuperview];
    //[loaderView removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}


@end
