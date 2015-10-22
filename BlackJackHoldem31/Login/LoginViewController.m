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

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField    *userName;
    UITextField    *password;
    UIScrollView   *scrollView;
}
- (void)viewDidLoad
{
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
    //[userName addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
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
    //[password addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
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
    
    registerButton.frame = CGRectMake(220+43*isiPhone5(), 227, 56, 14);
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

#pragma mark Registration Button Action

-(void)registerButtonPressed
{
    RegistrationViewController *registerView =[[RegistrationViewController alloc]init];
    
    [self.navigationController pushViewController:registerView animated:NO];
    
}

#pragma mark Facebook Button Action


-(void)facebookButtonPressed
{
    SelectViewController *selectView =[[SelectViewController alloc]init];
    [self.navigationController pushViewController:selectView animated:NO];
}

#pragma mark Remberbutton Button Action


-(void)rememberButtonPressed
{
    if(rememberButton.selected)
    {   rememberButton.selected=NO;
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"before-click"] forState:UIControlStateNormal];
    }
    else
    {   rememberButton.selected=YES;
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"after-click"] forState:UIControlStateSelected];
    }
}

#pragma mark Login Button Action

-(void)loginButtonPressed
{
    NSString *usernameText = [[userName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *passwordText = [[password text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( usernameText.length == 0 || passwordText.length == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                        message:@"Username or Password should not be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        userName.text=@"";
        password.text=@"";
        SelectViewController *selectView =[[SelectViewController alloc]init];
        [self.navigationController pushViewController:selectView animated:NO];
    }
}
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}
#pragma mark-
#pragma mark TextField Delegate Method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 36) ? NO : YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)sender
{
    
    if(sender.tag==111)
    {
        [scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
    }
    else if(sender.tag==222)
    {
        [scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
        
        
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
     if(textField.tag==222)
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
    }
    else
    {
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
