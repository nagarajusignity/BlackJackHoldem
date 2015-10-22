//
//  SelectViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "SelectViewController.h"
#import "GameAreaViewController.h"
#import "DocumentViewController.h"
#import "Buy-InViewController.h"
#import "RegistrationViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
    image=[UIImage imageNamed:@"select-space"];
    }
    else
    {
        image =[UIImage imageNamed:@"select-space_iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    
    /***
     * Login Button
     **/
    
    UIButton *playNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playNowButton addTarget:self
                    action:@selector(playNowPressed)
          forControlEvents:UIControlEventTouchUpInside];
    playNowButton.backgroundColor =[UIColor clearColor];
    [playNowButton setBackgroundImage:[UIImage imageNamed:@"playnow"] forState:UIControlStateNormal];
    
    playNowButton.frame = CGRectMake(158+48*isiPhone5(), 180, 170, 56);//206
    [self.view addSubview:playNowButton];
    
    /***
     * Id Document Button
     **/
    
    UIButton *docButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [docButton addTarget:self
                      action:@selector(docButtonPressed)
            forControlEvents:UIControlEventTouchUpInside];
    docButton.backgroundColor =[UIColor clearColor];
    [docButton setBackgroundImage:[UIImage imageNamed:@"document"] forState:UIControlStateNormal];
    docButton.frame = CGRectMake(158+48*isiPhone5(), 240, 170, 56);
    [self.view addSubview:docButton];
    
    
    /***
     * Logout Button
     **/
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton addTarget:self
                   action:@selector(logoutButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    logoutButton.backgroundColor =[UIColor clearColor];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    logoutButton.frame = CGRectMake(20, 15, 25, 26);
    [self.view addSubview:logoutButton];
    
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"Facebook"])
    {
    /***
     * Settings Button
     **/
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsButton addTarget:self
                     action:@selector(settingsButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    settingsButton.backgroundColor =[UIColor clearColor];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    settingsButton.frame = CGRectMake(440+68*isiPhone5(), 15, 25, 26);
    [self.view addSubview:settingsButton];
    }
}

#pragma mark Back Button Action

-(void)logoutButtonPressed{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Are you sure to logout ?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes", nil];
    alert.tag=111;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==111&&buttonIndex==1){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"KeepLogin"];
        [[NSUserDefaults standardUserDefaults]setValue:0 forKey:@"UserID" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        LoginViewController *loginview =[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginview animated:NO];
    }
}
-(void)settingsButtonPressed
{
    RegistrationViewController *detailsView =[[RegistrationViewController alloc]init];
    detailsView.isFromEdit=YES;
    [self.navigationController pushViewController:detailsView animated:NO];
}

#pragma mark Play Button Action

-(void)playNowPressed{
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    NSLog(@"allViewControllers %@",allViewControllers);
    Buy_InViewController *buyin=[[Buy_InViewController alloc]init];
    buyin.isFromPlayNow=YES;
    buyin.isFromDocument=NO;
    [self.navigationController pushViewController:buyin animated:NO];
}

#pragma mark Document Button Action

-(void)docButtonPressed{
    DocumentViewController *documentView =[[DocumentViewController alloc]init];
    [self.navigationController pushViewController:documentView animated:NO];
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
