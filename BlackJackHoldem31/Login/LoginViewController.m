//
//  LoginViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "LoginViewController.h"
#import "GameAreaViewController.h"
#import "SelectViewController.h"
#import "RegistrationViewController.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"
#import "UIImageView+WebCache.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField    *userName;
    UITextField    *password;
    UIScrollView   *scrollView;
}
@synthesize progressView;

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor  colorWithRed:206.0/255.0f green:224.0/255.0f blue:218.0/255.0f alpha:1.0f];
    
    /***
     * ScrollView
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
    image =[UIImage imageNamed:@"loginbg.png"];
    }
    else
    {
    image =[UIImage imageNamed:@"loginbg_iphone4.png"];
    }
    

    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width, 320);
    [scrollView addSubview:imageViewBG];
    
    
    /***
     * TextFields background ImageViews
     **/

    UIImageView *TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(135+42*isiPhone5(), 145, 213, 31);//177
    [scrollView addSubview:TFBg];
    
    
    /***
     * UserName TextField
     **/
    
    userName=[[UITextField alloc]initWithFrame:CGRectMake(142+42*isiPhone5(), 147, 205, 30)];//185
    userName.backgroundColor=[UIColor clearColor];
    userName.textColor=[UIColor blackColor];
    userName.delegate=self;
    userName.tag=111;
    userName.clearButtonMode=YES;
    userName.placeholder =@"Username";
    userName.returnKeyType = UIReturnKeyNext;
    userName.autocorrectionType=UITextAutocorrectionTypeNo;
    userName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    userName.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];//TimesNewRomanPSMT
    userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [scrollView addSubview:userName];
    
    
    
    TFBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginfield"]];
    TFBg.backgroundColor=[UIColor clearColor];
    TFBg.clipsToBounds=YES;
    TFBg.frame=CGRectMake(135+42*isiPhone5(), 185, 213, 31);
    [scrollView addSubview:TFBg];
    
    /***
     * Password TextField
     **/
    
    password=[[UITextField alloc]initWithFrame:CGRectMake(142+42*isiPhone5(), 187, 205, 30)];//180
    password.backgroundColor=[UIColor clearColor];
    password.textColor=[UIColor blackColor];
    password.delegate=self;
    password.tag=222;
    password.clearButtonMode=YES;
    password.placeholder =@"Password";
    password.returnKeyType = UIReturnKeyDone;
    password.autocorrectionType=UITextAutocorrectionTypeNo;
    password.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    password.font=[UIFont fontWithName:@"ProximaNova-Regular" size:20.0];
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [scrollView addSubview:password];
    

    
    /***
     * Login Button
     **/
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton addTarget:self
                    action:@selector(loginButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    loginButton.backgroundColor =[UIColor clearColor];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"loginbtn.png"] forState:UIControlStateNormal];
    
    loginButton.frame = CGRectMake(214.5+44.5*isiPhone5(), 245, 51, 51);//259
    [scrollView addSubview:loginButton];
    
    
    /***
     * Rember Button Button
     **/
    
    
    rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberButton.backgroundColor =[UIColor clearColor];
    [rememberButton setBackgroundImage:[UIImage imageNamed:@"before-click"] forState:UIControlStateNormal];
    [rememberButton addTarget:self
                       action:@selector(rememberButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    rememberButton.frame = CGRectMake(115+40*isiPhone5(), 225,13,13);
    [scrollView addSubview:rememberButton];
    
       /***
     * Remeber Me Label
     **/
    
    UILabel* rememberLbl = [[UILabel alloc] init];
    rememberLbl.frame = CGRectMake(129+40*isiPhone5(), 225,71 , 16);
    rememberLbl.textAlignment = NSTextAlignmentCenter;
    rememberLbl.textColor = [UIColor  whiteColor];
    rememberLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    rememberLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keepmelogin.png"]];
    rememberLbl.text=@"";
    [scrollView addSubview:rememberLbl];
    
    
    /***
     * Regsier Button
     **/
    
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton addTarget:self
                    action:@selector(registerButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    registerButton.backgroundColor =[UIColor clearColor];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"new-user"] forState:UIControlStateNormal];
    
    registerButton.frame = CGRectMake(225+43*isiPhone5(), 227, 42, 16);
    [scrollView addSubview:registerButton];
    
    /***
     * facebook Button
     **/
    
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton addTarget:self
                       action:@selector(facebookButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    facebookButton.backgroundColor =[UIColor clearColor];
    [facebookButton setBackgroundImage:[UIImage imageNamed:@"login-with-facebook"] forState:UIControlStateNormal];
    
    facebookButton.frame = CGRectMake(295+40*isiPhone5(), 222, 72, 22);
    [scrollView addSubview:facebookButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    userName.text=@"";
    password.text=@"";
}

#pragma mark Registration Button Action

-(void)registerButtonPressed{
    RegistrationViewController *registerView =[[RegistrationViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:NO];
}

#pragma mark Facebook Button Action

-(void)facebookButtonPressed{
    WebServiceInterface *objAPI =[WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Fetching details from facebook"];
    
    [FBSession openActiveSessionWithReadPermissions:@[@"email",@"user_location",@"user_birthday",@"user_hometown"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
     {
         NSLog(@"state %u",state);
         NSLog(@"session %@",session);
         switch (state)
         {
             case FBSessionStateOpen:
             {
                 [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                     if (error) {
                         
                         NSLog(@"error:%@",error);
                         
                     }
                     else
                     {
                         NSLog(@"user..%@",user);
                         NSLog(@"Location name >>> %@", [user objectForKey:@"location"][@"name"]);
                         
                         NSString *usernameText = [user objectForKey:@"name"];
                         NSString *countryText = [NSString stringWithFormat:@"%@",user.location[@"name"]];
                         NSString *emailText = [user objectForKey:@"email"] ;
                         NSString *nickNameText = [user objectForKey:@"first_name"];
                         
                         if(usernameText.length==0||countryText.length==0||emailText.length==0||nickNameText.length==0||countryText == nil ||[countryText isEqualToString:@"(null)"]||[nickNameText isEqualToString:@"(null)"]||[emailText isEqualToString:@"(null)"]||[usernameText isEqualToString:@"(null)"]){
                              [objAPI hideProgressView:self.progressView];
                             
                             UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please register from application as some feilds are empty in your facebook account" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
                             alert.tag=222;
                             [alert show];
                         
                         }
                         else
                         {
                             NSString *imageUrl = [[NSString alloc] initWithFormat: @"https://graph.facebook.com/%@/picture?width=%@&height=%@", [user objectForKey:@"id"],@"200",@"200"];
                          NSLog(@"imageUrl %@",imageUrl);
                        NSData *imgData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                         objAPI.showActivityIndicator = YES;
                         NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
                         NSLog(@"image---> = %@",imageUrl);
                         NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=registration&username=%@&password=%@&country_name=%@&email=%@&user_type=Facebook&fb_id=%@&deviceid=%@&devicetoken=%@&devicetype=%@&nick_name=%@",[user objectForKey:@"name"],@"",[NSString stringWithFormat:@"%@",user.location[@"name"]],[user objectForKey:@"email"],[user objectForKey:@"id"],@"1",@"1",@"1",[user objectForKey:@"first_name"]];
                         if(imgData)
                         {
                          objAPI.imageData = imgData;
                          appDelegate().fileName=@"Sample.jpg";
                          [postData appendString:[NSString stringWithFormat:@"&uploadfile=%@",@"Sample"]];
                         }
                         [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataRegistrationResponse:)];
                         }
                     }
                 }];
                 
             }
                 break;
                 
             case FBSessionStateClosed:
                 
             case FBSessionStateClosedLoginFailed:
             {
                 [FBSession.activeSession closeAndClearTokenInformation];
                 WebServiceInterface *objAPI =[WebServiceInterface sharedManager];
                 [objAPI hideProgressView:self.progressView];
             }
                 break;
                 
             default:
                 break;
         }
         
     } ];
}
-(void)jsonDataRegistrationResponse:(id)responseDict{
     WebServiceInterface *objAPI =[WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1){
        [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"nick_name"] forKey:@"NickName"];
        [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"user_id"] forKey:@"UserID" ];
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Facebook"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        alert.tag=111;
        [alert show];
    }
    else if([[responseDict valueForKey:@"success"] integerValue]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
}
#pragma mark Remberbutton Button Action


-(void)rememberButtonPressed{
    if(rememberButton.selected){
        rememberButton.selected=NO;
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"before-click"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"KeepLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"KeepLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        rememberButton.selected=YES;
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"after-click"] forState:UIControlStateSelected];
    }
}

#pragma mark Login Button Action

-(void)loginButtonPressed{
    NSString *usernameText = [[userName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *passwordText = [[password text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( usernameText.length == 0 || passwordText.length == 0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:@"Username or Password should not be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Logging in..."];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        
        NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=login&username=%@&password=%@",usernameText,passwordText];
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataLoginResponse:)];
        objAPI = nil;
    }
}
-(void)jsonDataLoginResponse:(id)responseDict{
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1){
        [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"nick_name"] forKey:@"NickName"];
        [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"user_id"] forKey:@"UserID" ];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Facebook"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:self
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        alert.tag=111;
        [alert show];
    }
    else if([[responseDict valueForKey:@"success"] integerValue]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(rememberButton.selected){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"KeepLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"KeepLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if(alertView.tag==111){
        userName.text=@"";
        password.text=@"";
        SelectViewController *selectView =[[SelectViewController alloc]init];
        [self.navigationController pushViewController:selectView animated:NO];
    }
    else if (alertView.tag==222){
        RegistrationViewController *registerView =[[RegistrationViewController alloc]init];
        registerView.isFromEdit=NO;
        [self.navigationController pushViewController:registerView animated:NO];
    }
}

#pragma mark-
#pragma mark TextField Delegate Method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 36) ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)sender{
    
    if(sender.tag==111){
        [scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
    }
    else if(sender.tag==222){
        [scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
     if(textField.tag==222){
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

-(void)textFieldDone:(UITextField*)textField{
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    scrollView.scrollEnabled=YES;
    if (textField == userName){
        [userName resignFirstResponder];
        [password   becomeFirstResponder];
    }
    else if (textField == password){
        [password resignFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
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
