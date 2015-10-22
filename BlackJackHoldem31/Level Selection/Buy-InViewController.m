//
//  Buy-InViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Buy-InViewController.h"
#import "AppDelegate.h"
#import "OnlinePlayers.h"
#import "WebServiceInterface.h"
#import "GameAreaViewController.h"
#import "InappPurchaseView.h"
#import "UIImageView+WebCache.h"
#import "AppButtondetails.h"
#import "Rules.h"
#import "GameButtonDetails.h"

@interface Buy_InViewController ()

@end

@implementation Buy_InViewController
@synthesize progressView;
@synthesize levelLbl;
@synthesize isFromPlayNow;
@synthesize slectedLevel;
@synthesize isFromDocument;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (isiPhone5())
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-iphone5"]];
    else
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-iphone4"]];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    
    if(appDelegate().tableNumber == nil)
    {
        
    }
    else
    {
    PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
    [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
       
        if(subscriptionError != nil){
            NSLog(@"subscriptionError  %@",subscriptionError);
        }
        else
        {
            NSLog(@"subscriptionError  %@",subscriptionError);
        }
        
    }];
       [self ExitTableIfExists];
    }
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Getting Info"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=user_info&user_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataUserInfoResponse:)];
    objAPI = nil;
    
    /***
     * Background ImageView
     **/
    
    UIImage *image;
    if(isiPhone5())
    {
        image=[UIImage imageNamed:@"background-iphone5"];
    }
    else
    {
        image=[UIImage imageNamed:@"background-iphone4"];
    }
    
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    imageViewBG.userInteractionEnabled=YES;
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
    backButton.frame = CGRectMake(20,15, 60, 22);
    [self.view addSubview:backButton];
    
    /***
     * Rulses Button
     **/
    
    UIButton *rulesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rulesButton addTarget:self
                   action:@selector(rulesButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    rulesButton.backgroundColor =[UIColor clearColor];
    [rulesButton setBackgroundImage:[UIImage imageNamed:@"rules"] forState:UIControlStateNormal];
    rulesButton.frame = CGRectMake(392+88*isiPhone5(),17, 60, 22);
    [self.view addSubview:rulesButton];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *_response;
        NSError* _error = nil;
        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
        NSString *_params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=Yes",[[NSUserDefaults standardUserDefaults]valueForKey:@"Tabelnumber"],[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
        NSData *postData = [_params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *_req=[[NSMutableURLRequest alloc]initWithURL:_url];
        [_req setHTTPMethod:@"POST"];
        [_req setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [_req setHTTPBody:postData];
        NSData *_data=[NSURLConnection sendSynchronousRequest:_req returningResponse:&_response error:&_error];
        dispatch_async( dispatch_get_main_queue(), ^{
            @try {
                NSDictionary *_responsedict=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
                if([[_responsedict valueForKey:@"success"]integerValue ]==1)
                {
                }
                else
                {
                }
            }
            @catch (NSException *exception) {
                
            }
        });
    });
}
-(void)ExitTableIfExists
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *_response;
        NSError* _error = nil;
        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
        NSString *_params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=Yes",appDelegate().tableNumber,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
        NSData *postData = [_params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *_req=[[NSMutableURLRequest alloc]initWithURL:_url];
        [_req setHTTPMethod:@"POST"];
        [_req setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [_req setHTTPBody:postData];
        NSData *_data=[NSURLConnection sendSynchronousRequest:_req returningResponse:&_response error:&_error];
        dispatch_async( dispatch_get_main_queue(), ^{
            @try {
                NSDictionary *_responsedict=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
                if([[_responsedict valueForKey:@"success"]integerValue ]==1)
                {
                }
                else
                {
                    [self ExitTableIfExists];
                }
            }
            @catch (NSException *exception) {
                
            }
        });
    });
}
-(void)jsonDataUserInfoResponse:(id)responseDict
{
    //NSLog(@"responseDict....%@",responseDict);
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
    if([[responseDict valueForKey:@"levelscanPlaYed"] isKindOfClass:[NSMutableArray class]])
    {
    detailsArray =[[NSMutableArray alloc]init];
    eligibleLevels=[[NSMutableArray alloc]init];
    buyInDetails=[[NSMutableArray alloc]init];
    [detailsArray addObjectsFromArray:[responseDict valueForKey:@"data"]];
    [eligibleLevels addObjectsFromArray:[responseDict valueForKey:@"levelscanPlaYed"]];
    [buyInDetails addObject:[responseDict valueForKey:@"buy_insCount"]];
    [scrollView removeFromSuperview];
    [self LoadViewDetails];
    }
    else if ([[responseDict valueForKey:@"levelscanPlaYed"] isEqualToString:@"Not_Eligible"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Sorry You are not eligible to play." delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
    }
    
}
-(void)LoadViewDetails
{
    
    /***
     * Scroll
     **/
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35,480+88*isiPhone5(), 320)];
    [scrollView setContentSize:CGSizeMake(480+88*isiPhone5() , 320+120)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollView];
    
    /***
     * TopBar IMage ImageView
     **/
    
    UIImage *topBarImage =[UIImage imageNamed:@"top_bg"];
    UIImageView *topBarImageViewBG=[[UIImageView alloc]initWithImage:topBarImage];
    topBarImageViewBG.frame=CGRectMake(45+45*isiPhone5(),40,topBarImage.size.width , topBarImage.size.height);
    topBarImageViewBG.userInteractionEnabled=YES;
    [scrollView addSubview:topBarImageViewBG];
    
    /***
     * Avatr Background IMage ImageView
     **/
    
    UIImage *client2Image =[UIImage imageNamed:@"client2"];
    UIImageView *client2ImageViewBG=[[UIImageView alloc]init];  //WithImage:client2Image];
    [client2ImageViewBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImageUrl,[[detailsArray valueForKey:@"user_dummy_image"] objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"dummy_image.png"]];
    client2ImageViewBG.frame=CGRectMake(20, 10,client2Image.size.width-5 , client2Image.size.height);
    [topBarImageViewBG addSubview:client2ImageViewBG];
    
    /***
     * Avatr IMage ImageView
     **/
    UIImage *bottomprofileImage =[UIImage imageNamed:@"avtar"];
    UIImageView *bottomprofileImageViewBG=[[UIImageView alloc]initWithImage:bottomprofileImage];
    bottomprofileImageViewBG.frame=CGRectMake(20,1.5,bottomprofileImage.size.width , bottomprofileImage.size.height);
    [topBarImageViewBG addSubview:bottomprofileImageViewBG];
    
    
    /***
     * Level IMage ImageView
     **/
    UIImage *levelImage;
    if(isFromPlayNow==YES)
    {
    levelImage =[UIImage imageNamed:@"EARTH.png"];
    }
    else if(isFromDocument==YES)
    {
    levelImage =[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",slectedLevel]];
    }
    else
    {
     levelImage =[UIImage imageNamed:@"EARTH.png"];
    }
    levelImageViewBG=[[UIImageView alloc]initWithImage:levelImage];
    levelImageViewBG.frame=CGRectMake(187.5,1.5,204 , 98);
    [topBarImageViewBG addSubview:levelImageViewBG];
    
    /***
     * Name Label
     **/
    
    UILabel* nameLbl = [[UILabel alloc] init];
    nameLbl.frame = CGRectMake(95,30,90, 16);
    nameLbl.textAlignment = NSTextAlignmentLeft;
    nameLbl.textColor = [UIColor  whiteColor];
    nameLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    nameLbl.backgroundColor = [UIColor clearColor];
    nameLbl.text=[NSString stringWithFormat:@"%@",[[detailsArray valueForKey:@"nick_name"] objectAtIndex:0]];
    [topBarImageViewBG addSubview:nameLbl];
    
    /***
     * Score Label
     **/
    
    scoreLbl = [[UILabel alloc] init];
    scoreLbl.frame = CGRectMake(95,47,90, 16);
    scoreLbl.textAlignment = NSTextAlignmentLeft;
    scoreLbl.textColor = [UIColor  whiteColor];
    scoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    scoreLbl.backgroundColor = [UIColor clearColor];
    scoreLbl.text=[NSString stringWithFormat:@"%@ Ec",[[detailsArray valueForKey:@"points_inEc"] objectAtIndex:0]];
    [topBarImageViewBG addSubview:scoreLbl];
    
    /***
     * Drop Down Button
     **/
    
    
    UIButton *dropDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dropDownButton addTarget:self
                       action:@selector(dropDownButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    dropDownButton.backgroundColor =[UIColor clearColor];
    [dropDownButton setBackgroundImage:[UIImage imageNamed:@"next_destination.png"] forState:UIControlStateNormal];
    dropDownButton.frame = CGRectMake(95, 63, 81, 21);//259
    [topBarImageViewBG addSubview:dropDownButton];
    
    /***
     * Destination Label
     **/
    
    levelLbl = [[UILabel alloc] init];
    levelLbl.frame = CGRectMake(97,66,63, 15);
    levelLbl.textAlignment = NSTextAlignmentCenter;
    levelLbl.textColor = [UIColor  whiteColor];
    levelLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    levelLbl.backgroundColor = [UIColor clearColor];
    if(isFromPlayNow==YES)
    {
    levelLbl.text=[NSString stringWithFormat:@"%@",[eligibleLevels objectAtIndex:0]];
    }
    else if(isFromDocument==YES)
    {
    levelLbl.text=slectedLevel;
    }
    else
    {
    levelLbl.text=[NSString stringWithFormat:@"%@",[eligibleLevels objectAtIndex:0]];
    }
    
    levelLbl.autoresizingMask=YES;
    levelLbl.adjustsFontSizeToFitWidth=YES;
    [topBarImageViewBG addSubview:levelLbl];
    
    /***
     * Middle IMage ImageView
     **/
    
    UIImage *middleBarImage =[UIImage imageNamed:@"MiddleBar.png"];
    UIImageView *middleBarImageViewBG=[[UIImageView alloc]initWithImage:middleBarImage];
    middleBarImageViewBG.frame=CGRectMake(45+45*isiPhone5(),160,middleBarImage.size.width , middleBarImage.size.height);
    middleBarImageViewBG.userInteractionEnabled=YES;
    [scrollView addSubview:middleBarImageViewBG];
    
    /***
     * Buy Chips Button
     **/
    
    
    UIButton *buyChipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyChipsButton addTarget:self
                       action:@selector(buyChipsButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    buyChipsButton.backgroundColor =[UIColor clearColor];
    [buyChipsButton setBackgroundImage:[UIImage imageNamed:@"buy_cardit.png"] forState:UIControlStateNormal];
    
    buyChipsButton.frame = CGRectMake(10, 180, 102, 45);//259
    [middleBarImageViewBG addSubview:buyChipsButton];
    
    /***
     * HeadingBar IMage ImageView
     **/
    UIImage *headingBarImage =[UIImage imageNamed:@"heading.png"];
    UIImageView *headingBarImageeViewBG=[[UIImageView alloc]initWithImage:headingBarImage];
    headingBarImageeViewBG.frame=CGRectMake(13, 15,headingBarImage.size.width , headingBarImage.size.height);
    [middleBarImageViewBG addSubview:headingBarImageeViewBG];
    
    /***
     * Table IMage ImageView
     **/
    UIImage *tableImage =[UIImage imageNamed:@"countingbg.png"];
    UIImageView *tableImageViewBG=[[UIImageView alloc]initWithImage:tableImage];
    tableImageViewBG.frame=CGRectMake(13, 32,tableImage.size.width , tableImage.size.height);
    tableImageViewBG.userInteractionEnabled=YES;
    [middleBarImageViewBG addSubview:tableImageViewBG];
    
    
    for(int i=0;i<5;i++)
    {
        /***
         * First Column Label
         **/
        
        firstpriceLbl = [[UILabel alloc] init];
        firstpriceLbl.frame = CGRectMake(0,0+27*i-2*i,150 , 27);
        firstpriceLbl.textAlignment = NSTextAlignmentCenter;
        firstpriceLbl.textColor = [UIColor  whiteColor];
        firstpriceLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
        firstpriceLbl.backgroundColor = [UIColor clearColor];
        if(i==0)
            firstpriceLbl.text=@"10,000";
        else if(i==1)
            firstpriceLbl.text=@"100,000";
        else if(i==2)
            firstpriceLbl.text=@"1,000,000";
        else if(i==3)
            firstpriceLbl.text=@"10,000,000";
        else if(i==4)
            firstpriceLbl.text=@"100,000,000";
        else if(i==5)
            firstpriceLbl.text=@"1,000,000,000";
        
        
        firstpriceLbl.adjustsFontSizeToFitWidth = YES;
        [tableImageViewBG addSubview:firstpriceLbl];
        
        /***
         * First Blind Label
         **/
        
        firstblindLbl = [[UILabel alloc] init];
        firstblindLbl.frame = CGRectMake(151,0+27*i-2*i,115 , 27);
        firstblindLbl.textAlignment = NSTextAlignmentCenter;
        firstblindLbl.textColor = [UIColor  whiteColor];
        firstblindLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
        firstblindLbl.backgroundColor = [UIColor clearColor];
        if(i==0)
            firstblindLbl.text=@"100/200";
        else  if(i==1)
            firstblindLbl.text=@"1k/2k";
        else  if(i==2)
            firstblindLbl.text=@"10k/20k";
        else  if(i==3)
            firstblindLbl.text=@"100k/200k";
        else  if(i==4)
            firstblindLbl.text=@"1M/2M";
        else  if(i==5)
            firstblindLbl.text=@"10M/20M";
        
        
        firstblindLbl.adjustsFontSizeToFitWidth = YES;
        [tableImageViewBG addSubview:firstblindLbl];
        
        /***
         * First Blind Label
         **/
        
        firstPlayerCountLbl = [[UILabel alloc] init];
        firstPlayerCountLbl.frame = CGRectMake(267,0+27*i-2*i,70 , 27);
        firstPlayerCountLbl.textAlignment = NSTextAlignmentCenter;
        firstPlayerCountLbl.textColor = [UIColor  whiteColor];
        firstPlayerCountLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
        firstPlayerCountLbl.backgroundColor = [UIColor clearColor];
        if(i==0)
        firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"one" ] objectAtIndex:0]];
        else if (i==1)
        firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"two" ] objectAtIndex:0]];
        else if (i==2)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"three" ] objectAtIndex:0]];
        else if (i==3)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"four" ] objectAtIndex:0]];
        else if (i==4)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"five" ] objectAtIndex:0]];
        else if (i==5)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"six" ] objectAtIndex:0]];
        
        firstPlayerCountLbl.adjustsFontSizeToFitWidth = YES;
        [tableImageViewBG addSubview:firstPlayerCountLbl];
        
        /***
         * GO Button
         **/
        
        
        goButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [goButton addTarget:self
                     action:@selector(goButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
        goButton.backgroundColor =[UIColor clearColor];
        [goButton setBackgroundImage:[UIImage imageNamed:@"go.png"] forState:UIControlStateNormal];
        goButton.tag=i;
        goButton.frame = CGRectMake(337, 2+25*i, 30, 24);//259
        [tableImageViewBG addSubview:goButton];
        
    }
    
    /***
     * Bottom Bar IMage ImageView
     **/
    UIImage *bottomBarImage =[UIImage imageNamed:@"BottomBar.png"];
    UIImageView *bottomBarImageViewBG=[[UIImageView alloc]initWithImage:bottomBarImage];
    bottomBarImageViewBG.frame=CGRectMake(177+45*isiPhone5(), 335,bottomBarImage.size.width , bottomBarImage.size.height);
    bottomBarImageViewBG.userInteractionEnabled=YES;
    [scrollView addSubview:bottomBarImageViewBG];
    
    /***
     * App Button
     **/
    
    
    UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [appButton addTarget:self
                  action:@selector(appButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    appButton.backgroundColor =[UIColor clearColor];
    [appButton setTitle:@"APP" forState:UIControlStateNormal];
    appButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:14];
    [appButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    appButton.frame = CGRectMake(0, 0, 88, 27);//259
    [bottomBarImageViewBG addSubview:appButton];
    
    /***
     * Game Button
     **/
    
    
    UIButton *gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [gameButton addTarget:self
                   action:@selector(gameButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    gameButton.backgroundColor =[UIColor clearColor];
    [gameButton setTitle:@"GAME" forState:UIControlStateNormal];
    gameButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:14];
    [gameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gameButton.frame = CGRectMake(88, 0, 88, 27);//259
    [bottomBarImageViewBG addSubview:gameButton];
    
    /***
     * Tips Button
     **/
    
    
    UIButton *tipsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipsButton addTarget:self
                   action:@selector(tipsButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    tipsButton.backgroundColor =[UIColor clearColor];
    [tipsButton setTitle:@"TIPS" forState:UIControlStateNormal];
    tipsButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:14];
    [tipsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipsButton.frame = CGRectMake(176, 0, 88, 27);//259
    [bottomBarImageViewBG addSubview:tipsButton];
    
    
    /***
     * LastLocation Bar IMage ImageView
     **/
    UIImage *lastLocationImage =[UIImage imageNamed:@"LastLocation.png"];
    UIImageView *lastLocationImageViewBG=[[UIImageView alloc]initWithImage:lastLocationImage];
    lastLocationImageViewBG.frame=CGRectMake(177+45*isiPhone5(), 370,lastLocationImage.size.width , lastLocationImage.size.height);
    //[scrollView addSubview:lastLocationImageViewBG];
    
    /***
     * lastLocation Button
     **/
    
    UIButton *lastLocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastLocationButton addTarget:self
                           action:@selector(lastLocationButtonPressed)
                 forControlEvents:UIControlEventTouchUpInside];
    lastLocationButton.backgroundColor =[UIColor clearColor];
    [lastLocationButton setBackgroundImage:[UIImage imageNamed:@"LastLocation.png"] forState:UIControlStateNormal];
    lastLocationButton.frame = CGRectMake(177+45*isiPhone5(), 370,lastLocationImage.size.width , lastLocationImage.size.height);
    [scrollView addSubview:lastLocationButton];
    

    if([levelLbl.text isEqualToString: @"EARTH"])
        levelImageViewBG.image=[UIImage imageNamed:@"EARTH.png"];
    else if ([levelLbl.text isEqualToString:@"MARS"])
        levelImageViewBG.image=[UIImage imageNamed:@"MARS.png"];
    else if ([levelLbl.text isEqualToString:@"LUNA"])
        levelImageViewBG.image=[UIImage imageNamed:@"SARTURN.png"];
    else if ([levelLbl.text isEqualToString:@"CERES"])
        levelImageViewBG.image=[UIImage imageNamed:@"CERES.png"];
    else if ([levelLbl.text isEqualToString:@"IOA"])
        levelImageViewBG.image=[UIImage imageNamed:@"IOA.png"];
    else if ([levelLbl.text isEqualToString:@"TITAN"])
        levelImageViewBG.image=[UIImage imageNamed:@"TITAN.png"];
    
    _comboBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(140+45*isiPhone5(), 120, 81,138)];//115, 200, 145, 30
    _comboBoxTableView.dataSource = self;
    _comboBoxTableView.delegate = self;
    _comboBoxTableView.backgroundColor = [UIColor blackColor];
    _comboBoxTableView.separatorColor = [UIColor whiteColor];
    _comboBoxTableView.hidden=YES;
    _comboBoxTableView.tag = 0;
    _comboBoxTableView.layer.borderWidth = 1;
    _comboBoxTableView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _comboBoxTableView.scrollEnabled = YES;
    if(isios7())
    {
        [_comboBoxTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [scrollView addSubview:_comboBoxTableView];
    
   // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self.viewaction:@selector(dismissTableView)];
}

-(void)dismissTableView
{
    _comboBoxTableView.hidden=YES;
}

#pragma mark ------------------------------TableViewDelegate and UITableViewDatasource methods--------------------------------------

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eligibleLevels.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 23;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ListCellIdentifier";
    UITableViewCell *cell = [_comboBoxTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        /***
         *Customize Table Cell Label
         */
        cell.textLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10.0];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.selectionStyle =UITableViewCellSelectionStyleGray;
        
    }
    else{
        
        NSArray *cellSubs = cell.contentView.subviews;
        for (int i = 0 ; i < [cellSubs count] ; i++)
        {
            [[cellSubs objectAtIndex:i] removeFromSuperview];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:10.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.textLabel.text =[NSString stringWithFormat:@"%@",[eligibleLevels objectAtIndex:indexPath.row]];
    cell.contentView.backgroundColor = [UIColor blackColor];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    levelLbl.text=[NSString stringWithFormat:@"%@",[eligibleLevels objectAtIndex:indexPath.row]];
    if([levelLbl.text isEqualToString: @"EARTH"])
        levelImageViewBG.image=[UIImage imageNamed:@"EARTH.png"];
    else if ([levelLbl.text isEqualToString:@"MARS"])
        levelImageViewBG.image=[UIImage imageNamed:@"MARS.png"];
    else if ([levelLbl.text isEqualToString:@"LUNA"])
        levelImageViewBG.image=[UIImage imageNamed:@"SARTURN.png"];
    else if ([levelLbl.text isEqualToString:@"CERES"])
        levelImageViewBG.image=[UIImage imageNamed:@"CERES.png"];
    else if ([levelLbl.text isEqualToString:@"IOA"])
        levelImageViewBG.image=[UIImage imageNamed:@"IOA.png"];
    else if ([levelLbl.text isEqualToString:@"TITAN"])
        levelImageViewBG.image=[UIImage imageNamed:@"TITAN.png"];
        
     _comboBoxTableView.hidden=YES;
    isFromPlayNow=NO;
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Getting Info"];
    objAPI.showActivityIndicator = YES;
    NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    
    NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=user_info&user_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
    [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataResponse:)];
    objAPI = nil;
    
}
-(void)jsonDataResponse:(id)Response
{
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    buyInDetails=[[NSMutableArray alloc]init];
    [buyInDetails addObject:[Response valueForKey:@"buy_insCount"]];
    for(int i=0;i<6;i++)
    {
        if(firstPlayerCountLbl.tag==0)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"one" ] objectAtIndex:0]];
        else if (firstPlayerCountLbl.tag==1)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"two" ] objectAtIndex:0]];
        else if (firstPlayerCountLbl.tag==2)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"three" ] objectAtIndex:0]];
        else if (firstPlayerCountLbl.tag==3)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"four" ] objectAtIndex:0]];
        else if (firstPlayerCountLbl.tag==4)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"five" ] objectAtIndex:0]];
        else if (firstPlayerCountLbl.tag==5)
            firstPlayerCountLbl.text=[NSString stringWithFormat:@"%@",[[[buyInDetails valueForKey:levelLbl.text]valueForKey:@"six" ] objectAtIndex:0]];
    }
    if([levelLbl.text isEqualToString:@"EARTH"])
    scoreLbl.text=[NSString stringWithFormat:@"%@ Ec",[[detailsArray valueForKey:@"points_inEc"] objectAtIndex:0]];
    else if ([levelLbl.text isEqualToString:@"LUNA"])
        scoreLbl.text=[NSString stringWithFormat:@"%@ Lc",[[detailsArray valueForKey:@"points_inLc"] objectAtIndex:0]];
    else if ([levelLbl.text isEqualToString:@"MARS"])
        scoreLbl.text=[NSString stringWithFormat:@"%@ Mc",[[detailsArray valueForKey:@"points_inMc"] objectAtIndex:0]];
    else if ([levelLbl.text isEqualToString:@"CERES"])
        scoreLbl.text=[NSString stringWithFormat:@"%@ Cc",[[detailsArray valueForKey:@"points_inCc"] objectAtIndex:0]];
    else if ([levelLbl.text isEqualToString:@"IOA"])
        scoreLbl.text=[NSString stringWithFormat:@"%@ Ic",[[detailsArray valueForKey:@"points_inIc"] objectAtIndex:0]];
    else if ([levelLbl.text isEqualToString:@"TITAN"])
        scoreLbl.text=[NSString stringWithFormat:@"%@ Tc",[[detailsArray valueForKey:@"points_inTc"] objectAtIndex:0]];
}
-(void)appButtonPressed
{
    AppButtondetails *appDetails =[AppButtondetails sharedManager];
    [appDetails ShowViewWithRules:self.view];
}

-(void)gameButtonPressed{
    GameButtonDetails *gameDetails =[GameButtonDetails sharedManager];
    [gameDetails ShowViewWithGameDetails:self.view];
}

-(void)tipsButtonPressed{
}
-(void)buyChipsButtonPressed{
    InappPurchaseView *inapp =[[InappPurchaseView alloc]init];
    [self.navigationController pushViewController:inapp animated:NO];
}
-(void)rulesButtonPressed{
    Rules *rulesView =[Rules sharedManager];
    [rulesView ShowViewWithRules:self.view];
}
-(void)goButtonPressed:(UIButton*)button
{
    if(appDelegate().tableNumber == nil)
    {
    }
    else
    {
    PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
    [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
//        NSString *alertMessage = [NSString stringWithFormat:@"Unsubscribed channel: %@",
//                                  channel_self.name];
        if(subscriptionError != nil){
//            alertMessage = [NSString stringWithFormat:@"Unsubscribe error : %@, %@",
//                            channel_self.name, subscriptionError.description];
        }
        else
        {
        }
        
    }];
    }
    int score=[scoreLbl.text intValue];
    _comboBoxTableView.hidden=YES;
    if(button.tag==0)
    {
        if(score>=10000)
        {
            
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"one",@"10000"];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
            appDelegate().LevelName=levelLbl.text;
            appDelegate().smallBlindValue=@"100";
            appDelegate().bigBlindValue=@"200";
            appDelegate().buyInValue=@"10000";
            appDelegate().firstBetValue=@"500";
            appDelegate().secondBetValue=@"1000";
            appDelegate().thirdBetValue=@"2000";
            appDelegate().fourthBetValue=@"5000";
            [[NSUserDefaults standardUserDefaults] setValue:@"one" forKey:@"Buyins"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (button.tag==1)
        {
            if(score>=100000)
            {
                WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
                self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
                objAPI.showActivityIndicator = YES;
                NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
                
                NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"two",@"100000"];
                [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
                objAPI = nil;
                appDelegate().LevelName=levelLbl.text;
                appDelegate().smallBlindValue=@"1k";
                appDelegate().bigBlindValue=@"2k";
                appDelegate().buyInValue=@"100000";
                appDelegate().firstBetValue=@"5000";
                appDelegate().secondBetValue=@"10000";
                appDelegate().thirdBetValue=@"20000";
                appDelegate().fourthBetValue=@"50000";
                [[NSUserDefaults standardUserDefaults] setValue:@"two" forKey:@"Buyins"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
    }
    else if (button.tag==2)
    {
        if(score>=1000000)
        {
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"three",@"1000000"];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
            appDelegate().LevelName=levelLbl.text;
            appDelegate().smallBlindValue=@"10k";
            appDelegate().bigBlindValue=@"20k";
            appDelegate().buyInValue=@"100000";
            appDelegate().firstBetValue=@"50k";
            appDelegate().secondBetValue=@"100k";
            appDelegate().thirdBetValue=@"200k";
            appDelegate().fourthBetValue=@"500k";
            [[NSUserDefaults standardUserDefaults] setValue:@"three" forKey:@"Buyins"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (button.tag==3)
    {
        if(score>=10000000)
        {
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"four",@"10000000"];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
            appDelegate().LevelName=levelLbl.text;
            appDelegate().smallBlindValue=@"100k";
            appDelegate().bigBlindValue=@"200k";
            appDelegate().buyInValue=@"1000000";
            appDelegate().firstBetValue=@"500k";
            appDelegate().secondBetValue=@"1000k";
            appDelegate().thirdBetValue=@"2000k";
            appDelegate().fourthBetValue=@"5000k";
            [[NSUserDefaults standardUserDefaults] setValue:@"four" forKey:@"Buyins"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (button.tag==4)
    {
        if(score>=100000000)
        {
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"five",@"100000000"];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
            appDelegate().LevelName=levelLbl.text;
            appDelegate().smallBlindValue=@"1000k";
            appDelegate().bigBlindValue=@"2000k";
            appDelegate().buyInValue=@"10000000";
            appDelegate().firstBetValue=@"5000k";
            appDelegate().secondBetValue=@"10000k";
            appDelegate().thirdBetValue=@"20000k";
            appDelegate().fourthBetValue=@"50000k";
            [[NSUserDefaults standardUserDefaults] setValue:@"five" forKey:@"Buyins"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if (button.tag==5)
    {
        if(score>=1000000000)
        {
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Checking for tables..."];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],levelLbl.text,@"six",@"1000000000"];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
            appDelegate().LevelName=levelLbl.text;
            [[NSUserDefaults standardUserDefaults] setValue:@"six" forKey:@"Buyins"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are not eligible to play on this table because of low credits." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
   
}
-(void)jsonPlayNowResponse:(id)responseDict
{
    //NSLog(@"jsonPlayNowResponse %@",responseDict);
    if([[responseDict valueForKey:@"success"]integerValue ]==1)
    {
        appDelegate().tableNumber =[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"table_number"]];
        [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"table_number"]] forKey:@"Tablenumber" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
        appDelegate().dealerId=[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"dealer"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=table_information&table_number=%@&dealer=%@",appDelegate().tableNumber,appDelegate().dealerId];
            NSLog(@"postData---> = %@",postData);
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonUpdatedTableDataResponse:)];
            objAPI = nil;
        });
        
        
    }
    else if ([[responseDict valueForKey:@"success"] integerValue]==0)
    {
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        [objAPI hideProgressView:self.progressView];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
    else
    {
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        [objAPI hideProgressView:self.progressView];
    }
}
-(void)jsonUpdatedTableDataResponse:(id)responseDict{
    NSLog(@"jsonUpdatedTableDataResponse %@",responseDict);
    [[NSUserDefaults standardUserDefaults] setValue:levelLbl.text forKey:@"Theme"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [appDelegate().clients removeAllObjects];
    [appDelegate().cummulativeCards removeAllObjects];
    
    
    for(int i=0;i<7;i++)
    {
        if(![[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]isEqual:@""])
        {
            [appDelegate().clients addObject:[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]];
        }
        
    }
    for(int  i=0;i<appDelegate().clients.count;i++)
    {
        if([[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]])
        {
            [[NSUserDefaults standardUserDefaults]setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults]setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"UserImage"];
            [[NSUserDefaults standardUserDefaults]setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    }
    if(appDelegate().clients.count>1)
    {
        NSMutableArray *playersArray =[[NSMutableArray alloc]init];
        /*
         int dealer = 0 ;
         int smallBlind = 0;
         int bigBlind = 0;
         for(int i=0;i<appDelegate().clients.count;i++)
         {
         if([[[responseDict valueForKey:@"data"] valueForKey:@"dealer"] isEqualToString:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i]])//[[responseDict valueForKey:@"data"] valueForKey:@"dealer"]
         {
         //appDelegate().indexvalue=i;
         dealer=i;
         bigBlind=dealer+1;
         NSLog(@"dealer %d",dealer);
         NSLog(@"smallBlind %d",smallBlind);
         NSLog(@"bigBlind %d",bigBlind);
         if(bigBlind==appDelegate().clients.count)
         {
         bigBlind=0;
         }
         else if(bigBlind==appDelegate().clients.count+1)
         {
         bigBlind=1;
         }
         else if (bigBlind<0)
         {
         bigBlind=appDelegate().clients.count-1;
         }
         smallBlind=dealer+2;
         NSLog(@"dealer %d",dealer);
         NSLog(@"smallBlind %d",smallBlind);
         NSLog(@"bigBlind %d",bigBlind);
         if(smallBlind==appDelegate().clients.count)
         {
         smallBlind=0;
         }
         else if(smallBlind==appDelegate().clients.count+1)
         {
         smallBlind=1;
         }
         else if(smallBlind==appDelegate().clients.count+2)
         {
         smallBlind=2;
         }
         else if (smallBlind<0)
         {
         smallBlind=appDelegate().clients.count-1;
         }
         NSLog(@"dealer %d",dealer);
         NSLog(@"smallBlind %d",smallBlind);
         NSLog(@"bigBlind %d",bigBlind);
         }
         
         }
         NSLog(@"dealer %d",dealer);
         NSLog(@"smallBlind %d",smallBlind);
         NSLog(@"bigBlind %d",bigBlind);
         */
        for(int i=0;i<appDelegate().clients.count;i++)
        {
            NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]init];
            if(appDelegate().clients.count>2)
            {
            if(i==appDelegate().clients.count-1)
            {
                [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                [tempDict setValue:@"No" forKey:@"SmallBlind"];
                [tempDict setValue:@"No" forKey:@"BigBlind"];
                [tempDict setValue:@"Yes" forKey:@"Dealer"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                [playersArray addObject:tempDict];
            }
            else if (i==appDelegate().clients.count-2)//appDelegate().clients.count-1
            {
                [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                [tempDict setValue:@"Yes" forKey:@"SmallBlind"];
                [tempDict setValue:@"No" forKey:@"BigBlind"];
                [tempDict setValue:@"No" forKey:@"Dealer"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                [playersArray addObject:tempDict];
                appDelegate().StaringPlayer=[[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] intValue];
                
            }
            else if (i==appDelegate().clients.count-3)//appDelegate().clients.count-2
            {
                [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                [tempDict setValue:@"No" forKey:@"SmallBlind"];
                [tempDict setValue:@"Yes" forKey:@"BigBlind"];
                [tempDict setValue:@"No" forKey:@"Dealer"];
                [playersArray addObject:tempDict];
                
            }
            else
            {
                [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                [tempDict setValue:@"No" forKey:@"SmallBlind"];
                [tempDict setValue:@"No" forKey:@"BigBlind"];
                [tempDict setValue:@"No" forKey:@"Dealer"];
                [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                [playersArray addObject:tempDict];
            }
            }
            else
            {
                if(i==appDelegate().clients.count-1)
                {
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                    [tempDict setValue:@"No" forKey:@"SmallBlind"];
                    [tempDict setValue:@"Yes" forKey:@"BigBlind"];
                    [tempDict setValue:@"Yes" forKey:@"Dealer"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                    [playersArray addObject:tempDict];
                }
                else if (i==appDelegate().clients.count-2)//appDelegate().clients.count-1
                {
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] forKey:@"nick_name"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] forKey:@"user_id"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:i] forKey:@"user_image"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"username"] objectAtIndex:i] forKey:@"username"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:i] forKey:@"temp_score"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"index"] objectAtIndex:i] forKey:@"index"];
                    [tempDict setValue:@"Yes" forKey:@"SmallBlind"];
                    [tempDict setValue:@"No" forKey:@"BigBlind"];
                    [tempDict setValue:@"No" forKey:@"Dealer"];
                    [tempDict setValue:[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:i] forKey:@"Status"];
                    [playersArray addObject:tempDict];
                    appDelegate().StaringPlayer=[[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] intValue];
                    
                }
            }
        }
        [appDelegate().clients removeAllObjects];
        [appDelegate().clients addObjectsFromArray:playersArray];
        
        [playersArray removeAllObjects];
        
        
        for(int i=0;i<appDelegate().clients.count;i++)
        {
            if([[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]])
            {
                //[playersArray addObject:[appDelegate().clients objectAtIndex:i]];
                for(int j=0;j<appDelegate().clients.count;j++)
                {
                    [playersArray addObject:[appDelegate().clients objectAtIndex:i]];
                    i++;
                    if(i>=appDelegate().clients.count)
                    {
                        i=0;
                    }
                }
            }
        }
        [appDelegate().clients removeAllObjects];
        [appDelegate().clients addObjectsFromArray:playersArray];
    }
    appDelegate().gameStarted=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"game_status"]];
    PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber shouldObservePresence:YES];
    [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
        if(subscriptionError != nil){
        }else{
        }
    }];

    NSString *uuid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]];
    [PubNub setClientIdentifier:uuid];
    
    [PubNub enablePresenceObservationForChannel:channel_self];
    [PubNub subscribeOnChannel: channel_self];


    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];

    GameAreaViewController *gameArea =[[GameAreaViewController alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:gameArea animated:YES];
    });
   
}

-(void)lastLocationButtonPressed
{
    OnlinePlayers *online =[OnlinePlayers sharedManager];
    [online ShowViewWithPlayersWhoAreOnline:self.view];
}
-(void)backButtonPressed

{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)dropDownButtonPressed
{
    if(_comboBoxTableView.hidden==NO)
    {
        _comboBoxTableView.hidden=YES;
        
    }
    else
    {
        _comboBoxTableView.hidden=NO;
        [_comboBoxTableView reloadData];
        
    }
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
