//
//  RegistrationViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize progressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***
     * Scroll
     **/
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,480+88*isiPhone5() , 320)];
    [scrollView setContentSize:CGSizeMake(480+88*isiPhone5() , 320)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
    image=[UIImage imageNamed:@"registraton_bg.jpeg"];
    }
    else
    {
     image=[UIImage imageNamed:@"registraton_iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [scrollView addSubview:imageViewBG];

    
    /***
     * TextFields background ImageViews
     **/
    
    UIImageView *TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(260+45*isiPhone5(), 80, 186, 34);
    [scrollView addSubview:TFBg];
    
    
    
    /***
     * UserName TextField
     **/
    
    userName=[[UITextField alloc]initWithFrame:CGRectMake(270+45*isiPhone5(), 82, 175, 34)];//180
    userName.backgroundColor=[UIColor clearColor];
    userName.textColor=[UIColor blackColor];
    userName.delegate=self;
    userName.tag=111;
    userName.clearButtonMode=YES;
    userName.placeholder =@"Username";
    userName.returnKeyType = UIReturnKeyNext;
    userName.autocorrectionType=UITextAutocorrectionTypeNo;
    userName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    userName.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];
    //[userName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:userName];
    
    TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(260+45*isiPhone5(), 119, 186, 34);
    [scrollView addSubview:TFBg];
    
    /***
     * Password TextField
     **/
    
    password=[[UITextField alloc]initWithFrame:CGRectMake(270+45*isiPhone5(), 121, 175, 34)];//180
    password.backgroundColor=[UIColor clearColor];
    password.textColor=[UIColor blackColor];
    password.delegate=self;
    password.tag=222;
    password.clearButtonMode=YES;
    password.placeholder =@"Password";
    password.returnKeyType = UIReturnKeyNext;
    password.autocorrectionType=UITextAutocorrectionTypeNo;
    password.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    password.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];
    //[password addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:password];
    
    TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(260+45*isiPhone5(), 158, 186, 34);
    [scrollView addSubview:TFBg];
    
    
    /***
     * countryName TextField
     **/
    
    countryName=[[UITextField alloc]initWithFrame:CGRectMake(270+45*isiPhone5(), 160, 175, 34)];//180
    countryName.backgroundColor=[UIColor clearColor];
    countryName.textColor=[UIColor blackColor];
    countryName.delegate=self;
    countryName.tag=333;
    countryName.clearButtonMode=YES;
    countryName.placeholder =@"Country Name";
    countryName.returnKeyType = UIReturnKeyNext;
    countryName.autocorrectionType=UITextAutocorrectionTypeNo;
    countryName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    countryName.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];
    //[password addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:countryName];
    
    
    TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(260+45*isiPhone5(), 197, 186, 34);
    [scrollView addSubview:TFBg];
    
    /***
     * email TextField
     **/
    
    email=[[UITextField alloc]initWithFrame:CGRectMake(270+45*isiPhone5(), 199, 175, 34)];//180
    email.backgroundColor=[UIColor clearColor];
    email.textColor=[UIColor blackColor];
    email.delegate=self;
    email.tag=444;
    email.clearButtonMode=YES;
    email.placeholder =@"Email";
    email.returnKeyType = UIReturnKeyDone;
    email.autocorrectionType=UITextAutocorrectionTypeNo;
    email.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    email.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];
    //[password addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:email];
    
    TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(57+45*isiPhone5(), 80, 105, 23);
    [scrollView addSubview:TFBg];
    
    /***
     * NickName TextField
     **/
    
    NickName=[[UITextField alloc]initWithFrame:CGRectMake(66+45*isiPhone5(), 82, 100, 20)];//180
    NickName.backgroundColor=[UIColor clearColor];
    NickName.textColor=[UIColor blackColor];
    NickName.delegate=self;
    NickName.tag=555;
    NickName.clearButtonMode=YES;
    NickName.placeholder =@"NickName";
    NickName.returnKeyType = UIReturnKeyDone;
    NickName.autocorrectionType=UITextAutocorrectionTypeNo;
    NickName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    NickName.font=[UIFont fontWithName:@"ProximaNova-Regular" size:12.0];
    //[password addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [scrollView addSubview:NickName];
    
    
    /***
     * Upload Profile IMage ImageView
     **/
    
    UIImage *uploadImage =[UIImage imageNamed:@"upload"];
    
    /***
     * Upload Profile Image Button
     **/
    
    
    profileImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [profileImageButton addTarget:self
                           action:@selector(profileImageButtonPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    profileImageButton.backgroundColor =[UIColor clearColor];
    [profileImageButton setBackgroundImage:[UIImage imageNamed:@"dummy_image"] forState:UIControlStateNormal];
    
    profileImageButton.frame = CGRectMake(30+40*isiPhone5(), 115+5*isiPhone5(),uploadImage.size.width , uploadImage.size.height);
    [scrollView addSubview:profileImageButton];
    
    UIImageView *uploadImageViewBG=[[UIImageView alloc]initWithImage:uploadImage];
    uploadImageViewBG.frame=CGRectMake(30+40*isiPhone5(), 115+5*isiPhone5(),uploadImage.size.width , uploadImage.size.height);
    [scrollView addSubview:uploadImageViewBG];
    
    
    
    
    /***
     * Upload iMage Label
     **/
    
    UILabel* uploadLbl = [[UILabel alloc] init];
    uploadLbl.frame = CGRectMake(35+45*isiPhone5(), 210,71 , 17);
    uploadLbl.textAlignment = NSTextAlignmentCenter;
    uploadLbl.textColor = [UIColor  whiteColor];
    uploadLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    uploadLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"upload-text"]];
    uploadLbl.text=@"";
    [scrollView addSubview:uploadLbl];
    
    
    /***
     * Choose Avtar IMage ImageView
     **/
    
    UIImage *chooseImage =[UIImage imageNamed:@"Choose-Avatar"];
    UIImageView *chooseImageViewBG=[[UIImageView alloc]initWithImage:chooseImage];
    chooseImageViewBG.frame=CGRectMake(130+45*isiPhone5(), 120,chooseImage.size.width , chooseImage.size.height);
    [scrollView addSubview:chooseImageViewBG];

    /***
     * Chosse iMage Label
     **/
    
    UILabel* chooseLbl = [[UILabel alloc] init];
    chooseLbl.frame = CGRectMake(135+45*isiPhone5(), 210,71 , 17);
    chooseLbl.textAlignment = NSTextAlignmentCenter;
    chooseLbl.textColor = [UIColor  whiteColor];
    chooseLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    chooseLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Choose-Avatar-text"]];
    chooseLbl.text=@"";
    [scrollView addSubview:chooseLbl];
    
    /***
     * Submit Button
     **/
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton addTarget:self
                    action:@selector(submitButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    submitButton.backgroundColor =[UIColor clearColor];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    
    submitButton.frame = CGRectMake(128+44*isiPhone5(), 250, 106, 48);
    [scrollView addSubview:submitButton];
    
    /***
     * Cancel Button
     **/
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    cancelButton.backgroundColor =[UIColor clearColor];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    
    cancelButton.frame = CGRectMake(245+44*isiPhone5(), 250, 106, 48);
    [scrollView addSubview:cancelButton];
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)profileImageButtonPressed
{
    UIActionSheet *options = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose From Gallery",@"Camera",nil];
    options.tag=111;
    [options showInView:self.view];
}

-(void)submitButtonPressed
{
    
    NSString *usernameText = [[userName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *passwordText = [[password text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *countrynameText = [[countryName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *emailText = [[email text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *nickNameText = [[NickName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  
    
    if ( usernameText.length == 0 || passwordText.length == 0||countrynameText.length==0 || emailText.length ==0 || nickNameText.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:@"Please Fill All Details"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
       if ([emailTest evaluateWithObject:email.text] != YES)
       {
           UIAlertView *emailalert = [[UIAlertView alloc] initWithTitle:@" Enter Email in" message:@"abc@example.com format" delegate:nil
                                                      cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
           [emailalert show];
       }
        else
        {
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Loading..."];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        
        NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=registration&username=%@&password=%@&country_name=%@&email=%@&user_type=App&fb_id=%@&deviceid=%@&devicetoken=%@&devicetype=%@",usernameText,passwordText,countrynameText,emailText,@"1",@"1",@"1",@"1"];
        NSLog(@"postData---> = %@",postData);
            if (upload_ImageView.image)
            {
                
                UIImage *small = [UIImage imageWithCGImage:[upload_ImageView.image CGImage]scale:0.01 orientation:NO];
                objAPI.imageData = UIImagePNGRepresentation(small);
                [postData appendString:[NSString stringWithFormat:@"&uploadfile=%@",fileName]];
                NSLog(@"Image %@",postData);
            }
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataRegistrationResponse:)];
        objAPI = nil;
        }
    }
    
}

-(void)jsonDataRegistrationResponse:(id)responseDict

{
    NSLog(@"responseDict....%@",responseDict);
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        alert.tag=111;
        [alert show];
       }
    else if([[responseDict valueForKey:@"success"] integerValue]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                                   cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if(alertView.tag==111)
    {
        userName.text=@"";
        password.text=@"";
        countryName.text=@"";
        email.text=@"";
        NickName.text=@"";
        [self.navigationController popViewControllerAnimated:NO];
  
    }
}
-(void)cancelButtonPressed
{
    [self.navigationController popViewControllerAnimated:NO];
  
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    
    if(actionSheet.tag==111&buttonIndex==0)
    {
        appDelegate().orientation=YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:NO completion:nil];
    }
    else if (actionSheet.tag==111&buttonIndex==1)
    {
        appDelegate().orientation=YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:NO completion:nil];
    }
}

#pragma mark - ---------------------------------ImagePickerController Delegate----------------------------------

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *representation = [myasset defaultRepresentation];
        fileName = [representation filename];
        appDelegate().fileName =[NSString stringWithFormat:@"%@",fileName];
        NSLog(@"fileName : %@",fileName);
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:imageURL
                   resultBlock:resultblock
                  failureBlock:nil];
    //UIImage *image=[self scaleAndRotateImage: [info objectForKey:UIImagePickerControllerOriginalImage]];

//    UIImage *originalImage =image;
//    CGSize destinationSize =CGSizeMake(81, 91);
//    UIGraphicsBeginImageContext(destinationSize);
//    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    upload_ImageView =[[UIImageView alloc]init];
    [profileImageButton setBackgroundImage:image forState:UIControlStateNormal];
    upload_ImageView.image=image;
    appDelegate().orientation=NO;
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    appDelegate().orientation=NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIImage *) scaleAndRotateImage: (UIImage *)image
{
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


#pragma mark-
#pragma mark TextField Delegate Method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 36) ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    
     if(sender.tag==333)
    {
        [scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
        
    }
    else if(sender.tag==444)
    {
        [scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
        
    }
    else if(sender.tag==444)
    {
        [scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
        
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==444)
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
    else if (textField.tag==555)
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
}

-(void)textFieldDone:(UITextField*)textField
{
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    scrollView.scrollEnabled=YES;
    //    [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    if (textField == userName)
    {
        [userName resignFirstResponder];
        [password   becomeFirstResponder];
    }
    else if (textField == password)
    {
        [password resignFirstResponder];
        [countryName becomeFirstResponder];
    }
    else if (textField==countryName)
    {
        [countryName resignFirstResponder];
        [email becomeFirstResponder];
    }
    else if (textField==email)
    {
        [email resignFirstResponder];
    }
    else if (textField==NickName)
    {
        [textField resignFirstResponder];
        [NickName resignFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
