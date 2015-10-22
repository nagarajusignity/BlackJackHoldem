//
//  DocumentViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "DocumentViewController.h"
#import "AppDelegate.h"
#import "WebServiceInterface.h"
#import "UIImageView+WebCache.h"
#import "Buy-InViewController.h"
#import "EmptyChairs.h"
#import "InappPurchaseView.h"
#import "FreeChipsViewController.h"

@interface DocumentViewController ()

@end

@implementation DocumentViewController
{
    UIScrollView    *scrollView;
}
@synthesize progressView;

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
     * Back Button
     **/
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self
                   action:@selector(backButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor =[UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(20, 15, 60, 22);
    [self.view addSubview:backButton];
    
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Getting Info"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=user_info&user_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataUserInfoResponse:)];
    objAPI = nil;
}
-(void)jsonDataUserInfoResponse:(id)responseDict
{
    //NSLog(@"responseDict....%@",responseDict);
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
    detailsArray =[[NSMutableArray alloc]init];
    eligibleLevels=[[NSMutableArray alloc]init];
    [detailsArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
    if([[responseDict valueForKey:@"levelscanPlaYed"] isKindOfClass:[NSMutableArray class]])
    {
    [eligibleLevels addObjectsFromArray:[responseDict valueForKey:@"levelscanPlaYed"]];
    }
    else if([[responseDict valueForKey:@"levelscanPlaYed"] isEqualToString:@"Not_Eligible"])
    {
       //[eligibleLevels addObjectsFromArray:[responseDict valueForKey:@"levelscanPlaYed"]];
    }
    [scrollView removeFromSuperview];
    [self LoadViewDetails];
    }

}
-(void)LoadViewDetails
{
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
    scrollView.userInteractionEnabled=YES;
    [self.view addSubview:scrollView];
    
    /***
     * LaftBar IMage ImageView
     **/
    
    UIImage *leftBarImage =[UIImage imageNamed:@"profileleftbar"];
    UIImageView *leftBarImageViewBG=[[UIImageView alloc]initWithImage:leftBarImage];
    leftBarImageViewBG.frame=CGRectMake(8+45*isiPhone5(), 0,leftBarImage.size.width , leftBarImage.size.height);
    leftBarImageViewBG.userInteractionEnabled=YES;
    [scrollView addSubview:leftBarImageViewBG];
    
    /***
     * Client1 IMage ImageView
     **/
    
    UIImageView *client1ImageViewBG=[[UIImageView alloc]init];
    client1ImageViewBG.frame=CGRectMake(17, 14,73 , 81);
    NSURL *myurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,[[detailsArray valueForKey:@"user_image"] objectAtIndex:0]]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:myurl]];
    client1ImageViewBG.image=image;
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
    nameLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    nameLbl.backgroundColor = [UIColor clearColor];
    nameLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"username"] objectAtIndex:0]];
    [leftBarImageViewBG addSubview:nameLbl];
    
    /***
     * First Shadow IMage ImageView
     **/
    
    UIImage *firstShadowImage =[UIImage imageNamed:@"idbox"];
    UIImageView *firstShadowImageView=[[UIImageView alloc]initWithImage:firstShadowImage];
    firstShadowImageView.frame=CGRectMake(10, nameLbl.frame.size.height+100,firstShadowImage.size.width , firstShadowImage.size.height);
    [leftBarImageViewBG addSubview:firstShadowImageView];
    
    /***
     * Country Label
     **/
    
    UILabel* firstCountryLbl = [[UILabel alloc] init];
    firstCountryLbl.frame = CGRectMake(0,0,firstShadowImage.size.width , firstShadowImage.size.height);
    firstCountryLbl.textAlignment = NSTextAlignmentCenter;
    firstCountryLbl.textColor = [UIColor  whiteColor];
    firstCountryLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstCountryLbl.backgroundColor = [UIColor clearColor];
    firstCountryLbl.text=[NSString stringWithFormat:@"Country:%@",[[detailsArray valueForKey:@"country_name"] objectAtIndex:0]];
    firstCountryLbl.adjustsFontSizeToFitWidth = YES;
    [firstShadowImageView addSubview:firstCountryLbl];
    
    
    /***
     * Client2 IMage ImageView
     **/
    
    UIImage *client2Image =[UIImage imageNamed:@"client2"];
    UIImageView *client2ImageViewBG=[[UIImageView alloc]init ];
    [client2ImageViewBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrl,[[detailsArray valueForKey:@"user_dummy_image"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"dummy_image.png"]];
    client2ImageViewBG.frame=CGRectMake(17, firstCountryLbl.frame.size.height+122,client2Image.size.width , client2Image.size.height);
    [leftBarImageViewBG addSubview:client2ImageViewBG];
    
    /***
     * Bottom Profile IMage ImageView
     **/
    
    UIImage *bottomprofileImage =[UIImage imageNamed:@"profileimg2"];
    UIImageView *bottomprofileImageViewBG=[[UIImageView alloc]initWithImage:bottomprofileImage];
    
    bottomprofileImageViewBG.frame=CGRectMake(13, firstCountryLbl.frame.size.height+120,bottomprofileImage.size.width , bottomprofileImage.size.height);
    [leftBarImageViewBG addSubview:bottomprofileImageViewBG];
    
    
     /***
       * Second Name Label
       **/
    
    UILabel* secondNameLbl = [[UILabel alloc] init];
    secondNameLbl.frame = CGRectMake(5, 230,leftBarImage.size.width-10 , 20);
    secondNameLbl.textAlignment = NSTextAlignmentCenter;
    secondNameLbl.textColor = [UIColor  whiteColor];
    secondNameLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondNameLbl.backgroundColor = [UIColor clearColor];
    secondNameLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"nick_name"] objectAtIndex:0]];
    [leftBarImageViewBG addSubview:secondNameLbl];
    
    /***
     * Rank Label
     **/
    
    UILabel* rankLbl = [[UILabel alloc] init];
    rankLbl.frame = CGRectMake(5, 245,leftBarImage.size.width-10 , 20);
    rankLbl.textAlignment = NSTextAlignmentCenter;
    rankLbl.textColor = [UIColor  whiteColor];
    rankLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    rankLbl.backgroundColor = [UIColor clearColor];
    rankLbl.text=@"Rank:Drone";
    [leftBarImageViewBG addSubview:rankLbl];
    
    /***
     * Id Label
     **/
    
    UILabel* idLbl = [[UILabel alloc] init];
    idLbl.frame = CGRectMake(5, 260,leftBarImage.size.width-10 , 20);
    idLbl.textAlignment = NSTextAlignmentCenter;
    idLbl.textColor = [UIColor  whiteColor];
    idLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    idLbl.backgroundColor = [UIColor clearColor];
    idLbl.text=[NSString stringWithFormat:@"ID:%@",[[detailsArray valueForKey:@"id"] objectAtIndex:0]];
    [leftBarImageViewBG addSubview:idLbl];
    
    /***
     * Second Shadow IMage ImageView
     **/
    
    UIImage *secondShadowImage =[UIImage imageNamed:@"idbox"];
    UIImageView *secondShadowImageView=[[UIImageView alloc]initWithImage:secondShadowImage];
    secondShadowImageView.frame=CGRectMake(10, 280,secondShadowImage.size.width , secondShadowImage.size.height);
    [leftBarImageViewBG addSubview:secondShadowImageView];
    
    /***
     * FirtsId Label
     **/
    
    UILabel* secondIdLbl = [[UILabel alloc] init];
    secondIdLbl.frame = CGRectMake(0,0,secondShadowImage.size.width , secondShadowImage.size.height);
    secondIdLbl.textAlignment = NSTextAlignmentCenter;
    secondIdLbl.textColor = [UIColor  whiteColor];
    secondIdLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondIdLbl.backgroundColor = [UIColor clearColor];
    secondIdLbl.text=[NSString stringWithFormat:@"%@ ec",[[detailsArray valueForKey:@"points_inEc"] objectAtIndex:0]];
    secondIdLbl.adjustsFontSizeToFitWidth = YES;
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
    buyChipsButton.frame = CGRectMake(20, 305, 78, 48);
    [leftBarImageViewBG addSubview:buyChipsButton];
    
    
    /***
     * Empty Chairs IMage ImageView
     **/
    
    UIImage *emptyChairImage =[UIImage imageNamed:@"chairs.png"];
    UIButton *empthChairsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [empthChairsButton addTarget:self
                       action:@selector(empthChairsButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    empthChairsButton.backgroundColor =[UIColor clearColor];
    [empthChairsButton setBackgroundImage:[UIImage imageNamed:@"chairs.png"] forState:UIControlStateNormal];
    empthChairsButton.frame = CGRectMake(7.5+45*isiPhone5(), 355,emptyChairImage.size.width , emptyChairImage.size.height);
    [scrollView addSubview:empthChairsButton];
    
    /***
     * LeftBar IMage ImageView
     **/
    
    UIImage *rightBarImage =[UIImage imageNamed:@"profilerightbar"];
    UIImageView *rightBarImageViewBG=[[UIImageView alloc]initWithImage:rightBarImage];
    rightBarImageViewBG.frame=CGRectMake(116+48*isiPhone5(), 0,rightBarImage.size.width , rightBarImage.size.height);
    rightBarImageViewBG.userInteractionEnabled=YES;
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
    solarBankLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    solarBankLbl.backgroundColor = [UIColor clearColor];
    solarBankLbl.text=@"SOLAR BANK ACCOUNT";
    [solarTitleImageView addSubview:solarBankLbl];
    
    UILabel* playingLbl = [[UILabel alloc] init];
    playingLbl.frame = CGRectMake(220,0,100 , solarTitleImage.size.height);
    playingLbl.textAlignment = NSTextAlignmentRight;
    playingLbl.textColor = [UIColor  whiteColor];
    playingLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    playingLbl.backgroundColor = [UIColor clearColor];
    playingLbl.text=@"PLAYING NOW";
    [solarTitleImageView addSubview:playingLbl];
    
    /***
     * Table IMage ImageView
     **/
    
    UIImage *tabelImage =[UIImage imageNamed:@"tableprofile"];
    UIImageView *tabelImageView=[[UIImageView alloc]initWithImage:tabelImage];
    tabelImageView.frame=CGRectMake(18,41,tabelImage.size.width , tabelImage.size.height);
    tabelImageView.userInteractionEnabled=YES;
    [rightBarImageViewBG addSubview:tabelImageView];
    
    
    /***
     * EARTH Button
     **/
    
    UIButton *earthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [earthButton addTarget:self
                    action:@selector(earthButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    earthButton.backgroundColor =[UIColor clearColor];
    earthButton.frame = CGRectMake(3, 3, 63, 20);
    [tabelImageView addSubview:earthButton];
    
    /***
     * Earth Score Label
     **/
    
    UILabel* earthScoreLbl = [[UILabel alloc] init];
    earthScoreLbl.frame = CGRectMake(90,3,150,20);
    earthScoreLbl.textAlignment = NSTextAlignmentRight;
    earthScoreLbl.textColor = [UIColor  whiteColor];
    earthScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    earthScoreLbl.backgroundColor = [UIColor clearColor];
    earthScoreLbl.text=[NSString stringWithFormat:@"%@ ec",[[detailsArray valueForKey:@"points_inEc"] objectAtIndex:0]];
    [tabelImageView addSubview:earthScoreLbl];
    
    /***
     * Earth Players Count Label
     **/
    
    UILabel* earthplayersCountLbl = [[UILabel alloc] init];
    earthplayersCountLbl.frame = CGRectMake(250,3,70,20);
    earthplayersCountLbl.textAlignment = NSTextAlignmentRight;
    earthplayersCountLbl.textColor = [UIColor  whiteColor];
    earthplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    earthplayersCountLbl.backgroundColor = [UIColor clearColor];
    earthplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"earth_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:earthplayersCountLbl];
    
    /***
     * LUNA Button
     **/
    
    UIButton *lunaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lunaButton addTarget:self
                   action:@selector(lunaButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    lunaButton.backgroundColor =[UIColor clearColor];
    lunaButton.frame = CGRectMake(3, 29, 63, 20);
    [tabelImageView addSubview:lunaButton];
    
    /***
     * LUNA Score Label
     **/
    
    UILabel* lunaScoreLbl = [[UILabel alloc] init];
    lunaScoreLbl.frame = CGRectMake(90,29,150,20);
    lunaScoreLbl.textAlignment = NSTextAlignmentRight;
    lunaScoreLbl.textColor = [UIColor  whiteColor];
    lunaScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    lunaScoreLbl.backgroundColor = [UIColor clearColor];
    lunaScoreLbl.text=[NSString stringWithFormat:@"%@ lc",[[detailsArray valueForKey:@"points_inLc"] objectAtIndex:0]];
    [tabelImageView addSubview:lunaScoreLbl];
    
    /***
     * Luna Players Count Label
     **/
    
    UILabel* lunaplayersCountLbl = [[UILabel alloc] init];
    lunaplayersCountLbl.frame = CGRectMake(250,29,70,20);
    lunaplayersCountLbl.textAlignment = NSTextAlignmentRight;
    lunaplayersCountLbl.textColor = [UIColor  whiteColor];
    lunaplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    lunaplayersCountLbl.backgroundColor = [UIColor clearColor];
    lunaplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"luna_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:lunaplayersCountLbl];
    
    /***
     * MARS Button
     **/
    
    UIButton *marsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [marsButton addTarget:self
                   action:@selector(marsButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    marsButton.backgroundColor =[UIColor clearColor];
    marsButton.frame = CGRectMake(3, 52, 63, 20);
    [tabelImageView addSubview:marsButton];
    
    /***
     * Mars Score Label
     **/
    
    UILabel* marsScoreLbl = [[UILabel alloc] init];
    marsScoreLbl.frame = CGRectMake(90,52,150,20);
    marsScoreLbl.textAlignment = NSTextAlignmentRight;
    marsScoreLbl.textColor = [UIColor  whiteColor];
    marsScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    marsScoreLbl.backgroundColor = [UIColor clearColor];
    marsScoreLbl.text=[NSString stringWithFormat:@"%@ mc",[[detailsArray valueForKey:@"points_inMc"] objectAtIndex:0]];
    [tabelImageView addSubview:marsScoreLbl];
    
    /***
     * Mars Players Count Label
     **/
    
    UILabel* marsplayersCountLbl = [[UILabel alloc] init];
    marsplayersCountLbl.frame = CGRectMake(250,52,70,20);
    marsplayersCountLbl.textAlignment = NSTextAlignmentRight;
    marsplayersCountLbl.textColor = [UIColor  whiteColor];
    marsplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    marsplayersCountLbl.backgroundColor = [UIColor clearColor];
    marsplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"marc_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:marsplayersCountLbl];
    
    /***
     * CERES Button
     **/
    
    UIButton *ceresButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ceresButton addTarget:self
                    action:@selector(ceresButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    ceresButton.backgroundColor =[UIColor clearColor];
    ceresButton.frame = CGRectMake(3, 77, 63, 20);
    [tabelImageView addSubview:ceresButton];
    
    /***
     * CERES Score Label
     **/
    
    UILabel* ceresScoreLbl = [[UILabel alloc] init];
    ceresScoreLbl.frame = CGRectMake(90,77,150,20);
    ceresScoreLbl.textAlignment = NSTextAlignmentRight;
    ceresScoreLbl.textColor = [UIColor  whiteColor];
    ceresScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    ceresScoreLbl.backgroundColor = [UIColor clearColor];
    ceresScoreLbl.text=[NSString stringWithFormat:@"%@ cc",[[detailsArray valueForKey:@"points_inCc"] objectAtIndex:0]];
    [tabelImageView addSubview:ceresScoreLbl];
    
    /***
     * CERES Players Count Label
     **/
    
    UILabel* ceresplayersCountLbl = [[UILabel alloc] init];
    ceresplayersCountLbl.frame = CGRectMake(250,77,70,20);
    ceresplayersCountLbl.textAlignment = NSTextAlignmentRight;
    ceresplayersCountLbl.textColor = [UIColor  whiteColor];
    ceresplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    ceresplayersCountLbl.backgroundColor = [UIColor clearColor];
    ceresplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"ceres_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:ceresplayersCountLbl];
    
    /***
     * IOA Button
     **/
    
    UIButton *ioaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ioaButton addTarget:self
                  action:@selector(ioaButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    ioaButton.backgroundColor =[UIColor clearColor];
    ioaButton.frame = CGRectMake(3, 103, 63, 20);
    [tabelImageView addSubview:ioaButton];
    
    /***
     * IOA Score Label
     **/
    
    UILabel* ioaScoreLbl = [[UILabel alloc] init];
    ioaScoreLbl.frame = CGRectMake(90,103,150,20);
    ioaScoreLbl.textAlignment = NSTextAlignmentRight;
    ioaScoreLbl.textColor = [UIColor  whiteColor];
    ioaScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    ioaScoreLbl.backgroundColor = [UIColor clearColor];
    ioaScoreLbl.text=[NSString stringWithFormat:@"%@ ic",[[detailsArray valueForKey:@"points_inIc"] objectAtIndex:0]];
    [tabelImageView addSubview:ioaScoreLbl];
    
    /***
     * IOA Players Count Label
     **/
    
    UILabel* ioaplayersCountLbl = [[UILabel alloc] init];
    ioaplayersCountLbl.frame = CGRectMake(250,103,70,20);
    ioaplayersCountLbl.textAlignment = NSTextAlignmentRight;
    ioaplayersCountLbl.textColor = [UIColor  whiteColor];
    ioaplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    ioaplayersCountLbl.backgroundColor = [UIColor clearColor];
    ioaplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"ioa_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:ioaplayersCountLbl];
    
    /***
     * TITAN Button
     **/
    
    UIButton *titanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titanButton addTarget:self
                    action:@selector(titanButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    titanButton.backgroundColor =[UIColor clearColor];
    titanButton.frame = CGRectMake(3, 128, 63, 20);
    [tabelImageView addSubview:titanButton];
    
    /***
     * TITAN Score Label
     **/
    
    UILabel* titanScoreLbl = [[UILabel alloc] init];
    titanScoreLbl.frame = CGRectMake(90,128,150,20);
    titanScoreLbl.textAlignment = NSTextAlignmentRight;
    titanScoreLbl.textColor = [UIColor  whiteColor];
    titanScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    titanScoreLbl.backgroundColor = [UIColor clearColor];
    titanScoreLbl.text=[NSString stringWithFormat:@"%@ tc",[[detailsArray valueForKey:@"points_inTc"] objectAtIndex:0]];
    [tabelImageView addSubview:titanScoreLbl];
    
    /***
     * TITAN Players Count Label
     **/
    
    UILabel* titanplayersCountLbl = [[UILabel alloc] init];
    titanplayersCountLbl.frame = CGRectMake(250,128,70,20);
    titanplayersCountLbl.textAlignment = NSTextAlignmentRight;
    titanplayersCountLbl.textColor = [UIColor  whiteColor];
    titanplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    titanplayersCountLbl.backgroundColor = [UIColor clearColor];
    titanplayersCountLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"tc_player_count"] objectAtIndex:0]];
    [tabelImageView addSubview:titanplayersCountLbl];
    
    /***
     * CAPRI Button
     **/
    
    UIButton *capriButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [capriButton addTarget:self
                    action:@selector(capriButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    capriButton.backgroundColor =[UIColor clearColor];
    capriButton.frame = CGRectMake(3, 152, 63, 20);
    [tabelImageView addSubview:capriButton];
    
    /***
     * CAPRI Score Label
     **/
    
    UILabel* capriScoreLbl = [[UILabel alloc] init];
    capriScoreLbl.frame = CGRectMake(90,152,150,20);
    capriScoreLbl.textAlignment = NSTextAlignmentRight;
    capriScoreLbl.textColor = [UIColor  whiteColor];
    capriScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    capriScoreLbl.backgroundColor = [UIColor clearColor];
    capriScoreLbl.text=@"0 cac";
    [tabelImageView addSubview:capriScoreLbl];
    
    /***
     * CAPRI Players Count Label
     **/
    
    UILabel* capriplayersCountLbl = [[UILabel alloc] init];
    capriplayersCountLbl.frame = CGRectMake(250,152,70,20);
    capriplayersCountLbl.textAlignment = NSTextAlignmentRight;
    capriplayersCountLbl.textColor = [UIColor  whiteColor];
    capriplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    capriplayersCountLbl.backgroundColor = [UIColor clearColor];
    capriplayersCountLbl.text=@"0";
    [tabelImageView addSubview:capriplayersCountLbl];
    
    /***
     * BALDR Button
     **/
    
    UIButton *baldrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [baldrButton addTarget:self
                    action:@selector(baldrButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    baldrButton.backgroundColor =[UIColor clearColor];
    baldrButton.frame = CGRectMake(3, 178, 63, 20);
    [tabelImageView addSubview:baldrButton];
    
    /***
     * BALDR Score Label
     **/
    
    UILabel* baldrScoreLbl = [[UILabel alloc] init];
    baldrScoreLbl.frame = CGRectMake(90,178,150,20);
    baldrScoreLbl.textAlignment = NSTextAlignmentRight;
    baldrScoreLbl.textColor = [UIColor  whiteColor];
    baldrScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    baldrScoreLbl.backgroundColor = [UIColor clearColor];
    baldrScoreLbl.text=@"0 bac";
    [tabelImageView addSubview:baldrScoreLbl];
    
    /***
     * BALDR Players Count Label
     **/
    
    UILabel* baldrplayersCountLbl = [[UILabel alloc] init];
    baldrplayersCountLbl.frame = CGRectMake(250,178,70,20);
    baldrplayersCountLbl.textAlignment = NSTextAlignmentRight;
    baldrplayersCountLbl.textColor = [UIColor  whiteColor];
    baldrplayersCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    baldrplayersCountLbl.backgroundColor = [UIColor clearColor];
    baldrplayersCountLbl.text=@"0";
    [tabelImageView addSubview:baldrplayersCountLbl];
    
    
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
    statusLbl.frame = CGRectMake(30-20*isiPhone5(),5,280+10*isiPhone5() , 20);
    statusLbl.textAlignment = NSTextAlignmentRight;
    statusLbl.textColor = [UIColor  whiteColor];
    statusLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:13];
    statusLbl.backgroundColor = [UIColor clearColor];
    statusLbl.text=@"To Gain Worker Status requires 100,000 mc";
    [profileContentImageView addSubview:statusLbl];
    
    /***
     * CitizenshipLabel Label
     **/
    
    UILabel* citizenLbl = [[UILabel alloc] init];
    citizenLbl.frame = CGRectMake(40-10*isiPhone5(),20,250, 20);
    citizenLbl.textAlignment = NSTextAlignmentRight;
    citizenLbl.textColor = [UIColor  whiteColor];
    citizenLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:13];
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
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *orignalDate   =  [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"created_on"] objectAtIndex:0]]];
    
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *finalString = [dateFormatter stringFromDate:orignalDate];
    
    /***
     * Journy Date Label
     **/
    
    UILabel* dateLbl = [[UILabel alloc] init];
    dateLbl.frame = CGRectMake(85,0,70 , 24);
    dateLbl.textAlignment = NSTextAlignmentRight;
    dateLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    dateLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    dateLbl.backgroundColor = [UIColor clearColor];
    dateLbl.text=finalString;
    [statusBarLeftImageView addSubview:dateLbl];
    
    /***
     * Wins Label
     **/
    
    UILabel* winsLbl = [[UILabel alloc] init];
    winsLbl.frame = CGRectMake(85,25,70 , 24);
    winsLbl.textAlignment = NSTextAlignmentRight;
    winsLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    winsLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    winsLbl.backgroundColor = [UIColor clearColor];
    winsLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"31ScoreCount"] objectAtIndex:0]];
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
    locationLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    locationLbl.backgroundColor = [UIColor clearColor];
    locationLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"game_level"] objectAtIndex:0]];
    [statusBarRightImageView addSubview:locationLbl];
    
    /***
     * Bonus Label
     **/
    
    UILabel* bonusLbl = [[UILabel alloc] init];
    bonusLbl.frame = CGRectMake(85,28,70 , 24);
    bonusLbl.textAlignment = NSTextAlignmentRight;
    bonusLbl.textColor = [UIColor  colorWithRed:0.0/255.0f green:163.0/255.0f blue:255.0/255.0f alpha:1.0f];
    bonusLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    bonusLbl.backgroundColor = [UIColor clearColor];
    bonusLbl.adjustsFontSizeToFitWidth=YES;
    bonusLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"Bonus_credit"] objectAtIndex:0]];
    [statusBarRightImageView addSubview:bonusLbl];
    /***
     * Invite and Buy Background ImageView
     **/
    
    UIImage *inviteImage =[UIImage imageNamed:@"inviteandbuy"];
    UIImageView *inviteImageView=[[UIImageView alloc]initWithImage:inviteImage];
    inviteImageView.frame=CGRectMake(40,363,inviteImage.size.width , inviteImage.size.height);
    inviteImageView.userInteractionEnabled=YES;
    [rightBarImageViewBG addSubview:inviteImageView];
    
    
    /***
     * Buy Chips Button
     **/
    
    UIButton *chipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chipsButton addTarget:self
                    action:@selector(chipsButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    chipsButton.backgroundColor =[UIColor clearColor];
    [chipsButton setTitle:@"Buy Chips" forState:UIControlStateNormal];
    chipsButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:14];
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
    [inviteButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
    inviteButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:14];
    [inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inviteButton.frame = CGRectMake(145,11, 120, 34);
    [inviteImageView addSubview:inviteButton];
    
    
}
-(void)backButtonPressed

{
 [self.navigationController popViewControllerAnimated:NO];
}


-(void)buyChipsButtonPressed
{
    FreeChipsViewController *getFreeChips =[[FreeChipsViewController alloc]init];
    [self.navigationController pushViewController:getFreeChips animated:NO];
}

-(void)chipsButtonPressed
{
    InappPurchaseView *inapp =[[InappPurchaseView alloc]init];
    [self.navigationController pushViewController:inapp animated:NO];
    
}

-(void)inviteButtonPressed
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    
    NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"app_non_users", @"filters",
                                     nil];
    
    [FBWebDialogs
     presentRequestsDialogModallyWithSession:[FBSession activeSession]
     message:@"Join me!"
     title:@"Invite Friends"
     parameters:nil
     handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Case A: Error launching the dialog or sending request.
             NSLog(@"Error sending request.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // Case B: User clicked the "x" icon
                 NSLog(@"User canceled request.");
             } else {
                 NSLog(@"Request Sent.");
             }
         }
     }];
    
}
-(void)empthChairsButtonPressed
{
    EmptyChairs *chairs =[EmptyChairs sharedManager];
    [chairs ShowViewWithEmptyChairsImage:self.view];
}
-(void)earthButtonPressed
{
    if([eligibleLevels containsObject:@"EARTH"])
    {
    Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
    selectlevel.isFromPlayNow=NO;
    selectlevel.isFromDocument=YES;
    selectlevel.slectedLevel=@"EARTH";
    [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)lunaButtonPressed
{
    if([eligibleLevels containsObject:@"LUNA"])
    {
        Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
        selectlevel.isFromPlayNow=NO;
        selectlevel.isFromDocument=YES;
        selectlevel.slectedLevel=@"LUNA";
        [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)marsButtonPressed
{
    if([eligibleLevels containsObject:@"MARS"])
    {
        Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
        selectlevel.isFromPlayNow=NO;
        selectlevel.isFromDocument=YES;
        selectlevel.slectedLevel=@"MARS";
        [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)ceresButtonPressed
{
    if([eligibleLevels containsObject:@"CERES"])
    {
        Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
        selectlevel.isFromPlayNow=NO;
        selectlevel.isFromDocument=YES;
        selectlevel.slectedLevel=@"CERES";
        [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)ioaButtonPressed
{
    if([eligibleLevels containsObject:@"IOA"])
    {
        Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
        selectlevel.isFromPlayNow=NO;
        selectlevel.isFromDocument=YES;
        selectlevel.slectedLevel=@"IOA";
        [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)titanButtonPressed
{
    if([eligibleLevels containsObject:@"TITAN"])
    {
        Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
        selectlevel.isFromPlayNow=NO;
        selectlevel.isFromDocument=YES;
        selectlevel.slectedLevel=@"TITAN";
        [self.navigationController pushViewController:selectlevel animated:NO];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Your are not eligible to play this level" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}
-(void)capriButtonPressed
{
    Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
    [self.navigationController pushViewController:selectlevel animated:NO];
}
-(void)baldrButtonPressed
{
    Buy_InViewController *selectlevel =[[Buy_InViewController alloc]init];
    [self.navigationController pushViewController:selectlevel animated:NO];
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
