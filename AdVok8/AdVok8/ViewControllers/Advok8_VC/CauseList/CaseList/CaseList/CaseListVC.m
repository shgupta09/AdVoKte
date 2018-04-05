//
//  CaseListVC.m
//  AdVok8
//
//  Created by NetprophetsMAC on 3/30/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CaseListVC.h"
#import "CaseListCell.h"
#import "CasePageVC.h"
@interface CaseListVC ()

@end

@implementation CaseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

-(void)setUpData{
    
    [self setUpTableView];
    [self hideConcelButton:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- TectField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        [self hideConcelButton:true];
    }else{
        [self hideConcelButton:false];
    }
    return true;
}

#pragma mark- otherMethods
-(void)hideConcelButton:(BOOL)isHide{
    if (isHide) {
        _btn_CancelSearch.hidden = true;
        _traillinfConstraint.constant = 10;
    }else{
        _btn_CancelSearch.hidden = false;
        _traillinfConstraint.constant = 50;
    }
}

#pragma mark- TblView

-(void)setUpTableView{
    [_tblView registerNib:[UINib nibWithNibName:@"CaseListCell" bundle:nil]forCellReuseIdentifier:@"CaseListCell"];
    _tblView.rowHeight = UITableViewAutomaticDimension;
    _tblView.estimatedRowHeight = 100;
    _tblView.multipleTouchEnabled = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CaseListCell *cell = [_tblView dequeueReusableCellWithIdentifier:@"CaseListCell"];
    if (cell == nil) {
        cell = [[CaseListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CaseListCell"];
    }

    [CommonFunction setShadowOpacity:cell.view];
    [CommonFunction setCornerRadius:cell.view Radius:5.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CasePageVC *caseOBJ = [[CasePageVC alloc]initWithNibName:@"CasePageVC" bundle:nil];
    caseOBJ.isFromDailyCauseList = false;
    [self.navigationController pushViewController:caseOBJ animated:true];
}

#pragma mark- Btn Actions

- (IBAction)btnAction_Cross:(id)sender {
    _txt_Search.text = @"";
}

@end
