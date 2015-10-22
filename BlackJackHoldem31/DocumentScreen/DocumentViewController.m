//
//  DocumentViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "DocumentViewController.h"
#import "AppDelegate.h"

@interface DocumentViewController ()

@end

@implementation DocumentViewController
{
    UIScrollView    *scrollView;
}
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
    image=[UIImage imageNamed:@"profilebg"];
    }
    else
    {
    image=[UIImage imageNamed:@"profilebg_iphone4"];
    }
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    /***
     * Top IMage ImageView
     **/
    
    UIImage *topImage =[UIImage imageNamed:@"profile_heading"];
    UIImageView *topImageViewBG=[[UIImageView alloc]initWithImage:topImage];
    topImageViewBG.frame=CGRectMake(124.0+44*isiPhone5(), 5.0,topImage.size.width , topImage.size.height);
    [self.view addSubview:topImageViewBG];
    
    /***
     * Scroll
     **/
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50,480+88*isiPhone5(), 320)];
    [scrollView setContentSize:CGSizeMake(480+88*isiPhone5() , 320+180)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    /***
     * LaftBar IMage ImageView
     **/
    
    UIImage *leftBarImage =[UIImage imageNamed:@"profileleftbar"];
    UIImageView *leftBarImageViewBG=[[UIImageView alloc]initWithImage:leftBarImage];
    leftBarImageViewBG.frame=CGRectMake(8+45*isiPhone5(), 0,leftBarImage.size.width , leftBarImage.size.height);
    [scrollView addSubview:leftBarImageViewBG];
    
    /***
     * Client1 IMage ImageView
     **/
    
    UIImage *client1Image =[UIImage imageNamed:@"client1"];
    UIImageView *client1ImageViewBG=[[UIImageView alloc]initWithImage:client1Image];
    client1ImageViewBG.frame=CGRectMake(17, 10,client1Image.size.width , client1Image.size.height);
    [leftBarImageViewBG addSubview:client1ImageViewBG];
    
    /***
     * Top Profile IMage ImageView
     **/
    
    UIImage *topprofileImage =[UIImage imageNamed:@"profileimg1.png"];
    UIImageView *topprofileImageViewBG=[[UIImageView alloc]initWithImage:topprofileImage];
    topprofileImageViewBG.frame=CGRectMake(13, 10,topprofileImage.size.width , topprofileImage.size.height);
    [leftBarImageViewBG addSubview:topprofileImageViewBG];
    
    /***
     * Name Label
     **/
    
    UILabel* nameLbl = [[UILabel alloc] init];
    nameLbl.frame = CGRectMake(5,topprofileImage.size.height+10, leftBarImage.size.width-10, 20);
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.textColor = [UIColor  whiteColor];
    nameLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    nameLbl.backgroundColor = [UIColor clearColor];
    nameLbl.text=@"Alain T Copper";
    [leftBarImageViewBG addSubview:nameLbl];
    
    /***
     * First Shadow IMage ImageView
     **/
    
    UIImage *firstShadowImage =[UIImage imageNamed:@"idbox"];
    UIImageView *firstShadowImageView=[[UIImageView alloc]initWithImage:firstShadowImage];
    firstShadowImageView.frame=CGRectMake(10, nameLbl.frame.size.height+100,firstShadowImage.size.width , firstShadowImage.size.height);
    [leftBarImageViewBG addSubview:firstShadowImageView];
    
    /***
     * FirtsId Label
     **/
    
    UILabel* firstIdLbl = [[UILabel alloc] init];
    firstIdLbl.frame = CGRectMake(0,0,firstShadowImage.size.width , firstShadowImage.size.height);
    firstIdLbl.textAlignment = NSTextAlignmentCenter;
    firstIdLbl.textColor = [UIColor  whiteColor];
    firstIdLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    firstIdLbl.backgroundColor = [UIColor clearColor];
    firstIdLbl.text=@"ID:4345";
    [firstShadowImageView addSubview:firstIdLbl];

    
    /***
     * Client2 IMage ImageView
     **/
    
    UIImage *client2Image =[UIImage imageNamed:@"client2"];
    UIImageView *client2ImageViewBG=[[UIImageView alloc]initWithImage:client2Image];
    client2ImageViewBG.frame=CGRectMake(17, firstIdLbl.frame.size.height+122,client2Image.size.width , client2Image.size.height);
    [leftBarImageViewBG addSubview:client2ImageViewBG];
    
    /***
     * Bottom Profile IMage ImageView
     **/
    
    UIImage *bottomprofileImage =[UIImage imageNamed:@"profileimg2"];
    UIImageView *bottomprofileImageViewBG=[[UIImageView alloc]initWithImage:bottomprofileImage];
    bottomprofileImageViewBG.frame=CGRectMake(13, firstIdLbl.frame.size.height+120,bottomprofileImage.size.width , bottomprofileImage.size.height);
    [leftBarImageViewBG addSubview:bottomprofileImageViewBG];
    
    
    /***
     * Second Name Label
     **/
    
    UILabel* secondNameLbl = [[UILabel alloc] init];
    secondNameLbl.frame = CGRectMake(5, 235,leftBarImage.size.width-10 , 20);
    secondNameLbl.textAlignment = NSTextAlignmentCenter;
    secondNameLbl.textColor = [UIColor  whiteColor];
    secondNameLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    secondNameLbl.backgroundColor = [UIColor clearColor];
    secondNameLbl.text=@"Alain";
    [leftBarImageViewBG addSubview:secondNameLbl];
    
    /***
     * Second Shadow IMage ImageView
     **/
    
    UIImage *secondShadowImage =[UIImage imageNamed:@"idbox"];
    UIImageView *secondShadowImageView=[[UIImageView alloc]initWithImage:secondShadowImage];
    secondShadowImageView.frame=CGRectMake(10, 255,secondShadowImage.size.width , secondShadowImage.size.height);
    [leftBarImageViewBG addSubview:secondShadowImageView];
    
    /***
     * FirtsId Label
     **/
    
    UILabel* secondIdLbl = [[UILabel alloc] init];
    secondIdLbl.frame = CGRectMake(0,0,secondShadowImage.size.width , secondShadowImage.size.height);
    secondIdLbl.textAlignment = NSTextAlignmentCenter;
    secondIdLbl.textColor = [UIColor  whiteColor];
    secondIdLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    secondIdLbl.backgroundColor = [UIColor clearColor];
    secondIdLbl.text=@"33333 ec";
    [secondShadowImageView addSubview:secondIdLbl];
    
    
    /***
     * Buy Chips Button
     **/
    
    UIButton *buyChipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyChipsButton addTarget:self
                  action:@selector(buyChipsButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    buyChipsButton.backgroundColor =[UIColor clearColor];
    [buyChipsButton setBackgroundImage:[UIImage imageNamed:@"Aperturesymbol"] forState:UIControlStateNormal];
    buyChipsButton.frame = CGRectMake(20, 290, 78, 48);
    [leftBarImageViewBG addSubview:buyChipsButton];
    
    /***
     * LeftBar IMage ImageView
     **/
    
    UIImage *rightBarImage =[UIImage imageNamed:@"profilerightbar"];
    UIImageView *rightBarImageViewBG=[[UIImageView alloc]initWithImage:rightBarImage];
    rightBarImageViewBG.frame=CGRectMake(116+48*isiPhone5(), 0,rightBarImage.size.width , rightBarImage.size.height);
    [scrollView addSubview:rightBarImageViewBG];
    
    /***
     * Solarbank Title IMage ImageView
     **/
    
    UIImage *solarTitleImage =[UIImage imageNamed:@"solerbank"];
    UIImageView *solarTitleImageView=[[UIImageView alloc]initWithImage:solarTitleImage];
    solarTitleImageView.frame=CGRectMake(18,17,solarTitleImage.size.width , solarTitleImage.size.height);
    [rightBarImageViewBG addSubview:solarTitleImageView];
    
    UILabel* solarBankLbl = [[UILabel alloc] init];
    solarBankLbl.frame = CGRectMake(10,0,solarTitleImage.size.width-100 , solarTitleImage.size.height);
    solarBankLbl.textAlignment = NSTextAlignmentLeft;
    solarBankLbl.textColor = [UIColor  whiteColor];
    solarBankLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:12];
    solarBankLbl.backgroundColor = [UIColor clearColor];
    solarBankLbl.text=@"SOLAR BANK ACCOUNT";
    [solarTitleImageView addSubview:solarBankLbl];
    
    UILabel* playingLbl = [[UILabel alloc] init];
    playingLbl.frame = CGRectMake(220,0,100 , solarTitleImage.size.height);
    playingLbl.textAlignment = NSTextAlignmentRight;
    playingLbl.textColor = [UIColor  whiteColor];
    playingLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:12];
    playingLbl.backgroundColor = [UIColor clearColor];
    playingLbl.text=@"PLAYING NOW";
    [solarTitleImageView addSubview:playingLbl];
    
    /***
     * Table IMage ImageView
     **/
    
    UIImage *tabelImage =[UIImage imageNamed:@"tableprofile"];
    UIImageView *tabelImageView=[[UIImageView alloc]initWithImage:tabelImage];
    tabelImageView.frame=CGRectMake(18,41,tabelImage.size.width , tabelImage.size.height);
    [rightBarImageViewBG addSubview:tabelImageView];
    
    
    /***
     * Earth Score Label
     **/
    
    UILabel* earthScoreLbl = [[UILabel alloc] init];
    earthScoreLbl.frame = CGRectMake(90,3,150,20);
    earthScoreLbl.textAlignment = NSTextAlignmentRight;
    earthScoreLbl.textColor = [UIColor  whiteColor];
    earthScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    earthScoreLbl.backgroundColor = [UIColor clearColor];
    earthScoreLbl.text=@"100,000 mc";
    [tabelImageView addSubview:earthScoreLbl];
    
    /***
     * LUNA Score Label
     **/
    
    UILabel* lunaScoreLbl = [[UILabel alloc] init];
    lunaScoreLbl.frame = CGRectMake(90,29,150,20);
    lunaScoreLbl.textAlignment = NSTextAlignmentRight;
    lunaScoreLbl.textColor = [UIColor  whiteColor];
    lunaScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    lunaScoreLbl.backgroundColor = [UIColor clearColor];
    lunaScoreLbl.text=@"100,00 lc";
    [tabelImageView addSubview:lunaScoreLbl];
    
    /***
     * Mars Score Label
     **/
    
    UILabel* marsScoreLbl = [[UILabel alloc] init];
    marsScoreLbl.frame = CGRectMake(90,52,150,20);
    marsScoreLbl.textAlignment = NSTextAlignmentRight;
    marsScoreLbl.textColor = [UIColor  whiteColor];
    marsScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    marsScoreLbl.backgroundColor = [UIColor clearColor];
    marsScoreLbl.text=@"100,0 mc";
    [tabelImageView addSubview:marsScoreLbl];
    
    /***
     * CERES Score Label
     **/
    
    UILabel* ceresScoreLbl = [[UILabel alloc] init];
    ceresScoreLbl.frame = CGRectMake(90,77,150,20);
    ceresScoreLbl.textAlignment = NSTextAlignmentRight;
    ceresScoreLbl.textColor = [UIColor  whiteColor];
    ceresScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    ceresScoreLbl.backgroundColor = [UIColor clearColor];
    ceresScoreLbl.text=@"100 cc";
    [tabelImageView addSubview:ceresScoreLbl];
    
    /***
     * IOA Score Label
     **/
    
    UILabel* ioaScoreLbl = [[UILabel alloc] init];
    ioaScoreLbl.frame = CGRectMake(90,103,150,20);
    ioaScoreLbl.textAlignment = NSTextAlignmentRight;
    ioaScoreLbl.textColor = [UIColor  whiteColor];
    ioaScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    ioaScoreLbl.backgroundColor = [UIColor clearColor];
    ioaScoreLbl.text=@"10 cc";
    [tabelImageView addSubview:ioaScoreLbl];
    
    /***
     * TITAN Score Label
     **/
    
    UILabel* titanScoreLbl = [[UILabel alloc] init];
    titanScoreLbl.frame = CGRectMake(90,128,150,20);
    titanScoreLbl.textAlignment = NSTextAlignmentRight;
    titanScoreLbl.textColor = [UIColor  whiteColor];
    titanScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    titanScoreLbl.backgroundColor = [UIColor clearColor];
    titanScoreLbl.text=@"1 tc";
    [tabelImageView addSubview:titanScoreLbl];
    
    /***
     * CAPRI Score Label
     **/
    
    UILabel* capriScoreLbl = [[UILabel alloc] init];
    capriScoreLbl.frame = CGRectMake(90,152,150,20);
    capriScoreLbl.textAlignment = NSTextAlignmentRight;
    capriScoreLbl.textColor = [UIColor  whiteColor];
    capriScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    capriScoreLbl.backgroundColor = [UIColor clearColor];
    capriScoreLbl.text=@"0 cac";
    [tabelImageView addSubview:capriScoreLbl];
    
    
    /***
     * BALDR Score Label
     **/
    
    UILabel* baldrScoreLbl = [[UILabel alloc] init];
    baldrScoreLbl.frame = CGRectMake(90,178,150,20);
    baldrScoreLbl.textAlignment = NSTextAlignmentRight;
    baldrScoreLbl.textColor = [UIColor  whiteColor];
    baldrScoreLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    baldrScoreLbl.backgroundColor = [UIColor clearColor];
    baldrScoreLbl.text=@"0 bc";
    [tabelImageView addSubview:baldrScoreLbl];

    
    /***
     * Profile Content ImageView
     **/
    
    UIImage *profileContentImage =[UIImage imageNamed:@"profilecontent"];
    UIImageView *profileContentImageView=[[UIImageView alloc]initWithImage:profileContentImage];
    profileContentImageView.frame=CGRectMake(18,245,profileContentImage.size.width , profileContentImage.size.height);
    [rightBarImageViewBG addSubview:profileContentImageView];
    
    
    /***
     * Status Label
     **/
    
    UILabel* statusLbl = [[UILabel alloc] init];
    statusLbl.frame = CGRectMake(30,5,260 , 20);
    statusLbl.textAlignment = NSTextAlignmentRight;
    statusLbl.textColor = [UIColor  whiteColor];
    statusLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    statusLbl.backgroundColor = [UIColor clearColor];
    statusLbl.text=@"To Gain Worker Status requires 100,000 mc";
    [profileContentImageView addSubview:statusLbl];
    
    /***
     * CitizenshipLabel Label
     **/
    
    UILabel* citizenLbl = [[UILabel alloc] init];
    citizenLbl.frame = CGRectMake(40,20,240, 20);
    citizenLbl.textAlignment = NSTextAlignmentRight;
    citizenLbl.textColor = [UIColor  whiteColor];
    citizenLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    citizenLbl.backgroundColor = [UIColor clearColor];
    citizenLbl.text=@"To Earn Citizenship requires 100,000 tc";
    [profileContentImageView addSubview:citizenLbl];

    
    /***
     * Statusbar Left ImageView
     **/
    
    UIImage *statusBarLeftImage =[UIImage imageNamed:@"statusbarleft"];
    UIImageView *statusBarLeftImageView=[[UIImageView alloc]initWithImage:statusBarLeftImage];
    statusBarLeftImageView.frame=CGRectMake(18,292,statusBarLeftImage.size.width , statusBarLeftImage.size.height);
    [rightBarImageViewBG addSubview:statusBarLeftImageView];
    
    /***
     * Journy Date Label
     **/
    
    UILabel* dateLbl = [[UILabel alloc] init];
    dateLbl.frame = CGRectMake(85,0,70 , 24);
    dateLbl.textAlignment = NSTextAlignmentRight;
    dateLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    dateLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:10];
    dateLbl.backgroundColor = [UIColor clearColor];
    dateLbl.text=@"24 FEB 2014";
    [statusBarLeftImageView addSubview:dateLbl];
    
    /***
     * Wins Label
     **/
    
    UILabel* winsLbl = [[UILabel alloc] init];
    winsLbl.frame = CGRectMake(85,25,70 , 24);
    winsLbl.textAlignment = NSTextAlignmentRight;
    winsLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    winsLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    winsLbl.backgroundColor = [UIColor clearColor];
    winsLbl.text=@"3";
    [statusBarLeftImageView addSubview:winsLbl];
    
    /***
     * Statusbar Rifht ImageView
     **/
    
    UIImage *statusBarRightImage =[UIImage imageNamed:@"statusbarright"];
    UIImageView *statusBarRightImageView=[[UIImageView alloc]initWithImage:statusBarRightImage];
    statusBarRightImageView.frame=CGRectMake(184,292,statusBarRightImage.size.width , statusBarRightImage.size.height);
    [rightBarImageViewBG addSubview:statusBarRightImageView];
    
    /***
     * Last Location Label
     **/
    
    UILabel* locationLbl = [[UILabel alloc] init];
    locationLbl.frame = CGRectMake(85,3,70 , 24);
    locationLbl.textAlignment = NSTextAlignmentRight;
    locationLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    locationLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    locationLbl.backgroundColor = [UIColor clearColor];
    locationLbl.text=@"MARS";
    [statusBarRightImageView addSubview:locationLbl];
    
    /***
     * Bonus Label
     **/
    
    UILabel* bonusLbl = [[UILabel alloc] init];
    bonusLbl.frame = CGRectMake(85,28,70 , 24);
    bonusLbl.textAlignment = NSTextAlignmentRight;
    bonusLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    bonusLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:14];
    bonusLbl.backgroundColor = [UIColor clearColor];
    bonusLbl.text=@"4,000 ec";
    [statusBarRightImageView addSubview:bonusLbl];
    /***
     * Invite and Buy Background ImageView
     **/
    
    UIImage *inviteImage =[UIImage imageNamed:@"inviteandbuy"];
    UIImageView *inviteImageView=[[UIImageView alloc]initWithImage:inviteImage];
    inviteImageView.frame=CGRectMake(40,363,inviteImage.size.width , inviteImage.size.height);
    [rightBarImageViewBG addSubview:inviteImageView];
    
    
    /***
     * Buy Chips Button
     **/
    
    UIButton *chipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chipsButton addTarget:self
                     action:@selector(chipsButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    chipsButton.backgroundColor =[UIColor clearColor];
    //[chipsButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [chipsButton setTitle:@"Buy Chips" forState:UIControlStateNormal];
    [chipsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chipsButton.frame = CGRectMake(30, 11, 100, 34);
    [inviteImageView addSubview:chipsButton];
    
    /***
     * Invite Friends Button
     **/
    
    UIButton *inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [inviteButton addTarget:self
                  action:@selector(inviteButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    inviteButton.backgroundColor =[UIColor clearColor];
    //[inviteButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [inviteButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
    [inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inviteButton.frame = CGRectMake(145,11, 120, 34);
    [inviteImageView addSubview:inviteButton];
    
    /***
     * Back Button
     **/
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor =[UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    //[backButton setTitle:@"Back" forState:UIControlStateNormal];
    //[backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //backButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:20];
    backButton.frame = CGRectMake(20, 15, 60, 22);
    [self.view addSubview:backButton];
}

-(void)backButtonPressed

{
 [self.navigationController popViewControllerAnimated:NO];
}


-(void)buyChipsButtonPressed
{
    
}

-(void)chipsButtonPressed
{
    
}

-(void)inviteButtonPressed
{
    
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
