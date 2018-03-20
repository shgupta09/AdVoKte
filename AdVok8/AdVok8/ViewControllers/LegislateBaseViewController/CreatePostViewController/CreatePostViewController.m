//
//  CreatePostViewController.m
//  AdVok8
//
//  Created by Shagun Verma on 07/03/18.
//  Copyright © 2018 Shagun Verma. All rights reserved.
//

#import "CreatePostViewController.h"

@interface CreatePostViewController ()
{
    UIImagePickerController * picker;
    UIImagePickerControllerSourceType *sourceType;
    UIImage *capturedImage;
}
@end

@implementation CreatePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavToController];
    if ([_postType isEqualToString:@"Post"]){
        _lblHeading.text = @"Write your post";
    }
    else
    {
        _lblHeading.text = @"";
    }
    picker = [[UIImagePickerController alloc] init];
    
    //    title = [title capitalizedString];
    [self.view addSubview:[CommonFunction setStatusBarColor]];
   
    self.navigationController.navigationBar.barTintColor = [CommonFunction colorWithHexString:@"27328C"];
    self.navigationController.navigationBar.translucent = false;
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    //    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    //    backgroundView.image = [UIImage imageNamed:@"Home_ Title bar graphic"];
    //    backgroundView.image = [UIImage imageNamed:@"Home_ Title bar graphic"];
    //    [newNavBar setBackgroundImage:[UIImage imageNamed:@"Home_ Title bar graphic-1"] forBarMetrics:UIBarMetricsDefault];
    //
    //    [newNavBar addSubview:backgroundView];
    
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,30,[UIScreen mainScreen].bounds.size.width,40)];
    lbNavTitle.textAlignment = UITextAlignmentLeft;
    lbNavTitle.text = @"Create Post";
    lbNavTitle.textColor = [UIColor  whiteColor];
    self.navigationItem.titleView = lbNavTitle;
    
    
    UIBarButtonItem *dashboard;
    
    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    imageButton.tintColor = [UIColor whiteColor];
    UIImage * image = [UIImage imageNamed:@"backButton"];
    [imageButton setBackgroundImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [imageButton addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventAllEvents];
    
    dashboard = [[UIBarButtonItem alloc]initWithCustomView:imageButton];
    dashboard.tintColor = [UIColor colorWithRed:233.0f/255.0f green:141.0f/255.0f blue:25.0f/255.0f alpha:1];
    dashboard.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = dashboard;
    
    
    UIBarButtonItem *anotherButton =  [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                       target:self action:@selector(addphotoTapped)];
    anotherButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *anotherButtonPost =  [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                           target:self action:@selector(sendPostTapped)];
    anotherButtonPost.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[anotherButtonPost,anotherButton];
    
    if ([_postType isEqualToString:@"Post"]){
        _txtView.text = @"What's on your mind?";
    }
    else
    {
        _txtView.text = @"Ask a question";
    }
    _txtView.textColor = [UIColor lightGrayColor];
    _txtView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextView Delegate Methods

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_postType isEqualToString:@"Post"]){
        _txtView.text = @"What's on your mind?";
    }
    else
    {
        _txtView.text = @"Ask a question";
    }
    _txtView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_txtView.text.length == 0){
        _txtView.textColor = [UIColor lightGrayColor];
        if ([_postType isEqualToString:@"Post"]){
            _txtView.text = @"What's on your mind?";
        }
        else
        {
            _txtView.text = @"Ask a question";
        }
        [_txtView resignFirstResponder];
    }
}

-(void) textViewShouldEndEditing:(UITextView *)textView
{
    
    if(_txtView.text.length == 0){
        _txtView.textColor = [UIColor lightGrayColor];
        if ([_postType isEqualToString:@"Post"]){
            _txtView.text = @"What's on your mind?";
        }
        else
        {
            _txtView.text = @"Ask a question";
        }
        [_txtView resignFirstResponder];
    }
}
#pragma mark - Button Actions
- (void)backTapped {
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Navigation bar Button Actions
-(void) addphotoTapped {
    [self showActionSheet];
}


-(void) sendPostTapped {
    [self hitApiToPost ];
}


#pragma mark- ActionSheet

-(void)showActionSheet{
    [CommonFunction resignFirstResponderOfAView:self.view];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Camera"
                                                    otherButtonTitles:@"Library", nil];
    
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        sourceType = UIImagePickerControllerSourceTypeCamera;
        [self imageCapture];
    }else if(buttonIndex == 1){
        [self selectPhoto];
    }
    
    
}


- (void)selectPhoto {
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


#pragma mark - Image Capture related
-(void)imageCapture{
    picker.delegate = self;
    
    picker.sourceType = sourceType;
    picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    picker.videoQuality = UIImagePickerControllerQualityType640x480;
    UIView *cameraOverlayView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100.0f, 5.0f, 100.0f, 35.0f)];
    [cameraOverlayView setBackgroundColor:[UIColor blackColor]];
    UIButton *emptyBlackButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 35.0f)];
    [emptyBlackButton setBackgroundColor:[UIColor blackColor]];
    [emptyBlackButton setEnabled:YES];
    [cameraOverlayView addSubview:emptyBlackButton];
    picker.allowsEditing = NO;
    picker.showsCameraControls = YES;
    picker.delegate = self;
    
    picker.cameraOverlayView = cameraOverlayView;
//    [[AppDelegate getDelegate]hideStatusBar];
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    [[AppDelegate getDelegate]showStatusBar];
    
    capturedImage = [self imageToCompress:[info valueForKey:@"UIImagePickerControllerOriginalImage"]];
    [self dismissViewControllerAnimated:YES completion:^{
        [self uploadImage];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [[AppDelegate getDelegate]showStatusBar];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *)imageToCompress:(UIImage *)image{
    
    // Determine output size
    CGFloat maxSize = 640.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat newWidth = width;
    CGFloat newHeight = height;
    
    // If any side exceeds the maximun size, reduce the greater side to 1200px and proportionately the other one
    if (width > maxSize || height > maxSize) {
        if (width > height) {
            newWidth = maxSize;
            newHeight = (height*maxSize)/width;
        } else {
            newHeight = maxSize;
            newWidth = (width*maxSize)/height;
        }
    }
    
    // Resize the image
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set maximun compression in order to decrease file size and enable faster uploads & downloads
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.0f);
    
//    [imageDataArray addObject:imageData];
    UIImage *processedImage = [UIImage imageWithData:imageData];
    return processedImage;
    
}

//"_post.PostNote, _post.UserId, _post.posttype, _post.postsubtype,
//_post.ShareId, _post.TagUserName, _post.PostPic, _post.Answers, _post.corrAns"

//{"UserId":"9560386426","posttype":"Post; Article; Question","postsubtype":"","TagUserId":null,"PostPic":"","ShareId":"","PostNote":"hello users ","TagUserName":"","UserName":null,"Type":null,"PostId":null,"cntlike":null,"cntcmt":null,"useractv":null,"Details":null,"Days":null,"shareuid":null,"sharefname":null,"Answer":null,"Answers":["yes","No","NA"],"corrAns":"1"}

#pragma mark - Api Related

-(void) uploadImage {
    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970]); // returned as a double
    long digits = (long)time; // this is the first 10 digits
    int decimalDigits = (int)(fmod(time, 1) * 1000); // this will get the 3 missing digits
//    long timestamp = (digits * 1000) + decimalDigits;
    
    NSString *timestampString = [NSString stringWithFormat:@"%ld%d",digits ,decimalDigits];
    UIImage *image = capturedImage;
    NSData* imagedata = UIImagePNGRepresentation(image);
    
    NSString *base64String = [UIImagePNGRepresentation(image)
                              base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    [dictRequest setValue:@"0" forKey:@"DocId"];
    [dictRequest setValue:@"0" forKey:@"AppointId"];
    [dictRequest setValue:@"0" forKey:@"CaseId"];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UploadedById"];
    [dictRequest setValue:@"" forKey:@"AttachmentName"];
    [dictRequest setValue:timestampString forKey:@"viewFilename"];
    [dictRequest setValue:base64String forKey:@"AttachmentPath"];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [dictRequest setValue:@"png" forKey:@"cty"];
    [dictRequest setValue:@"userpic" forKey:@"DocumentType"];
    [dictRequest setValue:false forKey:@"editable"];
    [dictRequest setValue:[NSString stringWithFormat:@"%d",[imagedata length]] forKey:@"fileSize"];

    //    [dictRequest setValue:postId forKey:@"PostId"];
    [parameter setValue:dictRequest forKey:@"_dm"];
    
    if ([ CommonFunction reachability]) {
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_UPLOAD_FILE]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    [_imgViewPost setImage:capturedImage];

                }
            }
        }];
        

    } else {

    }
}

-(void)hitApiToPost{
    NSMutableDictionary *parameter = [NSMutableDictionary new];
    NSMutableDictionary* dictRequest = [NSMutableDictionary new];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserId"];
    [dictRequest setValue:_txtView.text forKey:@"PostNote"];
    [dictRequest setValue:@"Post" forKey:@"posttype"];
    [dictRequest setValue:@"" forKey:@"postsubtype"];
    [dictRequest setValue:[CommonFunction getValueFromDefaultWithKey:@"loginUsername"] forKey:@"UserName"];
    [dictRequest setValue:@"" forKey:@"PostPic"];

//    [dictRequest setValue:postId forKey:@"PostId"];
    [parameter setValue:dictRequest forKey:@"_post"];
    
    if ([ CommonFunction reachability]) {
        
        //            loaderView = [CommonFunction loaderViewWithTitle:@"Please wait..."];
        [WebServicesCall responseWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_POST]  postResponse:parameter postImage:nil requestType:POST tag:nil isRequiredAuthentication:YES header:@"" completetion:^(BOOL status, id responseObj, NSString *tag, NSError * error, NSInteger statusCode, id operation, BOOL deactivated) {
            if (error == nil) {
                NSData *data = [[responseObj valueForKey:@"d"] dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSNumber* st = [json valueForKey:@"Status"];
                int status = [st intValue];
                if ( status == 1){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:[json valueForKey:@"ErrMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
                        [self.navigationController dismissViewControllerAnimated:true completion:^{
                            
                            
                        }];
                    }];
                    [alertController addAction:ok];
                    [self presentViewController:alertController animated:YES completion:nil];
            
                }else
                {
                    
                }
                
            }
            
            
            
        }];
    } else {
        
    }
}


@end
