//
//  TaskDetailVC.m
//  AdVok8
//
//  Created by shubham gupta on 4/1/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "TaskDetailVC.h"
#import "CreateTaskVC.h"

@interface TaskDetailVC ()
{
    LoderView *loderObj;
}
@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews{
    loderObj.frame = self.view.frame;
}

#pragma mark- Navigation
-(void)setUpData{
    NSArray *ar = [[NSArray alloc]initWithObjects:@"ic_edit2.png",@"cross-1.png", nil];
    [CommonFunction setNavToController:self title:@"Task" isCrossBusston:false rightNavArray:ar];
    
    self.lblTaskName.text = _eventObj.EventName;
    self.lblMatter.text = _eventObj.Matter;
    self.lblLocation.text = _eventObj.Location;
    self.lblDescription.text = _eventObj.Description;
    self.lblStartDate.text = _eventObj.StartAt;
    self.lblEndDate.text = _eventObj.EndAt;
    self.lblTime.text = [NSString stringWithFormat:@"%@ - %@", _eventObj.StartTime,_eventObj.EndTime];
}
-(void)backTapped{
    [self.navigationController popViewControllerAnimated:true];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rightBarAction:(id)sender{
    if (((UIBarButtonItem *)sender).tag == 0) {
        CreateTaskVC *createTaskObj = [[CreateTaskVC alloc]initWithNibName:@"CreateTaskVC" bundle:nil];
        createTaskObj.isCreateTask = false;
        createTaskObj.eventObj = _eventObj;
        [self.navigationController pushViewController:createTaskObj animated:true];
    }
    else if (((UIBarButtonItem *)sender).tag == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to delete it?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 [self hitApiToDeleteAppointment]; //BUTTON OK CLICK EVENT
                             }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


#pragma mark - Api Related
-(void)hitApiToDeleteAppointment{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [dictRequest setValue:[NSString stringWithFormat:@"%d", _eventObj.EventId] forKey:@"EventId"];
    
    [parameter setValue:dictRequest forKey:@"objEvent"];
    
    if ([ CommonFunction reachability]) {
        [self addLoder];
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_DELETE_EVENT]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrorMessage"]];
                    [self.navigationController dismissViewControllerAnimated:true completion:nil];
                }else
                {
                    
                    [[FadeAlert getInstance] displayToastWithMessage:[json valueForKey:@"ErrorMessage"]];
                    
                }
                
            }
            else
            {
                [self removeloder];
                [[FadeAlert getInstance] displayToastWithMessage:error.description];
                
            }
            
            
            [self removeloder];
        }];
    } else {
        
        [self removeloder];
        [[FadeAlert getInstance] displayToastWithMessage:NO_INTERNET_MESSAGE];
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
