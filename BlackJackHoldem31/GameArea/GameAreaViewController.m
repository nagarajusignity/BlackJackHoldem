//
//  GameAreaViewController.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "GameAreaViewController.h"
#import "CircularProgressView.h"
#import "CardView.h"
#import "Card.h"
#import "Player.h"
#import "Stack.h"
#import "Deck.h"
#import "AppDelegate.h"

@interface GameAreaViewController ()

@end
@implementation GameAreaViewController
{
    CircularProgressView *circularView0;
    CircularProgressView *circularView1;
    CircularProgressView *circularView2;
    CircularProgressView *circularView3;
    CircularProgressView *circularView4;
    CircularProgressView *circularView5;
    CircularProgressView *circularView6;
    int                  round;
    int                  flopCradCount;
    NSMutableDictionary *_players;
    PlayerPosition       _startingPlayerPosition;
    PlayerPosition       _activePlayerPosition;
    UILabel              *centerLbl;
    
    NSMutableDictionary    *firstDict;
    NSMutableDictionary    *secondDict;
    
    NSMutableArray         *first;
    NSMutableArray         *second;
    
    NSMutableArray        *final1;
    NSMutableArray        *final2;
    
    
    UIView * FirstPlayerscoreView ;
    
    UIView * secondPlayerscoreView ;
    
    UIView * thirdPlayerscoreView ;
    
    UIView * fouthPlayerscoreView  ;
    
    UIView * fifthPlayerscoreView  ;
    
    UIView * sixthPlayerscoreView  ;
    
    UIView * seventhPlayerscoreView ;
    
    UIView * totalBetamount;
    
    AVAudioPlayer *_dealingCardsSound;
    
}
@synthesize fouthbedirBG;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    first =[[NSMutableArray alloc]init];
    second =[[NSMutableArray alloc]init];
    scoreDict =[[NSMutableDictionary alloc]init];
    scoreArray =[[NSMutableArray alloc]init];
    myOpencards =[[NSMutableArray alloc]init];
    rulesView =[[Rules alloc]init];
    // [self loadSounds];
    
    
    ActiveAtPositionLTop  = YES;
    ActiveAtPositionLMiddle =YES;
    ActiveAtPositionLBottom =YES;
    ActiveAtPositionMiddle =YES ;
    ActiveAtPositionRBottom =YES ;  // the user
    ActiveAtPositionRMiddle =YES ;
    ActiveAtPositionRTop =YES ;
    
    /***
     * Background ImageView
     **/
    UIImage *image;
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"Moon"])
    {  if(isiPhone5())
    {
        image =[UIImage imageNamed:@"backwall"];
    }
        else
        {
        image =[UIImage imageNamed:@"Moon_iphone4"];
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"Mars"])
    {
        if(isiPhone5())
        {

        image =[UIImage imageNamed:@"Mars_bg"];
        }
        else
        {
         image =[UIImage imageNamed:@"Mars_bg4"];
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"Saturn"])
    {
        if(isiPhone5())
        {
        image =[UIImage imageNamed:@"Saturn_bg"];
        }
        else
        {
         image =[UIImage imageNamed:@"Saturn_bg4"];
        }
    }

    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    [self.view addSubview:imageViewBG];
    
    /***
     * bedir ImageView
     **/
    
    UIImage *bedirimage =[UIImage imageNamed:@"bedir"];
    firstbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    firstbedirBG.frame=CGRectMake(310.0+65*isiPhone5(), 15.0,bedirimage.size.width , bedirimage.size.height);//375
    [self.view addSubview:firstbedirBG];
    
    UIImage *firstProfileImage =[UIImage imageNamed:@"playes1"];
    UIImageView  *firstProfileImageBG=[[UIImageView alloc]initWithImage:firstProfileImage];//CreateSheet_BG
    firstProfileImageBG.frame=CGRectMake(4, 4,firstProfileImage.size.width-7 , firstProfileImage.size.height-6);
    firstProfileImageBG.layer.masksToBounds = YES;
    firstProfileImageBG.layer.cornerRadius=27;
    [firstbedirBG addSubview:firstProfileImageBG];
    
    
    /***
     * FIrst Name Label
     **/
    
    UILabel* firstPlayerName = [[UILabel alloc] init];
    firstPlayerName.frame = CGRectMake(10, 60,40 , 15);
    firstPlayerName.textAlignment = NSTextAlignmentCenter;
    firstPlayerName.textColor = [UIColor  whiteColor];
    firstPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstPlayerName.backgroundColor = [UIColor clearColor];
    firstPlayerName.adjustsFontSizeToFitWidth = YES;
    firstPlayerName.text=@"Alain";
    [firstbedirBG addSubview:firstPlayerName];
    /***
     * FIrst Player Score Label
     **/
    
    UILabel* firstPlayerScore = [[UILabel alloc] init];
    firstPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    firstPlayerScore.textAlignment = NSTextAlignmentCenter;
    firstPlayerScore.textColor = [UIColor  whiteColor];
    firstPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstPlayerScore.backgroundColor = [UIColor clearColor];
    firstPlayerScore.adjustsFontSizeToFitWidth = YES;
    firstPlayerScore.text=@"4345";
    [firstbedirBG addSubview:firstPlayerScore];
    
    
    secondbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    secondbedirBG.frame=CGRectMake(410+90*isiPhone5(), 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:secondbedirBG];
    
    UIImage *secondProfileImage =[UIImage imageNamed:@"playes2"];
    UIImageView  *secondProfileImageBG=[[UIImageView alloc]initWithImage:secondProfileImage];//CreateSheet_BG
    secondProfileImageBG.frame=CGRectMake(4, 4,secondProfileImage.size.width-7 , secondProfileImage.size.height-6);
    secondProfileImageBG.layer.masksToBounds = YES;
    secondProfileImageBG.layer.cornerRadius=27;
    [secondbedirBG addSubview:secondProfileImageBG];
    
    
    /***
     * Second Player Name Label
     **/
    
    UILabel* secondPlayerName = [[UILabel alloc] init];
    secondPlayerName.frame = CGRectMake(10, 60,40 , 15);
    secondPlayerName.textAlignment = NSTextAlignmentCenter;
    secondPlayerName.textColor = [UIColor  whiteColor];
    secondPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondPlayerName.backgroundColor = [UIColor clearColor];
    secondPlayerName.text=@"Papeo";
    secondPlayerName.adjustsFontSizeToFitWidth = YES;
    [secondbedirBG addSubview:secondPlayerName];
    /***
     * Second Player Score Label
     **/
    
    UILabel* secondPlayerScore = [[UILabel alloc] init];
    secondPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    secondPlayerScore.textAlignment = NSTextAlignmentCenter;
    secondPlayerScore.textColor = [UIColor  whiteColor];
    secondPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondPlayerScore.backgroundColor = [UIColor clearColor];
    secondPlayerScore.text=@"4345";
    secondPlayerScore.adjustsFontSizeToFitWidth = YES;
    [secondbedirBG addSubview:secondPlayerScore];
    
    UIImage *thirdbedirimage =[UIImage imageNamed:@"Secondbedir"];
    thirdbedirBG=[[UIImageView alloc]initWithImage:thirdbedirimage];//CreateSheet_BG
    thirdbedirBG.frame=CGRectMake(310.0+75*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
    [self.view addSubview:thirdbedirBG];
    
    UIImage *thirdProfileImage =[UIImage imageNamed:@"playes3"];
    UIImageView  *thirdProfileImageBG=[[UIImageView alloc]initWithImage:thirdProfileImage];//CreateSheet_BG
    thirdProfileImageBG.frame=CGRectMake(15, 5,thirdProfileImage.size.width-8 , thirdProfileImage.size.height-6);
    thirdProfileImageBG.layer.masksToBounds = YES;
    thirdProfileImageBG.layer.cornerRadius=27;
    [thirdbedirBG addSubview:thirdProfileImageBG];
    
    /***
     * Third Player Name Label
     **/
    
    UILabel* thirdPlayerName = [[UILabel alloc] init];
    thirdPlayerName.frame = CGRectMake(5, 55,70 , 15);
    thirdPlayerName.textAlignment = NSTextAlignmentCenter;
    thirdPlayerName.textColor = [UIColor  whiteColor];
    thirdPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    thirdPlayerName.backgroundColor = [UIColor clearColor];
    thirdPlayerName.text=@"Pamela...4345";
    thirdPlayerName.adjustsFontSizeToFitWidth = YES;
    [thirdbedirBG addSubview:thirdPlayerName];
    
//    UIImage *fourthbedirimage =[UIImage imageNamed:@"draco"];
//    fouthbedirBG=[[UIImageView alloc]initWithImage:fourthbedirimage];//CreateSheet_BG
//    fouthbedirBG.frame=CGRectMake(245.0, 222,fourthbedirimage.size.width , fourthbedirimage.size.height);
//    [self.view addSubview:fouthbedirBG];
    
    UIImage *fourthbedirimage =[UIImage imageNamed:@"Secondbedir"];
    fouthbedirBG=[[UIImageView alloc]initWithImage:fourthbedirimage];//CreateSheet_BG
    fouthbedirBG.frame=CGRectMake(200.0+45*isiPhone5(), 210,fourthbedirimage.size.width , fourthbedirimage.size.height);
    [self.view addSubview:fouthbedirBG];
    
    
    /***
     * Fourth Player Name Label
     **/
    
    UILabel* fourthPlayerName = [[UILabel alloc] init];
    //fourthPlayerName.frame = CGRectMake(5, 45,70 , 15);
    fourthPlayerName.frame = CGRectMake(5, 55,70 , 15);
    fourthPlayerName.textAlignment = NSTextAlignmentCenter;
    fourthPlayerName.textColor = [UIColor  whiteColor];
    fourthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fourthPlayerName.backgroundColor = [UIColor clearColor];
    fourthPlayerName.text=@"Draco...4345";
    fourthPlayerName.adjustsFontSizeToFitWidth = YES;
    [fouthbedirBG addSubview:fourthPlayerName];
    
    
    fifthbedirBG=[[UIImageView alloc]initWithImage:thirdbedirimage];//CreateSheet_BG
    fifthbedirBG.frame=CGRectMake(90.0+15*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
    [self.view addSubview:fifthbedirBG];
    
    
    UIImage *fifthProfileImage =[UIImage imageNamed:@"playes4"];
    UIImageView  *fifthProfileImageBG=[[UIImageView alloc]initWithImage:fifthProfileImage];//CreateSheet_BG
    fifthProfileImageBG.frame=CGRectMake(15, 4.5,fifthProfileImage.size.width-8 , fifthProfileImage.size.height-6);
    fifthProfileImageBG.layer.masksToBounds = YES;
    fifthProfileImageBG.layer.cornerRadius=27;
    [fifthbedirBG addSubview:fifthProfileImageBG];
    /***
     * Fifth Player Name Label
     **/
    
    UILabel* fifthPlayerName = [[UILabel alloc] init];
    fifthPlayerName.frame = CGRectMake(5, 55,70 , 15);
    fifthPlayerName.textAlignment = NSTextAlignmentCenter;
    fifthPlayerName.textColor = [UIColor  whiteColor];
    fifthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fifthPlayerName.backgroundColor = [UIColor clearColor];
    fifthPlayerName.text=@"Marilyn...4345";
    fifthPlayerName.adjustsFontSizeToFitWidth = YES;
    [fifthbedirBG addSubview:fifthPlayerName];
    
    
    sixthbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    sixthbedirBG.frame=CGRectMake(10.0, 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:sixthbedirBG];
    
    UIImage *sixthProfileImage =[UIImage imageNamed:@"playes5"];
    UIImageView  *sixthProfileImageBG=[[UIImageView alloc]initWithImage:sixthProfileImage];//CreateSheet_BG
    sixthProfileImageBG.frame=CGRectMake(4, 4,sixthProfileImage.size.width-7 , sixthProfileImage.size.height-6);
    sixthProfileImageBG.layer.masksToBounds = YES;
    sixthProfileImageBG.layer.cornerRadius=27;
    [sixthbedirBG addSubview:sixthProfileImageBG];
    
    /***
     * Sixth Player Name Label
     **/
    
    UILabel* sixthPlayerName = [[UILabel alloc] init];
    sixthPlayerName.frame = CGRectMake(10, 60,40 , 15);
    sixthPlayerName.textAlignment = NSTextAlignmentCenter;
    sixthPlayerName.textColor = [UIColor  whiteColor];
    sixthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthPlayerName.backgroundColor = [UIColor clearColor];
    sixthPlayerName.text=@"Noel";
    sixthPlayerName.adjustsFontSizeToFitWidth = YES;
    [sixthbedirBG addSubview:sixthPlayerName];
    /***
     * Sixth Player Score Label
     **/
    
    UILabel* sixthPlayerScore = [[UILabel alloc] init];
    sixthPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    sixthPlayerScore.textAlignment = NSTextAlignmentCenter;
    sixthPlayerScore.textColor = [UIColor  whiteColor];
    sixthPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthPlayerScore.backgroundColor = [UIColor clearColor];
    sixthPlayerScore.text=@"4345";
    sixthPlayerScore.adjustsFontSizeToFitWidth = YES;
    [sixthbedirBG addSubview:sixthPlayerScore];
    
    
    seventhbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    seventhbedirBG.frame=CGRectMake(108+25*isiPhone5(), 15,bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:seventhbedirBG];
    
    UIImage *seventhProfileImage =[UIImage imageNamed:@"playes6"];
    UIImageView  *seventhProfileImageBG=[[UIImageView alloc]initWithImage:seventhProfileImage];//CreateSheet_BG
    seventhProfileImageBG.frame=CGRectMake(4, 4,seventhProfileImage.size.width-7 , seventhProfileImage.size.height-6);
    seventhProfileImageBG.layer.masksToBounds = YES;
    seventhProfileImageBG.layer.cornerRadius=27;
    [seventhbedirBG addSubview:seventhProfileImageBG];
    
    /***
     * Seventh Player Name Label
     **/
    
    UILabel* seventhPlayerName = [[UILabel alloc] init];
    seventhPlayerName.frame = CGRectMake(10, 60,40 , 15);
    seventhPlayerName.textAlignment = NSTextAlignmentCenter;
    seventhPlayerName.textColor = [UIColor  whiteColor];
    seventhPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhPlayerName.backgroundColor = [UIColor clearColor];
    seventhPlayerName.text=@"Bedir";
    seventhPlayerName.adjustsFontSizeToFitWidth = YES;
    [seventhbedirBG addSubview:seventhPlayerName];
    /***
     * Second Player Score Label
     **/
    
    UILabel* seventhPlayerScore = [[UILabel alloc] init];
    seventhPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    seventhPlayerScore.textAlignment = NSTextAlignmentCenter;
    seventhPlayerScore.textColor = [UIColor  whiteColor];
    seventhPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhPlayerScore.backgroundColor = [UIColor clearColor];
    seventhPlayerScore.adjustsFontSizeToFitWidth = YES;
    seventhPlayerScore.text=@"4345";
    [seventhbedirBG addSubview:seventhPlayerScore];
    
    
    //[self addProgressViews];
    first =[[NSMutableArray alloc]init];
    second =[[NSMutableArray alloc]init];
    final1 =[[NSMutableArray alloc]init];
    final2 =[[NSMutableArray alloc]init];
    
    firstDict =[[NSMutableDictionary alloc]init];
    secondDict=[[NSMutableDictionary alloc]init];
    
    round=0;
    flopCradCount=0;
    
    centerLbl = [[UILabel alloc] init];
    centerLbl.frame = CGRectMake(55+45*isiPhone5(),170, 370, 40);//140,140, 250, 40
    centerLbl.textAlignment = NSTextAlignmentCenter;
    centerLbl.textColor = [UIColor  whiteColor];
    centerLbl.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.0];
    centerLbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerLbl];
    
    
    _communityView =[[UIView alloc]initWithFrame:CGRectMake(176+40*isiPhone5(),140, 140, 36)];
    _communityView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_communityView];
    
    [self addProgressViews];
    
    _cardContainerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480+88*isiPhone5(), 320)];
    _cardContainerView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_cardContainerView];
    
    FirstPlayerscoreView =[[UIView alloc]init];
    FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
    FirstPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:FirstPlayerscoreView];
    
    UIImage *firstChipImage =[UIImage imageNamed:@"chip-red"];
    UIImageView *firstChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    firstChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [FirstPlayerscoreView addSubview:firstChipImageView];
    
    UILabel* firstScoreLabel = [[UILabel alloc] init];
    firstScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    firstScoreLabel.textAlignment = NSTextAlignmentCenter;
    firstScoreLabel.textColor = [UIColor  whiteColor];
    firstScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstScoreLabel.backgroundColor = [UIColor blackColor];
    firstScoreLabel.layer.cornerRadius=5;
    firstScoreLabel.clipsToBounds = YES;
    firstScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    firstScoreLabel.text=@"4345";
    [FirstPlayerscoreView addSubview:firstScoreLabel];
    
    FirstPlayerscoreView.hidden=YES;
    
    
    secondPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(375+70*isiPhone5(), 147, 40, 30)];
    secondPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:secondPlayerscoreView];
    
    UIImageView *secondChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    secondChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [secondPlayerscoreView addSubview:secondChipImageView];
    
    UILabel* secondScoreLabel = [[UILabel alloc] init];
    secondScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    secondScoreLabel.textAlignment = NSTextAlignmentCenter;
    secondScoreLabel.textColor = [UIColor  whiteColor];
    secondScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondScoreLabel.backgroundColor = [UIColor blackColor];
    secondScoreLabel.layer.cornerRadius=5;
    secondScoreLabel.clipsToBounds = YES;
    secondScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    secondScoreLabel.text=@"4345";
    [secondPlayerscoreView addSubview:secondScoreLabel];
    
    secondPlayerscoreView.hidden=YES;
    
    
    thirdPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(320+75*isiPhone5(), 175, 40, 30)];
    thirdPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:thirdPlayerscoreView];
    
    
    UIImageView *thirdChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    thirdChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [thirdPlayerscoreView addSubview:thirdChipImageView];
    
    UILabel* thirdScoreLabel = [[UILabel alloc] init];
    thirdScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    thirdScoreLabel.textAlignment = NSTextAlignmentCenter;
    thirdScoreLabel.textColor = [UIColor  whiteColor];
    thirdScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    thirdScoreLabel.backgroundColor = [UIColor blackColor];
    thirdScoreLabel.layer.cornerRadius=5;
    thirdScoreLabel.clipsToBounds = YES;
    thirdScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    thirdScoreLabel.text=@"4345";
    [thirdPlayerscoreView addSubview:thirdScoreLabel];
    
    thirdPlayerscoreView.hidden=YES;
    
    fouthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(220+45*isiPhone5(), 180, 40, 30)];
    fouthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:fouthPlayerscoreView];
    
    
    UIImageView *fourthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    fourthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [fouthPlayerscoreView addSubview:fourthChipImageView];
    
    UILabel* fourthScoreLabel = [[UILabel alloc] init];
    fourthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    fourthScoreLabel.textAlignment = NSTextAlignmentCenter;
    fourthScoreLabel.textColor = [UIColor  whiteColor];
    fourthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fourthScoreLabel.backgroundColor = [UIColor blackColor];
    fourthScoreLabel.layer.cornerRadius=5;
    fourthScoreLabel.clipsToBounds = YES;
    fourthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    fourthScoreLabel.text=@"4345";
    [fouthPlayerscoreView addSubview:fourthScoreLabel];
    
    fouthPlayerscoreView.hidden=YES;
    
    
    fifthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(115+20*isiPhone5(), 175, 40, 30)];
    fifthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:fifthPlayerscoreView];
    
    
    UIImageView *fifthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    fifthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [fifthPlayerscoreView addSubview:fifthChipImageView];
    
    UILabel* fifthScoreLabel = [[UILabel alloc] init];
    fifthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    fifthScoreLabel.textAlignment = NSTextAlignmentCenter;
    fifthScoreLabel.textColor = [UIColor  whiteColor];
    fifthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fifthScoreLabel.backgroundColor = [UIColor blackColor];
    fifthScoreLabel.layer.cornerRadius=5;
    fifthScoreLabel.clipsToBounds = YES;
    fifthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    fifthScoreLabel.text=@"4345";
    [fifthPlayerscoreView addSubview:fifthScoreLabel];
    
    fifthPlayerscoreView.hidden=YES;
    
    
    sixthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(65+20*isiPhone5(), 140, 40, 30)];
    sixthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:sixthPlayerscoreView];
    
    
    UIImageView *sixthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    sixthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [sixthPlayerscoreView addSubview:sixthChipImageView];
    
    UILabel* sixthScoreLabel = [[UILabel alloc] init];
    sixthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    sixthScoreLabel.textAlignment = NSTextAlignmentCenter;
    sixthScoreLabel.textColor = [UIColor  whiteColor];
    sixthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthScoreLabel.backgroundColor = [UIColor blackColor];
    sixthScoreLabel.layer.cornerRadius=5;
    sixthScoreLabel.clipsToBounds = YES;
    sixthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    sixthScoreLabel.text=@"4345";
    [sixthPlayerscoreView addSubview:sixthScoreLabel];
    
    sixthPlayerscoreView.hidden=YES;
    
    seventhPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(125+20*isiPhone5(), 115, 40, 30)];
    seventhPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:seventhPlayerscoreView];
    
    
    UIImageView *seventhChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];//CreateSheet_BG
    seventhChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [seventhPlayerscoreView addSubview:seventhChipImageView];
    
    UILabel* seventhScoreLabel = [[UILabel alloc] init];
    seventhScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    seventhScoreLabel.textAlignment = NSTextAlignmentCenter;
    seventhScoreLabel.textColor = [UIColor  whiteColor];
    seventhScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhScoreLabel.backgroundColor = [UIColor blackColor];
    seventhScoreLabel.layer.cornerRadius=5;
    seventhScoreLabel.clipsToBounds = YES;
    seventhScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    seventhScoreLabel.text=@"4345";
    [seventhPlayerscoreView addSubview:seventhScoreLabel];
    
    seventhPlayerscoreView.hidden=YES;
    
    
    totalBetamount =[[UIView alloc]initWithFrame:CGRectMake(220+45*isiPhone5(), 110, 40, 30)];
    totalBetamount.backgroundColor=[UIColor clearColor];
    [self.view addSubview:totalBetamount];
    
    UIImage *totalChipsimage =[UIImage imageNamed:@"chip-red"];
    UIImageView *totalChipImageView=[[UIImageView alloc]initWithImage:totalChipsimage];//CreateSheet_BG
    totalChipImageView.frame=CGRectMake(13, 5,totalChipsimage.size.width , totalChipsimage.size.height);
    [totalBetamount addSubview:totalChipImageView];
    
    UILabel* totalScoreLabel = [[UILabel alloc] init];
    totalScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    totalScoreLabel.textAlignment = NSTextAlignmentCenter;
    totalScoreLabel.textColor = [UIColor  whiteColor];
    totalScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    totalScoreLabel.backgroundColor = [UIColor blackColor];
    totalScoreLabel.layer.cornerRadius=5;
    totalScoreLabel.clipsToBounds = YES;
    totalScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    totalScoreLabel.text=@"4345";
    [totalBetamount addSubview:totalScoreLabel];

    totalBetamount.hidden=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFlopCards) name:@"updateFlopCards" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTurnCard) name:@"updateTurnCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRiverCard) name:@"updateRiverCard" object:nil];
    
    

    
    /***
     * Check Button
     **/
    
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton addTarget:self
                    action:@selector(checkButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    checkButton.backgroundColor =[UIColor clearColor];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [checkButton setTitle:@"Check" forState:UIControlStateNormal];
    checkButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.frame = CGRectMake(0+1*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:checkButton];
    
    /***
     * Call Button
     **/
    
    callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton addTarget:self
                   action:@selector(callButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    callButton.backgroundColor =[UIColor clearColor];
    [callButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [callButton setTitle:@"Call" forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];

    callButton.frame = CGRectMake(96+17.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:callButton];
    
    
    /***
     * Fold Button
     **/
    
    foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [foldButton addTarget:self
                   action:@selector(foldButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    foldButton.backgroundColor =[UIColor clearColor];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [foldButton setTitle:@"Fold" forState:UIControlStateNormal];
    foldButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];

    [foldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    foldButton.frame = CGRectMake(192+35.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:foldButton];
    
    /***
     * Allin Button
     **/
    
    allinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [allinButton addTarget:self
                    action:@selector(allinButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    allinButton.backgroundColor =[UIColor clearColor];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [allinButton setTitle:@"All in" forState:UIControlStateNormal];
    allinButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];

    [allinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allinButton.frame = CGRectMake(288+53.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:allinButton];
    
    /***
     * Bet Button
     **/
    
    betButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [betButton addTarget:self
                  action:@selector(betButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    betButton.backgroundColor =[UIColor clearColor];
    [betButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [betButton setTitle:@"Bet" forState:UIControlStateNormal];
    betButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];

    [betButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    betButton.frame = CGRectMake(384+71*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:betButton];

    /***
     * SitOut Button
     **/
    
    sitOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sitOutButton addTarget:self
                   action:@selector(sitOutButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    sitOutButton.backgroundColor =[UIColor clearColor];
    [sitOutButton setBackgroundImage:[UIImage imageNamed:@"Sitout"] forState:UIControlStateNormal];
    [sitOutButton setTitle:@"SIT OUT" forState:UIControlStateNormal];
    [sitOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sitOutButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10];
    
    sitOutButton.frame = CGRectMake(412+78*isiPhone5(), 15, 60, 20);
    [self.view addSubview:sitOutButton];
    
    /***
     * Leave Button
     **/
    
    UIButton *leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaveButton addTarget:self
                     action:@selector(leaveButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    leaveButton.backgroundColor =[UIColor clearColor];
    [leaveButton setBackgroundImage:[UIImage imageNamed:@"Sitout"] forState:UIControlStateNormal];
    [leaveButton setTitle:@"LEAVE" forState:UIControlStateNormal];
    [leaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leaveButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10];
    
    leaveButton.frame = CGRectMake(412+78*isiPhone5(), 35, 60, 20);
    [self.view addSubview:leaveButton];
    
    /***
     * Rules Button
     **/
    
    UIButton *rulesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rulesButton addTarget:self
                    action:@selector(rulesButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    rulesButton.backgroundColor =[UIColor clearColor];
    [rulesButton setBackgroundImage:[UIImage imageNamed:@"rulesbg"] forState:UIControlStateNormal];
    [rulesButton setTitle:@"RULES" forState:UIControlStateNormal];
    [rulesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rulesButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10];
    
    rulesButton.frame = CGRectMake(10, 15, 60, 20);
    [self.view addSubview:rulesButton];
    
    
    _players = [NSMutableDictionary dictionaryWithCapacity:7];
    Player *player1 = [[Player alloc] init];
    player1.position= PlayerPositionLTop;
    player1.peerID=@"0";
    player1.name=@"Nag0";
    [_players setObject:player1 forKey:@"0"];
    
    Player *player2 = [[Player alloc] init];
    player2.position= PlayerPositionLMiddle;
    player2.peerID=@"1";
    player2.name=@"Nag1";
    [_players setObject:player2 forKey:@"1"];
    
    Player *player3 = [[Player alloc] init];
    player3.position= PlayerPositionLBottom;
    player3.peerID=@"2";
    player3.name=@"Nag2";
    [_players setObject:player3 forKey:@"2"];
    
    Player *player4 = [[Player alloc] init];
    player4.position= PlayerPositionMiddle;
    player4.peerID=@"3";
    player4.name=@"Nag3";
    [_players setObject:player4 forKey:@"3"];
    
    Player *player5 = [[Player alloc] init];
    player5.position= PlayerPositionRBottom;
    player5.peerID=@"4";
    player5.name=@"Nag4";
    [_players setObject:player5 forKey:@"4"];
    
    Player *player6 = [[Player alloc] init];
    player6.position= PlayerPositionRMiddle;
    player6.peerID=@"5";
    player6.name=@"Nag5";
    [_players setObject:player6 forKey:@"5"];
    
    Player *player7 = [[Player alloc] init];
    player7.position= PlayerPositionRTop;
    player7.peerID=@"6";
    player7.name=@"Nag6";
    [_players setObject:player7 forKey:@"6"];
    
    [self pickRandomStartingPlayer];
    
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: sitOutButton,nil]];
    
    Deck *deck =[[Deck alloc]init];
    [deck shuffle];
    cumulativeCards =[deck  cummilativeCards];
    while ([deck cardsRemaining] > 0)
    {
        for (PlayerPosition p = _startingPlayerPosition; p < _startingPlayerPosition + 7; ++p)
        {
            Player *player = [self playerAtPosition:(p % 7)];
            if ([deck cardsRemaining] > 0)
            {
                Card *card = [deck draw];
                [player.closedCards addCardToTop:card];
            }
            
        }
        
    }
    
    Player *startingPlayer = [self activePlayer];
    NSMutableDictionary *playerCards = [NSMutableDictionary dictionaryWithCapacity:4];
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, Player *obj, BOOL *stop)
     {
         NSArray *array = [obj.closedCards array];
         [playerCards setObject:array forKey:obj.peerID];
     }];
    
    [self ButtonPressedstartingWithPlayer:startingPlayer];

    
}
- (void)loadSounds
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    audioSession.delegate = nil;
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Dealing" withExtension:@"caf"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = -1;
    [_dealingCardsSound prepareToPlay];
}
#pragma mark - Auxilliary Functions

/**********************************************************
 * Following functions enables interaction for a set
 * of views defined by an array
 **********************************************************/

- (void)enableInteraction:(BOOL)shouldInteract arrayOfViews:(NSArray *)arrayOfViews
{
    for(UIView * view in arrayOfViews)
    {
        [view setUserInteractionEnabled:shouldInteract];
    }
}

#pragma mark Starting With Player

-(void)ButtonPressedstartingWithPlayer:(Player *)startingPlayer
{
    NSTimeInterval delay = 1.0f;
    
    //Player *startingPlayer; //=PlayerPositionBottom;
    
    _dealingCardsSound.currentTime = 0.0f;
    [_dealingCardsSound prepareToPlay];
    [_dealingCardsSound performSelector:@selector(play) withObject:nil afterDelay:delay];
    
    for (int t = 0; t < 2; ++t)
    {
        for (PlayerPosition p = startingPlayer.position; p < startingPlayer.position + 7; ++p)
        {
            Player *player = [self playerAtPosition:p % 7];
            if (player != nil && t < [player.closedCards cardCount])
            {
                CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                cardView.card = [player.closedCards cardAtIndex:t];
                [self.cardContainerView addSubview:cardView];
                if(player.position<4)
                [cardView animateDealingToPlayer:player withDelay:delay angle:0+35*t Xvalue:0+10*t Yvalue:0+5*t];
                else
                [cardView animateDealingToPlayer:player withDelay:delay angle:0-35*t Xvalue:0-10*t Yvalue:0+5*t];
                delay += 0.1f;
            }
        }
        
        
    }
    [self performSelector:@selector(afterDealing) withObject:nil afterDelay:delay];
}

#pragma mark After Dealing

- (void)afterDealing
{
    	[_dealingCardsSound stop];
    //	self.snapButton.hidden = NO;
    [self beginRound];
}

#pragma mark Begin Round

-(void)beginRound
{
    
    isfirst= YES;
    [self turnCardForPlayerAtBottom];
     _activePlayerPosition =PlayerPositionLTop;
    [self  showIndicatorForActivePlayer];
    
    
}

#pragma mark Show Indicater For Player

-(void)showIndicatorForActivePlayer
{
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
    
    PlayerPosition position = [self activePlayer].position;
    switch (position)
    {
        case PlayerPositionLTop:
        {
            
            [self addScoresInFrontOfPlayers:position];
            circularView0.hidden = NO;
            [circularView0 play];
            break;
        }
        case PlayerPositionLMiddle:
        {
            circularView1.hidden = NO;
            [circularView1 play];
            [self addScoresInFrontOfPlayers:position];
            break;
        }
        case PlayerPositionLBottom:
        {
            [self addScoresInFrontOfPlayers:position];
            circularView2.hidden = NO;
            [circularView2 play];
            break;
        }
        case PlayerPositionMiddle:
        {
            [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
            
            if(ActiveAtPositionMiddle==NO)
            {
            _activePlayerPosition++;
            [self showIndicatorForActivePlayer];
            }
            else
            {
            [self addScoresInFrontOfPlayers:position];
            circularView3.hidden = NO;
            [circularView3 play];
            break;
            }
        }
        case PlayerPositionRBottom:
        {
            [self addScoresInFrontOfPlayers:position];
            circularView4.hidden = NO;
            [circularView4 play];
            break;
        }
        case PlayerPositionRMiddle:
        {
            [self addScoresInFrontOfPlayers:position];
            circularView5.hidden = NO;
            [circularView5 play];
            break;
        }
        case PlayerPositionRTop:
        {
            [self addScoresInFrontOfPlayers:position];
            circularView6.hidden = NO;
            [circularView6 play];
            break;
        }
    }
    
    //if (position == PlayerPositionLTop)
        //centerLbl.text = NSLocalizedString(@"Your turn. Tap the stack.", @"Status text: your turn");
    //else
        //centerLbl.text = [NSString stringWithFormat:NSLocalizedString(@"%@'s turn", @"Status text: other player's turn"), [self activePlayer].name];
    
}



#pragma mark TurnBottom Player Cards

-(void)turnCardForPlayerAtBottom
{
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: sitOutButton,nil]];
    _activePlayerPosition =PlayerPositionMiddle;
    
    if (_activePlayerPosition == PlayerPositionMiddle
        && [[self activePlayer].closedCards cardCount] > 0)
    {
        [self turnCardForActivePlayer];
        
    }
}

-(void)turnCardForActivePlayer
{
    [self turnCardForPlayer:[self activePlayer]];
    
}
- (void)turnCardForPlayer:(Player *)player
{
    NSAssert([player.closedCards cardCount] > 0, @"Player has no more cards");
    
    //_hasTurnedCard = YES;
    
    Card *card = [player turnOverTopCard];
    [myOpencards addObject:card];
    
    CardView *cardView = [self cardViewForCard:card];
    if(isfirst ==NO)
        cardView.isFirst=YES;
    else
        cardView.isFirst=NO;
    
    [cardView animateTurningOverForPlayer:player success:^()
     {
         if(player.position==PlayerPositionMiddle)
         {
             if(isfirst ==YES)
             {
                 isfirst=NO;
                 [self turnCardForPlayerAtBottom];
             }
             /*
              else
              {
              [self turnsAllPlayersCards];
              }
              */
         }
     }];
}

- (CardView *)cardViewForCard:(Card *)card
{
    for (CardView *cardView in self.cardContainerView.subviews)
    {
        
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}

#pragma mark Removing Cards


-(void)removeCardsAtThePlayer:(PlayerPosition)position
{
    Player *player;
    player.position = PlayerPositionLTop;
    
}



- (CardView *)communityCardViewForCard:(Card *)card
{
    for (CardView *cardView in self.communityView.subviews)
    {
        
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}

#pragma mark Picking Stating Random Player

- (void)pickRandomStartingPlayer
{
    do
    {
        _startingPlayerPosition = 0;
    }
    while ([self playerAtPosition:_startingPlayerPosition] == nil);
    // if([self playerAtPosition:_startingPlayerPosition]==nil)
    _activePlayerPosition = _startingPlayerPosition;
}

#pragma mark Player Position

- (Player *)playerAtPosition:(PlayerPosition)position
{
    
    NSAssert(position >= PlayerPositionLTop && position <= PlayerPositionRTop, @"Invalid player position");
    
    __block Player *player;
    
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         player = obj;
         
         if (player.position == position)
             *stop = YES;
         else
             player = nil;
     }];
    
    return player;
}

#pragma mark Active Player

- (Player *)activePlayer
{
    return [self playerAtPosition:_activePlayerPosition];
}


#pragma mark Check Button Action

-(void)checkButtonPressed
{
    NSLog(@"checkButtonPressed");
    [circularView3 stop];
    _activePlayerPosition++;
    [self showIndicatorForActivePlayer];
}

#pragma mark Call Button Action

-(void)callButtonPressed
{
    NSLog(@"callButtonPressed");
    [circularView3 stop];
    _activePlayerPosition++;
    [self showIndicatorForActivePlayer];
}
#pragma mark Fold Button Action

-(void)foldButtonPressed
{
    ActiveAtPositionMiddle =NO;
     NSLog(@"foldButtonPressed");
    fouthbedirBG.alpha=0.5;
    
    NSLog(@"My Open Cards %@",myOpencards);
    if(_activePlayerPosition==PlayerPositionMiddle)
    {
        [circularView3 stop];
        _activePlayerPosition++;
        [self showIndicatorForActivePlayer];
        
    }
    
    for(int i=0;i<2;i++)
    {
        CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
        NSLog(@"cardView value %d",cardView.card.value);
        
            
            [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
        
    }
    
    
}

#pragma mark All in Button Action

-(void)allinButtonPressed
{
   NSLog(@"allinButtonPressed");
    [circularView3 stop];
    _activePlayerPosition++;
    [self showIndicatorForActivePlayer];
}
#pragma mark Bet Button Action

-(void)betButtonPressed
{
    NSLog(@"betButtonPressed");
    
    UIImage *minImage = [[UIImage imageNamed:@"slider_minimum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider_maximum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *thumbImage = [UIImage imageNamed:@"sliderhandle.png"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,nil]] ;
    
    sliderView =[[UIView alloc]init];
    sliderView.frame=CGRectMake(378+80*isiPhone5(), 95, 102, 225);
    sliderView.backgroundColor=[UIColor  colorWithPatternImage:[UIImage imageNamed:@"rating_bg"]];
    //sliderView.layer.cornerRadius=10;
    [self.view addSubview:sliderView];
    
    CGRect frame = CGRectMake(-30.0, 110.0, 165, 20.0);
    slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.transform=CGAffineTransformRotate(slider.transform,270.0/180*M_PI);
    slider.minimumValue = 1.0;
    slider.maximumValue = 50.0;
    slider.continuous = YES;
    slider.value = 25.0;
    [sliderView addSubview:slider];
    
    amountLbl = [[UILabel alloc] init];
    amountLbl.frame = CGRectMake(30,5,45 , 24);//175
    amountLbl.textAlignment = NSTextAlignmentCenter;
    amountLbl.textColor = [UIColor  whiteColor];
    amountLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:16];
    amountLbl.backgroundColor = [UIColor clearColor];
    amountLbl.clipsToBounds=YES;
    amountLbl.layer.cornerRadius=5;
    amountLbl.text=[NSString stringWithFormat:@"25K"];
    [sliderView addSubview:amountLbl];
    
    /***
     * Conform Button
     **/
    
    UIButton *conformButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [conformButton addTarget:self
                   action:@selector(conformButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    conformButton.backgroundColor =[UIColor clearColor];
    //conformButton.layer.cornerRadius=5;
    [conformButton setBackgroundImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    //[conformButton setTitle:@"Confirm" forState:UIControlStateNormal];
    //[conformButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //conformButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:12];
    conformButton.frame = CGRectMake(20, 200, 63, 23);
    [sliderView addSubview:conformButton];
    
    
}

-(void)sliderAction:(id)sender
{
    UISlider *sliderr = (UISlider*)sender;
    int value = sliderr.value;
    //-- Do further actions
    //amountLbl.center = CGPointMake(15, slider.value+amountLbl.frame.origin.y);
    amountLbl.text=[NSString stringWithFormat:@"%dK",value];
}

-(void)conformButtonPressed
{
    [sliderView removeFromSuperview];
    [circularView3 stop];
    _activePlayerPosition++;
    [self showIndicatorForActivePlayer];
    
}

#pragma mark SitOut Button Action

-(void)sitOutButtonPressed
{
    ActiveAtPositionMiddle =NO;
    NSLog(@"foldButtonPressed");
    fouthbedirBG.alpha=0.5;
    for(int i=0;i<2;i++)
    {
        CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
        NSLog(@"cardView value %d",cardView.card.value);
        
        
        [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
        
    }
}

#pragma mark Leave Button Action

-(void)leaveButtonPressed
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Conformation" message:@"Are you sure to exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"NO",@"Yes" ,nil];
    alert.tag=111;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==111&buttonIndex==1)
    {
        flopCradCount=0;
        round=0;
        [circularView0 stop];
        [circularView0 removeFromSuperview];
        [circularView1  stop];
        [circularView1 removeFromSuperview];
        [circularView2 removeFromSuperview];
        [circularView2 stop];
        [circularView3 stop];
        [circularView3 removeFromSuperview];
        [circularView4  stop];
        [circularView4 removeFromSuperview];
        [circularView5 removeFromSuperview];
        [circularView5 stop];
        [circularView6 removeFromSuperview];
        [circularView6 stop];
        
        [_dealingCardsSound stop];
        [[AVAudioSession sharedInstance] setActive:NO error:NULL];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showIndicatorForActivePlayer) object:Nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnRiverCards) object:nil];

        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(winningConditions) object:nil];

        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnFlopCards) object:nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(afterDealing) object:nil];//turnTurnCards
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnTurnCards) object:nil];
        
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"updateFlopCards" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"updateTurnCard" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"updateRiverCard" object:nil];
        
      [self.navigationController popViewControllerAnimated:NO];

    }
}

#pragma mark Rules Button Action

-(void)rulesButtonPressed
{
    [rulesView ShowViewWithRules:self.view];
}

#pragma mark Adding circular progressbars

-(void)addProgressViews
{
    
    circularView0 =[[CircularProgressView alloc]initWithFrame:CGRectMake(309.5+65*isiPhone5(), -5, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    [self.view addSubview:circularView0];
    circularView0.delegate=self;
    circularView0.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    //_circularProgressView.audioPath = [[NSBundle mainBundle] URLForResource:@"timer-check-40secs" withExtension:@"mp3"];
    circularView0.hidden=YES;
    [circularView0 stop];
    
    
    circularView1 =[[CircularProgressView alloc]initWithFrame:CGRectMake(409.5+90*isiPhone5(), 65-5*isiPhone5(), 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView1.delegate=self;
    circularView1.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView1.hidden=YES;
    [circularView1 stop];
    [self.view addSubview:circularView1];
    
    circularView2 =[[CircularProgressView alloc]initWithFrame:CGRectMake(320+75*isiPhone5(), 190, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView2.delegate=self;
    circularView2.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView2.hidden=YES;
    [circularView2 stop];
    [self.view addSubview:circularView2];
    
    circularView3 =[[CircularProgressView alloc]initWithFrame:CGRectMake(210+45*isiPhone5(), 190, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView3.delegate=self;
    circularView3.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView3.hidden=YES;
    [circularView3 stop];
    [self.view addSubview:circularView3];
    
    circularView4 =[[CircularProgressView alloc]initWithFrame:CGRectMake(100+15*isiPhone5(), 190, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView4.delegate=self;
    circularView4.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView4.hidden=YES;
    [circularView4 stop];
    [self.view addSubview:circularView4];
    
    circularView5 =[[CircularProgressView alloc]initWithFrame:CGRectMake(10.0, 65-5*isiPhone5(), 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView5.delegate=self;
    circularView5.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView5.hidden=YES;
    [circularView5 stop];
    [self.view addSubview:circularView5];
    
    circularView6 =[[CircularProgressView alloc]initWithFrame:CGRectMake(108+25*isiPhone5(), -5, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView6.delegate=self;
    circularView6.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
    circularView6.hidden=YES;
    [circularView6 stop];
    [self.view addSubview:circularView6];
}

-(void)addScoresInFrontOfPlayers:(PlayerPosition)position
{
    PlayerPosition playerposition = position;
    
    UIImage *firstChipImage =[UIImage imageNamed:@"chip-red"];
    
    switch (playerposition)
    {
        case PlayerPositionLTop:
        {
            FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
           FirstPlayerscoreView.hidden=NO;
            
            break;
        }
        case PlayerPositionLMiddle:
        {
            secondPlayerscoreView.frame=CGRectMake(375+70*isiPhone5(), 147, 40, 30);
            secondPlayerscoreView.hidden=NO;
            
            break;
        }
        case PlayerPositionLBottom:
        {
    
            thirdPlayerscoreView.hidden=NO;
            thirdPlayerscoreView.frame=CGRectMake(320+75*isiPhone5(), 175, 40, 30);
            
            break;
            
        }
        case PlayerPositionMiddle:
        {
            
    if(ActiveAtPositionMiddle==YES)
    {
        fouthPlayerscoreView.hidden=NO;
        fouthPlayerscoreView.frame=CGRectMake(220+45*isiPhone5(), 180, 40, 30);
    }
            break;
    
            
        }
            case PlayerPositionRBottom:
        {
    
            fifthPlayerscoreView.hidden=NO;
            fifthPlayerscoreView.frame=CGRectMake(115+20*isiPhone5(), 175, 40, 30);
            break;
            
        }
            case PlayerPositionRMiddle:
        {
        
            sixthPlayerscoreView.hidden=NO;
            sixthPlayerscoreView.frame=CGRectMake(65+20*isiPhone5(), 140, 40, 30);
    
            break;
        }
        case PlayerPositionRTop:
        {
    
            
            seventhPlayerscoreView.hidden=NO;
            seventhPlayerscoreView.frame=CGRectMake(125+20*isiPhone5(), 115, 40, 30);
    
            break;
            
        }

}

    
}
#pragma mark Adding circular progressbars Delegates

- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player
{
    [self formatTime:(int)player.currentTime];
    
}
- (void)formatTime:(int)num
{
    PlayerPosition position = [self activePlayer].position;
    switch (position)
    {
        case PlayerPositionLTop:
        {
            [circularView0 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionLMiddle:
        {
            [circularView1 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionLBottom:
        {
            [circularView2 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionMiddle:
        {
            [circularView3 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionRBottom:
        {
            [circularView4 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionRMiddle:
        {
            [circularView5 setWarningShadow:num gameMode:YES];
            break;
        }
        case PlayerPositionRTop:
        {
            [circularView6 setWarningShadow:num gameMode:YES];
            break;
        }
    }
        
}

#pragma mark Rounds Handling


-(void)playerDidFinishPlaying
{
    [sliderView removeFromSuperview];
    
    if( _activePlayerPosition==PlayerPositionLTop)
    {
        circularView0.hidden=YES;
        [circularView0 stop];
    }
    else if (_activePlayerPosition==PlayerPositionLMiddle)
    {
        circularView1.hidden=YES;
        [circularView1 stop];
    }
    else if (_activePlayerPosition==PlayerPositionLBottom)
    {
        circularView2.hidden=YES;
        [circularView2 stop];
    }
    else if (_activePlayerPosition==PlayerPositionMiddle)
    {
        circularView3.hidden=YES;
        [circularView3 stop];
    }
    else if (_activePlayerPosition==PlayerPositionRBottom)
    {
        circularView4.hidden=YES;
        [circularView4 stop];
    }
    else if (_activePlayerPosition==PlayerPositionRMiddle)
    {
        circularView5.hidden=YES;
        [circularView5 stop];
    }
    else if (_activePlayerPosition==PlayerPositionRTop)
    {
        circularView6.hidden=YES;
        [circularView6 stop];
    }
    {
        _activePlayerPosition++;
        
        if (_activePlayerPosition > PlayerPositionRTop)
        {
            if(round==0)
            {
                
                NSLog(@"First Round done");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlopCards" object:self];//updateFlopCards
                NSLog(@"cumulativeCards..%@",cumulativeCards);
                round=round+1;
                _activePlayerPosition = PlayerPositionLTop;
                
            }
            else if(round==1)
            {
                NSLog(@"Second Round done");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTurnCard" object:self];
                round=round+1;
                _activePlayerPosition = PlayerPositionLTop;
            }
            else if(round==2)
            {
                NSLog(@"Third Round done");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                round=0;
                _activePlayerPosition = PlayerPositionLTop;
            }
            
        }
        else
        {
            Player *nextPlayer = [self activePlayer];
            if (nextPlayer != nil)
            {
                if ([nextPlayer.closedCards cardCount] > 0)
                {
                    //[self activatePlayerAtPosition:_activePlayerPosition];
                    [self showIndicatorForActivePlayer];
                    return;
                }
            }
        }
    }
}
#pragma mark Updating River Cards


-(void)updateRiverCard
{
    NSTimeInterval delayy = 1.0f;
    
    for (int t = 4; t < 5; ++t)
    {
        
        if ([cumulativeCards count]>0)
        {
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
            cardView.card = [cumulativeCards objectAtIndex:t];
            if(t==4)
                cardView.isFirst=NO;
            [self.communityView addSubview:cardView];
            [cardView animateRiverCardswithDelay:delayy];
            delayy += 0.1f;
            if(t==5)
            {
                isfirst=YES;
            }
            ;
        }
    }
    [self performSelector:@selector(turnRiverCards) withObject:Nil afterDelay:delayy];
}
-(void)turnRiverCards
{
    
         
         [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
             FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
         }
                          completion:^(BOOL finished)
          {
              NSLog(@"Animation 5 complete");
              Card *card = [cumulativeCards objectAtIndex:flopCradCount];
              card.isTurnedOver=YES;
              CardView *cardView = [self communityCardViewForCard:card];
              
              [cardView animateRiverCardsTurnOverWithsuccess:^()
               {
              _activePlayerPosition =-1;
              
              [self  turnsAllPlayersCards];
              
                   //[totalBetamount removeFromSuperview];
                   //[FirstPlayerscoreView removeFromSuperview];
                   FirstPlayerscoreView.hidden=YES;
                   secondPlayerscoreView.hidden=YES;
                   //             [secondPlayerscoreView removeFromSuperview];
                   //             [thirdPlayerscoreView removeFromSuperview];
                   //             [fouthPlayerscoreView removeFromSuperview];
                   //             [fifthPlayerscoreView removeFromSuperview];
                   //             [sixthPlayerscoreView removeFromSuperview];
                   //             [seventhPlayerscoreView removeFromSuperview];
                   thirdPlayerscoreView.hidden=YES;
                   fouthPlayerscoreView.hidden=YES;
                   fifthPlayerscoreView.hidden=YES;
                   sixthPlayerscoreView.hidden=YES;
                   seventhPlayerscoreView.hidden=YES;
                   totalBetamount.hidden=NO;
          }];

             }];
    
    [self performSelector:@selector(winningConditions) withObject:Nil afterDelay:5];
}

#pragma mark Winnning conditions

-(void)winningConditions
{
    
    if(_activePlayerPosition>PlayerPositionRTop)
    {
        NSMutableArray *filteredArray = [scoreArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Score" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        
        if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==0)
        {
            secondbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
             seventhbedirBG.alpha=0.5;
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            
            
            centerLbl.text = [NSString stringWithFormat:@"Alain Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(325.0+70*isiPhone5(), 35.0, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==1)
        {
            
            firstbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
            seventhbedirBG.alpha=0.5;
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Papeo Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(430+90*isiPhone5(), 100, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==2)
        {
            secondbedirBG.alpha=0.5;
            firstbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
             seventhbedirBG.alpha=0.5;
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Pamela Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(325+80*isiPhone5(), 230, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==3)
        {
            
            secondbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            firstbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
             seventhbedirBG.alpha=0.5;
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Draco Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(225+40*isiPhone5(), 230, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==4)
        {
            secondbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            firstbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
             seventhbedirBG.alpha=0.5;
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Marilyn Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(125.0, 230, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==5)
        {
            secondbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            firstbedirBG.alpha=0.5;
             seventhbedirBG.alpha=0.5;
            
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Noel Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(30.0, 100, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==6)
        {
            secondbedirBG.alpha=0.5;
            thirdbedirBG.alpha=0.5;
            fouthbedirBG.alpha=0.5;
            fifthbedirBG.alpha =0.5;
            sixthbedirBG.alpha=0.5;
            firstbedirBG.alpha=0.5;
            
            for (CardView *cardView in self.cardContainerView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews)
            {
                [cardView animateRecycleForAllPlayers];
            }
            
            centerLbl.text = [NSString stringWithFormat:@"Bedir Won the Round With Total %@", [[filteredArray valueForKey:@"Score"]objectAtIndex:0]];
            [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                totalBetamount.frame = CGRectMake(133+20*isiPhone5(), 35, 40, 30);
            }
                             completion:^(BOOL finished)
             {
                 [totalBetamount removeFromSuperview];
             }];
        }
        NSLog(@"Final Filtered Array %@",filteredArray);
        
        
    }
    else
    {
        /*
         Player *activeplayer = [self activePlayer];
         NSMutableArray *activeCards =[[NSMutableArray alloc]init];
         [activeCards addObject:activeplayer.openCards];
         NSString *SecondCardSuitString;
         NSString *FirstCardSuitString;
         NSLog(@"activeCards...%@",activeCards);
         for(int s=0;s<2;s++)
         {
         if(s==0)
         {
         Card *activecard =[activeCards objectAtIndex:s];
         NSLog(@"activecard value..%d",activecard.value);
         NSLog(@"activecard Suit..%d",activecard.suit);
         switch (activecard.suit)
         {
         case SuitClubs:    FirstCardSuitString = @"Clubs"; break;
         case SuitDiamonds: FirstCardSuitString = @"Diamonds"; break;
         case SuitHearts:   FirstCardSuitString = @"Hearts"; break;
         case SuitSpades:   FirstCardSuitString = @"Spades"; break;
         }
         }
         else
         {
         Card *Secondactivecard =[activeCards objectAtIndex:s];
         switch (Secondactivecard.suit)
         {
         case SuitClubs:    SecondCardSuitString = @"Clubs"; break;
         case SuitDiamonds: SecondCardSuitString = @"Diamonds"; break;
         case SuitHearts:   SecondCardSuitString = @"Hearts"; break;
         case SuitSpades:   SecondCardSuitString = @"Spades"; break;
         }
         
         }
         }
         
         if(FirstCardSuitString==SecondCardSuitString)
         {
         NSLog(@"Both Cards Are same for user..%u",_activePlayerPosition);
         }
         */
        
        for(int i=0;i<2;i++)
        {
            
            
            Player *player = [self activePlayer];
            
            Card *card =[player turnOveropenCards];
            if(i==0)
            {
                [first addObject:card];
                firstTime =YES;
                // [final1 addObject:card];
            }
            else
            {  Card *firstcardsuit =[first objectAtIndex:0];
                
                NSString *firstsuitString;
                switch (firstcardsuit.suit)
                {
                    case SuitClubs:    firstsuitString = @"Clubs"; break;
                    case SuitDiamonds: firstsuitString = @"Diamonds"; break;
                    case SuitHearts:   firstsuitString = @"Hearts"; break;
                    case SuitSpades:   firstsuitString = @"Spades"; break;
                }
                NSString *secondsuitString;
                switch (card.suit)
                {
                    case SuitClubs:    secondsuitString = @"Clubs"; break;
                    case SuitDiamonds: secondsuitString = @"Diamonds"; break;
                    case SuitHearts:   secondsuitString = @"Hearts"; break;
                    case SuitSpades:   secondsuitString = @"Spades"; break;
                }
                if(firstsuitString==secondsuitString)
                {
                    [first addObject:card];
                    firstTime =NO;
                }
                else
                {
                    [second addObject:card];
                    firstTime =NO;
                }
                //   [final2 addObject:card];
            }
            
            for(int j =0 ;j<5;j++)
            {
                Card *card1 =[cumulativeCards objectAtIndex:j];
                
                NSString *suitString;
                switch (card.suit)
                {
                    case SuitClubs:    suitString = @"Clubs"; break;
                    case SuitDiamonds: suitString = @"Diamonds"; break;
                    case SuitHearts:   suitString = @"Hearts"; break;
                    case SuitSpades:   suitString = @"Spades"; break;
                }
                
                //            NSString *cardvalue;
                //            switch (card.value)
                //            {
                //                case CardAce:   cardvalue = @"Ace"; break;
                //                case CardJack:  cardvalue = @"Jack"; break;
                //                case CardQueen: cardvalue = @"Queen"; break;
                //                case CardKing:  cardvalue = @"King"; break;
                //                default:        cardvalue = [NSString stringWithFormat:@"%d", card.value];
                //            }
                
                NSString *suitString1;
                switch (card1.suit)
                {
                    case SuitClubs:    suitString1 = @"Clubs"; break;
                    case SuitDiamonds: suitString1 = @"Diamonds"; break;
                    case SuitHearts:   suitString1 = @"Hearts"; break;
                    case SuitSpades:   suitString1 = @"Spades"; break;
                }
                //            NSString *cardvalue1;
                //            switch (card1.value)
                //            {
                //                case CardAce:   cardvalue1 = @"Ace"; break;
                //                case CardJack:  cardvalue1 = @"Jack"; break;
                //                case CardQueen: cardvalue1 = @"Queen"; break;
                //                case CardKing:  cardvalue1 = @"King"; break;
                //                default:        cardvalue1 = [NSString stringWithFormat:@"%d", card1.value];
                //
                //            }
                
                if(firstTime==YES)
                {
                    if(suitString == suitString1)
                    {
                        [first addObject:[cumulativeCards objectAtIndex:j]];
                        
                    }
                }
                else if (firstTime==NO)
                {
                    if(second.count>0)
                    {
                        if(suitString == suitString1)
                        {
                            [second addObject:[cumulativeCards objectAtIndex:j]];
                        }
                    }
                }
                
                
            }
            
            
        }
        NSLog(@"First Array..%@",first);
        NSLog(@"Second Array..%@",second);
        
        if(first.count>3)
        {
            for(int k=0;k<first.count;k++)
            {
                
                Card *cardvalue =[first objectAtIndex:k];
                
                
                NSString *valueString;
                switch (cardvalue.value)
                {
                    case CardAce:   valueString = @"11"; break;
                    case CardJack:  valueString = @"10"; break;
                    case CardQueen: valueString = @"10"; break;
                    case CardKing:  valueString = @"10"; break;
                    default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                }
                int value = [valueString intValue];
                [final1 addObject:[NSNumber numberWithInt:value]];
            }
            //NSLog(@"final1...%@",final1);
            NSMutableArray *filteredArray = [final1 mutableCopy];
            NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
            [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
            [final1 removeAllObjects];
            NSLog(@"filteredArray...%@",filteredArray);
            for(int z=0;z<3;z++)
            {
                [final1 addObject:[filteredArray objectAtIndex:z]];
                //Card *cardvalue =[final1 objectAtIndex:z];
                firsttotal =firsttotal+[[filteredArray objectAtIndex:z] integerValue];
                
                NSLog(@"firsttotal Inside..%d",firsttotal);
            }
            //NSLog(@"firsttotal Outside..%d",firsttotal);
        }
        else
        {
            for(int k=0;k<first.count;k++)
            {
                
                Card *cardvalue =[first objectAtIndex:k];
                NSString *valueString;
                switch (cardvalue.value)
                {
                    case CardAce:   valueString = @"11"; break;
                    case CardJack:  valueString = @"10"; break;
                    case CardQueen: valueString = @"10"; break;
                    case CardKing:  valueString = @"10"; break;
                    default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                }
                int value = [valueString intValue];
                firsttotal = firsttotal+value;
                //NSLog(@"firsttotal..%d",firsttotal);
                
            }
        }
        
        if(second.count>3)
        {
            for(int k=0;k<second.count;k++)
            {
                
                Card *cardvalue =[second objectAtIndex:k];
                
                NSString *valueString;
                switch (cardvalue.value)
                {
                    case CardAce:   valueString = @"11"; break;
                    case CardJack:  valueString = @"10"; break;
                    case CardQueen: valueString = @"10"; break;
                    case CardKing:  valueString = @"10"; break;
                    default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                }
                int value = [valueString intValue];
                [final2 addObject:[NSNumber numberWithInt:value]];
            }
            //NSLog(@"final2...%@",final2);
            
            NSMutableArray *filteredArray = [final2 mutableCopy];
            NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
            [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
            [final2 removeAllObjects];
            
            for(int z=0;z<3;z++)
            {
                [final2 addObject:[filteredArray objectAtIndex:z]];
                //Card *cardvalue =[final2 objectAtIndex:z];
                secondtotal =secondtotal+[[filteredArray objectAtIndex:z] integerValue];
                
            }
            //NSLog(@"secondtotal Outside..%d",secondtotal);
            
            
        }
        else if(second.count>0)
        {
            for(int l=0;l<second.count;l++)
            {
                Card *cardvalue =[second objectAtIndex:l];
                NSString *valueString;
                switch (cardvalue.value)
                {
                    case CardAce:   valueString = @"11"; break;
                    case CardJack:  valueString = @"10"; break;
                    case CardQueen: valueString = @"10"; break;
                    case CardKing:  valueString = @"10"; break;
                    default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                }
                int value = [valueString intValue];
                
                secondtotal = secondtotal+value;
                // NSLog(@"secondtotal..%d",secondtotal);
            }
        }
        
        if(firsttotal>secondtotal)
        {
            NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]init];
            [tempdict setValue:[NSNumber numberWithInt:firsttotal] forKey:@"Score"];
            [tempdict setValue:[NSString stringWithFormat:@"%u",_activePlayerPosition]  forKey:@"PlayerPosition"];
            [scoreArray addObject:tempdict];
            
        }
        else
        {
            NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]init];
            [tempdict setValue:[NSNumber numberWithInt:secondtotal] forKey:@"Score"];
            [tempdict setValue:[NSString stringWithFormat:@"%u",_activePlayerPosition]  forKey:@"PlayerPosition"];
            
            [scoreArray addObject:tempdict];
        }
        NSLog(@"scoreArray...%@",scoreArray);
        firsttotal=0;
        secondtotal=0;
        [final1 removeAllObjects];
        [final2 removeAllObjects];
        [first removeAllObjects];
        [second removeAllObjects];
        _activePlayerPosition++;
        if(_activePlayerPosition == PlayerPositionMiddle)
        {
            if(ActiveAtPositionMiddle==NO)
                _activePlayerPosition++;
        }
        [self winningConditions];
        
        
        //NSLog(@"openCards..%lu",(unsigned long)player.openCards.cardCount);
    }
    
}


#pragma mark Updating Flop Cards


-(void)turnFlopCards
{
    
    
         [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
             FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
         }
                          completion:^(BOOL finished)
         {
                              NSLog(@"Animation 5 complete");
             Card *card = [cumulativeCards objectAtIndex:flopCradCount];
             card.isTurnedOver=YES;
             CardView *cardView = [self communityCardViewForCard:card];
             
             [cardView animateFlopCardsTurnOverWithsuccess:^()
              {
             if(isfirst ==YES)
             {
                 isfirst=NO;
                 flopCradCount=flopCradCount+1;
                 [self turnFlopCards];
             }
             else
             {
                 flopCradCount=flopCradCount+1;
                 [self performSelector:@selector(showIndicatorForActivePlayer) withObject:Nil afterDelay:1.0];
             }
             //[totalBetamount removeFromSuperview];
             //[FirstPlayerscoreView removeFromSuperview];
               FirstPlayerscoreView.hidden=YES;
               secondPlayerscoreView.hidden=YES;
//             [secondPlayerscoreView removeFromSuperview];
//             [thirdPlayerscoreView removeFromSuperview];
//             [fouthPlayerscoreView removeFromSuperview];
//             [fifthPlayerscoreView removeFromSuperview];
//             [sixthPlayerscoreView removeFromSuperview];
//             [seventhPlayerscoreView removeFromSuperview];
                  thirdPlayerscoreView.hidden=YES;
                  fouthPlayerscoreView.hidden=YES;
                  fifthPlayerscoreView.hidden=YES;
                  sixthPlayerscoreView.hidden=YES;
                  seventhPlayerscoreView.hidden=YES;
                  totalBetamount.hidden=NO;
             
              }];
         
    }];
}
- (void)updateFlopCards
{
    NSTimeInterval delayy = 1.0f;
    
    for (int t = 0; t < 2; ++t)
    {
        
        if ([cumulativeCards count]>0)
        {
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
            cardView.card = [cumulativeCards objectAtIndex:t];
            if(t==0)
                cardView.isFirst=NO;
            else
                cardView.isFirst=YES;
            
            [self.communityView addSubview:cardView];
            [cardView animateFlopCardswithDelay:delayy];
            delayy += 0.1f;
            if(t==1)
            {
                isfirst=YES;
            }
            ;
        }
    }
    [self performSelector:@selector(turnFlopCards) withObject:Nil afterDelay:delayy];
    
}


#pragma mark Updating Turn Cards

-(void)turnTurnCards
{
    
         [UIView animateWithDuration:1.3f delay:1.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
             FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
             seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
         }
                          completion:^(BOOL finished)
          {
              NSLog(@"Animation 5 complete");
              
              Card *card = [cumulativeCards objectAtIndex:flopCradCount];
              card.isTurnedOver=YES;
              CardView *cardView = [self communityCardViewForCard:card];
              
              [cardView animateTurnCardsTurnOverWithsuccess:^()
               {
              if(isfirst ==YES)
              {
                  isfirst=NO;
                  flopCradCount=flopCradCount+1;
                  [self turnTurnCards];
              }
              else
              {
                  flopCradCount=flopCradCount+1;
                  [self performSelector:@selector(showIndicatorForActivePlayer) withObject:Nil afterDelay:1.0];
              }
                   //[totalBetamount removeFromSuperview];
                   //[FirstPlayerscoreView removeFromSuperview];
                   FirstPlayerscoreView.hidden=YES;
                   secondPlayerscoreView.hidden=YES;
                   //             [secondPlayerscoreView removeFromSuperview];
                   //             [thirdPlayerscoreView removeFromSuperview];
                   //             [fouthPlayerscoreView removeFromSuperview];
                   //             [fifthPlayerscoreView removeFromSuperview];
                   //             [sixthPlayerscoreView removeFromSuperview];
                   //             [seventhPlayerscoreView removeFromSuperview];
                   thirdPlayerscoreView.hidden=YES;
                   fouthPlayerscoreView.hidden=YES;
                   fifthPlayerscoreView.hidden=YES;
                   sixthPlayerscoreView.hidden=YES;
                   seventhPlayerscoreView.hidden=YES;
                   totalBetamount.hidden=NO;
          }];
         
         
     }];
}

-(void)updateTurnCard
{
    NSTimeInterval delayy = 1.0f;
    
    for (int t = 2; t < 4; ++t)
    {
        
        if ([cumulativeCards count]>0)
        {
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
            cardView.card = [cumulativeCards objectAtIndex:t];
            if(t==2)
                cardView.isFirst=NO;
            else
                cardView.isFirst=YES;
            [self.communityView addSubview:cardView];
            [cardView animateTurnCardswithDelay:delayy];
            delayy += 0.1f;
            if(t==3)
            {
                isfirst=YES;
            }
            ;
        }
    }
    [self performSelector:@selector(turnTurnCards) withObject:Nil afterDelay:delayy];
}


#pragma mark Turn All Player Cards

-(void)turnsAllPlayersCards
{
    NSLog(@"activePlayerPosition...%u",_activePlayerPosition);
    _activePlayerPosition++;
    NSLog(@"activePlayerPosition...%u",_activePlayerPosition);
    if(_activePlayerPosition>PlayerPositionRTop)
    {
        _activePlayerPosition = PlayerPositionLTop;
        if(isfirst ==NO)
            isfirst=YES;
        [self turnAllCardsForAllPlayers:[self activePlayer]];
    }
    else if (_activePlayerPosition == PlayerPositionMiddle)
    {
        [self turnsAllPlayersCards];
    }
    else
    {
        [self turnAllCardsForAllPlayers:[self activePlayer]];
    }
}
-(void)turnAllCardsForAllPlayers:(Player*)player
{
    NSAssert([player.closedCards cardCount] > 0, @"Player has no more cards");
    
    //_hasTurnedCard = YES;
    
    Card *card = [player turnOverTopCard];
    CardView *cardView = [self cardViewForCard:card];
    if(isfirst ==NO)
        cardView.isFirst=YES;
    else
        cardView.isFirst=NO;
    
    [cardView animateTurningOverForAllPlayer:player success:^()
     {
         
         [self turnsAllPlayersCards];
         
     }];
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
