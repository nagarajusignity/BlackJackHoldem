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
#import "UIImageView+WebCache.h"
#import "WebServiceInterface.h"
#import "SBJSON.h"
#import "NSObject+SBJSON.h"
#import "SelectViewController.h"
#import "NSArray+BestHandsArray.h"

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
    int                  playerId;
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
    
    UIView * fifthPlayerscoreView ;
    
    UIView * sixthPlayerscoreView  ;
    
    UIView * seventhPlayerscoreView ;
    
    UIView * totalBetamount;
    
    AVAudioPlayer *_dealingCardsSound;
    NSOperationQueue         *myQueue;
    BOOL                     isPoped;
    
}
@synthesize fouthbedirBG;
@synthesize progressView;
@synthesize allInAmount;
#pragma mark View Did Load
/**********************************************************
 * Load the view with the required objects
 **********************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self
                                                         withBlock:^(PNMessage *message) {
                                                             NSString * type = [message.message objectForKey: @"type"];
                                                       if([appDelegate().gameStarted isEqualToString:@"No"]){
                                                            if([type isEqualToString:@"Fold"]){
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES)
                                                                 {
                                                                 [self actionForFoldButton:message.message];
                                                                 }
                                                                 else if (Received==NO)
                                                                 {  [self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                 }
                                                             }
                                                          else if([type isEqualToString:@"checkForRoundCompletion"]){
                                                                   [self checkForRoundCompletion];
                                                           }
                                                           
                                                             else if ([type isEqualToString:@"Call"]){
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 
                                                                 if(Received==YES){
                                                                     [self actionForCallButton:message.message];
                                                                 }
                                                                 else if (Received==NO){
                                                                     [self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                     [self exitFromTableInBackGroundMode];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"Check"]) {
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES){
                                                                     [self actionForCheckButton:message.message];
                                                                 }
                                                                 else if (Received==NO){
                                                                     [self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                     [self exitFromTableInBackGroundMode];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"AllIn"]) {
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES){
                                                                     [self actionForAllInButton:message.message];
                                                                 }
                                                                 else if (Received==NO) {  [self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"Bet"]) {
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES)
                                                                 {
                                                                     [self actionForBetButton:message.message];
                                                                 }
                                                                 else if (Received==NO)
                                                                 {[self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"SitOut"])
                                                             {
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES)
                                                                 {
                                                                     [self actionForSitOutButton:message.message];
                                                                 }
                                                                 else if (Received==NO)
                                                                 {[self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"BetPressed"])
                                                             {
                                                                 [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playerIsNotResponding) object:self];
                                                                 if(Received==YES)
                                                                 {
                                                                     [self actionForBetButtonPressed:message.message];
                                                                 }
                                                                 else if (Received==NO)
                                                                 {[self exitFromTableInBackGroundMode];
                                                                     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                     alert.tag=222;
                                                                     [alert show];
                                                                 }
                                                             }
                                                             else if ([type isEqualToString:@"testing"]) {
                                                                 NSString *testString =[NSString stringWithFormat:@"%@",[message.message objectForKey: @"msg"]];
                                                                 UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Testing" message:testString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                                 [alert show];
                                                             }                                                       }
     
                                                         }];
    game =[[Game alloc]init];
    game.delegate=self;
    
    [[PNObservationCenter defaultCenter] addPresenceEventObserver:self withBlock:^(PNPresenceEvent *event) {
        NSString *uuid = [[NSString alloc]init];
        uuid = event.client.identifier;
        // ignore yourself
        if ([uuid isEqualToString:[PubNub clientIdentifier]]) {
            return;
        }
        NSString *eventString;
        if (event.type == PNPresenceEventJoin) {
            eventString = @"Join";
            
        } else if (event.type == PNPresenceEventLeave) {
            eventString = @"Leave";
            
        } else if (event.type == PNPresenceEventTimeout) {
            eventString = @"Timeout";
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Events" message:[NSString stringWithFormat:@"%@ TimeOut",uuid] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            //[alert show];
            PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
            [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
                if(subscriptionError != nil){
                }
                else{
                    NSLog(@"subscriptionError  %@",subscriptionError);
                }
            }];
            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURLResponse *_response;
                NSError* _error = nil;
                NSString *_urlString = [NSString stringWithFormat:BaseUrl];
                NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
                NSString *_params;
                if(gameStarted)
                    _params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=Yes",appDelegate().tableNumber,uuid];
                else
                    _params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=No",appDelegate().tableNumber,uuid];
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
                        [_dealingCardsSound stop];
                    }
                    @catch (NSException *exception) {
                    }
                });
            });
            if([[[appDelegate().clients valueForKey:@"user_id"]objectAtIndex:appDelegate().clients.count-1] isEqualToString:uuid]){
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Dealer lost internet conection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                //alert.tag=222;
                //[alert show];
            }
        }
    }];
    
    first =[[NSMutableArray alloc]init];
    second =[[NSMutableArray alloc]init];
    scoreDict =[[NSMutableDictionary alloc]init];
    scoreArray =[[NSMutableArray alloc]init];
    myOpencards =[[NSMutableArray alloc]init];
    rulesView =[[Rules alloc]init];
    bestHandsArray=[[NSMutableArray alloc]init];
    
    firstEmptyChair =[UIImage imageNamed:@"chair1"];
    secondEmptyChair=[UIImage imageNamed:@"chair2"];
    thirdEmptyChair =[UIImage imageNamed:@"chair3"];
    fourthEmptyChair=[UIImage imageNamed:@"chair4"];
    fifthEmptyChair=[UIImage imageNamed:@"chair5"];
    sixthEmptyChair=[UIImage imageNamed:@"chair6"];
    seventhEmptyChair=[UIImage imageNamed:@"chair7"];
    bedirimage =[UIImage imageNamed:@"bedir"];
    thirdbedirimage =[UIImage imageNamed:@"Secondbedir"];
    fourthbedirimage =[UIImage imageNamed:@"Secondbedir"];
    // [self loadSounds];
    
    /***
     * Background ImageView
     **/
    UIImage *image;
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"EARTH"]){
        if(isiPhone5())
        image =[UIImage imageNamed:@"Earth_iphone5"];
        else
        image =[UIImage imageNamed:@"Earth_iphone4"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"MARS"]){
        if(isiPhone5())
        image =[UIImage imageNamed:@"Mars_iphone5"];
        else
         image =[UIImage imageNamed:@"Mars_iphone4"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"LUNA"]){
        if(isiPhone5())
        image =[UIImage imageNamed:@"Luna_iphone5"];
        else
         image =[UIImage imageNamed:@"Luna_iphone4"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"IOA"]){
        if(isiPhone5())
            image =[UIImage imageNamed:@"IOA_iphone5"];
        else
            image =[UIImage imageNamed:@"IOA_iphone4"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"CERES"]){
        if(isiPhone5())
            image =[UIImage imageNamed:@"Ceres_iphone5"];
        else
            image =[UIImage imageNamed:@"Ceres_iphone4"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Theme"] isEqualToString:@"TITAN"]){
        if(isiPhone5())
            image =[UIImage imageNamed:@"Titan_iphone5"];
        else
            image =[UIImage imageNamed:@"Titan_iphone4"];
    }

    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];
    imageViewBG.frame=CGRectMake(0.0, 0.0,image.size.width , 320);
    imageViewBG.userInteractionEnabled=YES;
    [self.view addSubview:imageViewBG];
    
    
    [self loadImagesViewofPlayers];

    final1 =[[NSMutableArray alloc]init];
    final2 =[[NSMutableArray alloc]init];
    
    firstDict =[[NSMutableDictionary alloc]init];
    secondDict=[[NSMutableDictionary alloc]init];
    
    round=0;
    flopCradCount=0;
    isPoped=NO;
    gameStarted=NO;
    centerLbl = [[UILabel alloc] init];
    centerLbl.frame = CGRectMake(0,170, 480+86*isiPhone5(), 40);
    centerLbl.textAlignment = NSTextAlignmentCenter;
    centerLbl.textColor = [UIColor  greenColor];
    centerLbl.adjustsFontSizeToFitWidth = YES;
    centerLbl.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.0];
    centerLbl.backgroundColor = [UIColor clearColor];
    centerLbl.text=@"Waiting for players";
    
    [self.view addSubview:centerLbl];
    
    
    _communityView =[[UIView alloc]initWithFrame:CGRectMake(176+40*isiPhone5(),140, 140, 36)];
    _communityView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_communityView];
    
    [self addProgressViews];
    
    _cardContainerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 480+88*isiPhone5(), 320)];
    _cardContainerView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_cardContainerView];
    
    [self loadScoreViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFlopCards) name:@"updateFlopCards" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTurnCard) name:@"updateTurnCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRiverCard) name:@"updateRiverCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CheckForWin) name:@"winningConditions" object:nil];
  
    
    [self loadBottomButtons];

    //[self pickRandomStartingPlayer];
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
    callAmount=appDelegate().smallBlindValue;
    Received =NO;
    game.Received=NO;
    if(appDelegate().clients.count>1){
 for(int i=0;i<appDelegate().clients.count;i++){
        if([[[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:i] isEqualToString:[[NSUserDefaults standardUserDefaults ] valueForKey:@"NickName"]]){
            if(([[[appDelegate().clients valueForKey:@"Dealer"] objectAtIndex:i] isEqualToString:@"Yes"])&&([appDelegate().gameStarted isEqualToString:@"No"])){
                [game startServerGameWithSession:appDelegate().tableNumber playerName:[NSString stringWithFormat:@"%@",[[appDelegate().clients valueForKey:@"username"]objectAtIndex:0]] clients:appDelegate().clients];
                dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURLResponse *_response;
                    NSError* _error = nil;
                    NSString *_urlString = [NSString stringWithFormat:BaseUrl];
                    NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
                    NSString *_params;
                    _params = [NSString stringWithFormat:@"operation=update_game_status&table_number=%@",appDelegate().tableNumber];
                    NSData *postData = [_params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
                    NSMutableURLRequest *_req=[[NSMutableURLRequest alloc]initWithURL:_url];
                    [_req setHTTPMethod:@"POST"];
                    [_req setValue:postLength forHTTPHeaderField:@"Content-Length"];
                    [_req setHTTPBody:postData];
                    NSData *_data=[NSURLConnection sendSynchronousRequest:_req returningResponse:&_response error:&_error];
                    dispatch_async( dispatch_get_main_queue(), ^{
                        @try {
                        }
                        @catch (NSException *exception) {}});});}}}}
    if([appDelegate().gameStarted isEqualToString:@"Yes"]){
        centerLbl.text=@"Please wait for your turn";
        [self checkForGameStatus];
    }
    [self loadWelcomeSound];
    
    UIButton *volumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [volumeButton addTarget:self
                     action:@selector(volumeButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    volumeButton.backgroundColor =[UIColor clearColor];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
        volumeButton.selected=NO;
        [volumeButton setImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
    }
    else{volumeButton.selected=YES;
        [volumeButton setImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];}
    volumeButton.frame = CGRectMake(2, 320-106,34, 34);
    [self.view addSubview:volumeButton];
    
    UIButton *spotLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [spotLightButton addTarget:self
                        action:@selector(spotLightButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    spotLightButton.backgroundColor =[UIColor clearColor];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"]){
        spotLightButton.selected=NO;
        [spotLightButton setImage:[UIImage imageNamed:@"spot_light_active"] forState:UIControlStateNormal];
    }
    else{spotLightButton.selected=YES;
        [spotLightButton setImage:[UIImage imageNamed:@"spot_light_inactive"] forState:UIControlStateNormal];}
    spotLightButton.frame = CGRectMake(2, 320-70,34, 34);
    [self.view addSubview:spotLightButton];
    UIButton *bhButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bhButton addTarget:self
                 action:@selector(bhButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    bhButton.backgroundColor =[UIColor clearColor];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"BHands"]){
        bhButton.selected=NO;
        bestHandsView.hidden=NO;
        [bhButton setImage:[UIImage imageNamed:@"best_hand_active"] forState:UIControlStateNormal];
    }
    else{bhButton.selected=YES;
        bestHandsView.hidden=YES;
        bestHandsScoreLbl.hidden=YES;
        [bhButton setImage:[UIImage imageNamed:@"best_hand_Inactive"] forState:UIControlStateNormal];}
    bhButton.frame = CGRectMake(38, 320-70,34, 34);
    [self.view addSubview:bhButton];
}
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationIsActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationEnterdInBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [self addPubNubClientObservers];

}
#pragma mark Volume Button Action
-(void)volumeButtonPressed:(UIButton*)sender{
    if(sender.selected==YES){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Music"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sender.selected=NO;
        [sender setImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Music"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sender.selected=YES;
        [sender setImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];
    }
}
-(void)spotLightButtonPressed:(UIButton*)sender{
    if(sender.selected==YES){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Spotlight"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sender.selected=NO;
        [sender setImage:[UIImage imageNamed:@"spot_light_active"] forState:UIControlStateNormal];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Spotlight"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sender.selected=YES;
        [sender setImage:[UIImage imageNamed:@"spot_light_inactive"] forState:UIControlStateNormal];
    }
}
-(void)bhButtonPressed:(UIButton*)sender{
    if(sender.selected==YES){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"BHands"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        bestHandsView.hidden=NO;
        if(round>0)
        bestHandsScoreLbl.hidden=NO;
        sender.selected=NO;
        [sender setImage:[UIImage imageNamed:@"best_hand_active"] forState:UIControlStateNormal];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BHands"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        sender.selected=YES;bestHandsView.hidden=YES;bestHandsScoreLbl.hidden=YES;
        [sender setImage:[UIImage imageNamed:@"best_hand_Inactive"] forState:UIControlStateNormal];
    }
}

#pragma mark Observer to check Internet connection

- (void)addPubNubClientObservers{
    [[PNObservationCenter defaultCenter] addClientConnectionStateObserver:self withCallbackBlock:^(NSString *origin, BOOL connected,  PNError *error) {
        if (!connected && error) {
            [self exitFromTableInBackGroundMode];
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You lost your internet connection pubnub." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.tag=222;
            [alert show];
           
        }
        else
        {
        }
    }];
}
-(void)viewDidDisappear:(BOOL)animated{
    [_dealingCardsSound stop];
}

#pragma mark Check For Game Status

-(void)checkForGameStatus
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *_response;
        NSError* _error = nil;
        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
        NSString *_params;
        _params = [NSString stringWithFormat:@"operation=increase_new_user_count&table_number=%@",appDelegate().tableNumber];
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
                if([[_responsedict valueForKey:@"success"]integerValue]==1){
                    [self getUpdatedTableInformationForNewPlayer];
                }
                else{
                }
            }
            @catch (NSException *exception) {
                
            }
        });
    });
}

#pragma mark Get Updated Tabel Information For New Player

-(void)getUpdatedTableInformationForNewPlayer
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *_response;
        NSError* _error = nil;
        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
        NSString *_params;
        _params = [NSString stringWithFormat:@"operation=table_information&table_number=%@",appDelegate().tableNumber];
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
                    appDelegate().gameStarted=[NSString stringWithFormat:@"%@",[_responsedict valueForKey:@"game_status"]];
                   if([[_responsedict valueForKey:@"game_status"] isEqualToString:@"Yes"]){
                       [self getUpdatedTableInformationForNewPlayer];
                   }
                    else if([[_responsedict valueForKey:@"game_status"] isEqualToString:@"No"]){
                       [self jsonUpdatedTableDataResponse:_responsedict];
                    }
            }
            @catch (NSException *exception) {
            }
        });
    });
}
#pragma mark  Appplication Did Become Active

-(void)appplicationIsActive:(NSNotification *)notification
{
    PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
    [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
        if(subscriptionError != nil){
        }
        else{
        }
    }];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You are very slow to respond,please play a new game" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.tag=444;
    [alert show];
}

#pragma mark Appplication Did Enter Background

-(void)appplicationEnterdInBackground:(NSNotification*)notification{
    [self exitFromTableInBackGroundMode];
}
-(void)exitFromTableInBackGroundMode{
    PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
    [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
        if(subscriptionError != nil){
        }
        else{
        }
    }];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *_response;
        NSError* _error = nil;
        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
        NSString *_params;
        if(gameStarted)
            _params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=Yes",appDelegate().tableNumber,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
        else
            _params = [NSString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=No",appDelegate().tableNumber,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
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
                [_dealingCardsSound stop];
            }
            @catch (NSException *exception) {
            }
        });
    });
}
#pragma mark Load ImagesViews of Players

/**********************************************************
 * Load ImagesViews of Players
 **********************************************************/

-(void)hideAllImageViewOfallPlayers{
    if(ActiveAtPositionLTop==YES){
        firstbedirBG.hidden=NO;
        firstbedirBG.alpha=1.0;
        firstbedirBG.frame=CGRectMake(310.0+65*isiPhone5(), 15.0,bedirimage.size.width , bedirimage.size.height);
        firstProfileImageBG.hidden=NO;
        firstbedirBG.image=bedirimage;
    }
    else{
        firstbedirBG.hidden=NO;
        }
    if(ActiveAtPositionLMiddle==YES){
        secondbedirBG.hidden=NO;
        secondbedirBG.alpha=1.0;
        secondbedirBG.frame=CGRectMake(410+90*isiPhone5(), 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
        secondProfileImageBG.hidden=NO;
        secondbedirBG.image=bedirimage;
    }
    else{
        secondbedirBG.hidden=NO;
    }
    if(ActiveAtPositionLBottom==YES){
        thirdbedirBG.hidden=NO;
        thirdbedirBG.alpha=1.0;
        thirdbedirBG.frame=CGRectMake(310.0+75*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
        thirdProfileImageBG.hidden=NO;
        thirdbedirBG.image=thirdbedirimage;
    }
    else{
        thirdbedirBG.hidden=NO;
    }
    if(ActiveAtPositionMiddle==YES){
        fouthbedirBG.hidden=NO;
        fouthbedirBG.alpha=1.0;
        fouthbedirBG.frame=CGRectMake(200.0+45*isiPhone5(), 210,fourthbedirimage.size.width , fourthbedirimage.size.height);
        fourthProfileImageBG.hidden=NO;
        fouthbedirBG.image=fourthbedirimage;
    }
    else{
        fouthbedirBG.hidden=NO;
    }
    if(ActiveAtPositionRBottom==YES){
        fifthbedirBG.hidden=NO;
        fifthbedirBG.alpha=1.0;
        fifthbedirBG.frame=CGRectMake(90.0+15*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
        fifthProfileImageBG.hidden=NO;
        fifthbedirBG.image=thirdbedirimage;
    }
    else{
        fifthbedirBG.hidden=NO;
    }
    if(ActiveAtPositionRMiddle==YES){
        sixthbedirBG.hidden=NO;
        sixthbedirBG.alpha=1.0;
        sixthbedirBG.frame=CGRectMake(10.0, 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
        sixthbedirBG.image=bedirimage;
        sixthProfileImageBG.hidden=NO;
    }
    else{
        sixthbedirBG.hidden=NO;
    }
    if(ActiveAtPositionRTop==YES){
        seventhbedirBG.hidden=NO;
        seventhbedirBG.frame=CGRectMake(108+25*isiPhone5(), 15,bedirimage.size.width , bedirimage.size.height);
        seventhProfileImageBG.hidden=NO;
        seventhbedirBG.image=bedirimage;
    }
    else{
        seventhbedirBG.hidden=NO;
    }
}
-(void)loadImagesViewofPlayers
{
    DealerLabel =[[UILabel alloc]init];
    DealerLabel.backgroundColor =[UIColor blackColor];
    DealerLabel.text=@"D";
    DealerLabel.layer.masksToBounds = YES;
    DealerLabel.layer.cornerRadius=7.5;
    DealerLabel.layer.borderWidth=1;
    DealerLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
    DealerLabel.textColor =[UIColor whiteColor];
    DealerLabel.textAlignment=NSTextAlignmentCenter;
    DealerLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    DealerLabel.hidden=YES;
    [self.view addSubview:DealerLabel];
    
    smallBlindLabel =[[UILabel alloc]init];
    smallBlindLabel.backgroundColor =[UIColor blackColor];
    smallBlindLabel.text=@"S";
    smallBlindLabel.layer.masksToBounds = YES;
    smallBlindLabel.layer.cornerRadius=7.5;
    smallBlindLabel.layer.borderWidth=1;
    smallBlindLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
    smallBlindLabel.textColor =[UIColor whiteColor];
    smallBlindLabel.textAlignment=NSTextAlignmentCenter;
    smallBlindLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    smallBlindLabel.hidden=YES;
    [self.view addSubview:smallBlindLabel];
    
    bigBlindLabel =[[UILabel alloc]init];
    bigBlindLabel.backgroundColor =[UIColor blackColor];
    bigBlindLabel.text=@"B";
    bigBlindLabel.layer.masksToBounds = YES;
    bigBlindLabel.layer.cornerRadius=7.5;
    bigBlindLabel.layer.borderWidth=1;
    bigBlindLabel.layer.borderColor=[[UIColor whiteColor] CGColor];
    bigBlindLabel.textColor =[UIColor whiteColor];
    bigBlindLabel.textAlignment=NSTextAlignmentCenter;
    bigBlindLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    bigBlindLabel.hidden=YES;
    [self.view addSubview:bigBlindLabel];
    
    bestHandsScoreLbl =[[UILabel alloc]init];
    bestHandsScoreLbl.backgroundColor =[UIColor blackColor];
    bestHandsScoreLbl.text=@"31";
    bestHandsScoreLbl.layer.masksToBounds = YES;
    bestHandsScoreLbl.layer.cornerRadius=7.5;
    bestHandsScoreLbl.layer.borderWidth=1;
    bestHandsScoreLbl.layer.borderColor=[[UIColor whiteColor] CGColor];
    bestHandsScoreLbl.textColor =[UIColor whiteColor];
    bestHandsScoreLbl.textAlignment=NSTextAlignmentCenter;
    bestHandsScoreLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:10];
    bestHandsScoreLbl.hidden=YES;
    bestHandsScoreLbl.frame =CGRectMake(440+88*isiPhone5(),235, 15, 15);
    [self.view addSubview:bestHandsScoreLbl];
    
    /***
     * bedir ImageView
     **/
    
    firstbedirBG=[[UIImageView alloc]initWithImage:firstEmptyChair];
    firstbedirBG.frame=CGRectMake(310.0+65*isiPhone5(), 58.0+0*isiPhone5(),firstEmptyChair.size.width , firstEmptyChair.size.height);
    [self.view addSubview:firstbedirBG];
    
    UIImage *firstProfileImage =[UIImage imageNamed:@"playes1"];
    firstProfileImageBG=[[UIImageView alloc]initWithImage:firstProfileImage];
    firstProfileImageBG.frame=CGRectMake(4, 4,firstProfileImage.size.width-7 , firstProfileImage.size.height-6);
    firstProfileImageBG.layer.masksToBounds = YES;
    firstProfileImageBG.layer.cornerRadius=27;
    [firstbedirBG addSubview:firstProfileImageBG];
    
    /***
     * FIrst Name Label
     **/
    firstPlayerName = [[UILabel alloc] init];
    firstPlayerName.frame = CGRectMake(12, 60,36, 15);
    firstPlayerName.textAlignment = NSTextAlignmentCenter;
    firstPlayerName.textColor = [UIColor  whiteColor];
    firstPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstPlayerName.backgroundColor = [UIColor clearColor];
    firstPlayerName.adjustsFontSizeToFitWidth = YES;
    firstPlayerName.text=@"";
    [firstbedirBG addSubview:firstPlayerName];
    
    /***
     * FIrst Player Score Label
     **/
    firstPlayerScore = [[UILabel alloc] init];
    firstPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    firstPlayerScore.textAlignment = NSTextAlignmentCenter;
    firstPlayerScore.textColor = [UIColor  whiteColor];
    firstPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstPlayerScore.backgroundColor = [UIColor clearColor];
    firstPlayerScore.adjustsFontSizeToFitWidth = YES;
    firstPlayerScore.text=@"";
    [firstbedirBG addSubview:firstPlayerScore];
    firstProfileImageBG.hidden=YES;
    
    secondbedirBG=[[UIImageView alloc]initWithImage:secondEmptyChair];
    secondbedirBG.frame=CGRectMake(414+73*isiPhone5(), 95+3*isiPhone5(),secondEmptyChair.size.width , secondEmptyChair.size.height);
    [self.view addSubview:secondbedirBG];
    
    UIImage *secondProfileImage =[UIImage imageNamed:@"playes2"];
    secondProfileImageBG=[[UIImageView alloc]initWithImage:secondProfileImage];
    secondProfileImageBG.frame=CGRectMake(4, 4,secondProfileImage.size.width-7 , secondProfileImage.size.height-6);
    secondProfileImageBG.layer.masksToBounds = YES;
    secondProfileImageBG.layer.cornerRadius=27;
    [secondbedirBG addSubview:secondProfileImageBG];
    
    /***
     * Second Player Name Label
     **/
    secondPlayerName = [[UILabel alloc] init];
    secondPlayerName.frame = CGRectMake(12, 60,36 , 15);
    secondPlayerName.textAlignment = NSTextAlignmentCenter;
    secondPlayerName.textColor = [UIColor  whiteColor];
    secondPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondPlayerName.backgroundColor = [UIColor clearColor];
    secondPlayerName.adjustsFontSizeToFitWidth = YES;
    [secondbedirBG addSubview:secondPlayerName];
    
    /***
     * Second Player Score Label
     **/
    secondPlayerScore = [[UILabel alloc] init];
    secondPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    secondPlayerScore.textAlignment = NSTextAlignmentCenter;
    secondPlayerScore.textColor = [UIColor  whiteColor];
    secondPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondPlayerScore.backgroundColor = [UIColor clearColor];
    secondPlayerScore.adjustsFontSizeToFitWidth = YES;
    [secondbedirBG addSubview:secondPlayerScore];
    secondProfileImageBG.hidden=YES;
    
    thirdbedirBG=[[UIImageView alloc]initWithImage:thirdEmptyChair];
    thirdbedirBG.frame=CGRectMake(310.0+75*isiPhone5(), 190,thirdEmptyChair.size.width , thirdEmptyChair.size.height);
    [self.view addSubview:thirdbedirBG];
    
    UIImage *thirdProfileImage =[UIImage imageNamed:@"playes3"];
    thirdProfileImageBG=[[UIImageView alloc]initWithImage:thirdProfileImage];
    thirdProfileImageBG.frame=CGRectMake(15, 4,thirdProfileImage.size.width-8 , thirdProfileImage.size.height-6);
    thirdProfileImageBG.layer.masksToBounds = YES;
    thirdProfileImageBG.layer.cornerRadius=27;
    [thirdbedirBG addSubview:thirdProfileImageBG];
    
    /***
     * Third Player Name Label
     **/
    thirdPlayerName = [[UILabel alloc] init];
    thirdPlayerName.frame = CGRectMake(5, 55,70 , 15);
    thirdPlayerName.textAlignment = NSTextAlignmentCenter;
    thirdPlayerName.textColor = [UIColor  whiteColor];
    thirdPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    thirdPlayerName.backgroundColor = [UIColor clearColor];
    thirdPlayerName.adjustsFontSizeToFitWidth = YES;
    [thirdbedirBG addSubview:thirdPlayerName];
    thirdProfileImageBG.hidden=YES;
    
    fouthbedirBG=[[UIImageView alloc]initWithImage:thirdbedirimage];
    fouthbedirBG.frame=CGRectMake(200.0+45*isiPhone5(), 210,fourthbedirimage.size.width , fourthbedirimage.size.height);
    [self.view addSubview:fouthbedirBG];
    /***
     * Fourth Player Name Label
     **/
    
    fourthPlayerName = [[UILabel alloc] init];
    fourthPlayerName.frame = CGRectMake(5, 55,70 , 15);
    fourthPlayerName.textAlignment = NSTextAlignmentCenter;
    fourthPlayerName.textColor = [UIColor  whiteColor];
    fourthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fourthPlayerName.backgroundColor = [UIColor clearColor];
    fourthPlayerName.adjustsFontSizeToFitWidth = YES;
    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"],[[NSUserDefaults standardUserDefaults] valueForKey:@"temp_score"]];
    [fouthbedirBG addSubview:fourthPlayerName];
    
    UIImage *fourthProfileImage =[UIImage imageNamed:@"playes3"];
    fourthProfileImageBG=[[UIImageView alloc]initWithImage:fourthProfileImage];
    fourthProfileImageBG.frame=CGRectMake(15, 4,fourthProfileImage.size.width-8 , fourthProfileImage.size.height-6);
    fourthProfileImageBG.layer.masksToBounds = YES;
    fourthProfileImageBG.layer.cornerRadius=27;
     [fourthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,[[NSUserDefaults standardUserDefaults] valueForKey:@"UserImage"]]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
    [fouthbedirBG addSubview:fourthProfileImageBG];
    
    fifthbedirBG=[[UIImageView alloc]initWithImage:fifthEmptyChair];
    fifthbedirBG.frame=CGRectMake(90.0+15*isiPhone5(), 190,fifthEmptyChair.size.width , fifthEmptyChair.size.height);
    [self.view addSubview:fifthbedirBG];
    
    UIImage *fifthProfileImage =[UIImage imageNamed:@"playes4"];
    fifthProfileImageBG=[[UIImageView alloc]initWithImage:fifthProfileImage];
    fifthProfileImageBG.frame=CGRectMake(15, 4,fifthProfileImage.size.width-8 , fifthProfileImage.size.height-6);
    fifthProfileImageBG.layer.masksToBounds = YES;
    fifthProfileImageBG.layer.cornerRadius=27;
    [fifthbedirBG addSubview:fifthProfileImageBG];
    /***
     * Fifth Player Name Label
     **/
    fifthPlayerName = [[UILabel alloc] init];
    fifthPlayerName.frame = CGRectMake(5, 55,70 , 15);
    fifthPlayerName.textAlignment = NSTextAlignmentCenter;
    fifthPlayerName.textColor = [UIColor  whiteColor];
    fifthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fifthPlayerName.backgroundColor = [UIColor clearColor];
    fifthPlayerName.adjustsFontSizeToFitWidth = YES;
    [fifthbedirBG addSubview:fifthPlayerName];
    fifthProfileImageBG.hidden=YES;
    
    sixthbedirBG=[[UIImageView alloc]initWithImage:sixthEmptyChair];
    sixthbedirBG.frame=CGRectMake(-2+14.0*isiPhone5(), 95+3*isiPhone5(),sixthEmptyChair.size.width , sixthEmptyChair.size.height);
    [self.view addSubview:sixthbedirBG];
    
    UIImage *sixthProfileImage =[UIImage imageNamed:@"playes5"];
    sixthProfileImageBG=[[UIImageView alloc]initWithImage:sixthProfileImage];
    sixthProfileImageBG.frame=CGRectMake(4, 4,sixthProfileImage.size.width-7 , sixthProfileImage.size.height-6);
    sixthProfileImageBG.layer.masksToBounds = YES;
    sixthProfileImageBG.layer.cornerRadius=27;
    [sixthbedirBG addSubview:sixthProfileImageBG];
    
    /***
     * Sixth Player Name Label
     **/
    sixthPlayerName = [[UILabel alloc] init];
    sixthPlayerName.frame = CGRectMake(12, 60,36 , 15);
    sixthPlayerName.textAlignment = NSTextAlignmentCenter;
    sixthPlayerName.textColor = [UIColor  whiteColor];
    sixthPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthPlayerName.backgroundColor = [UIColor clearColor];
    sixthPlayerName.adjustsFontSizeToFitWidth = YES;
    [sixthbedirBG addSubview:sixthPlayerName];
    /***
     * Sixth Player Score Label
     **/
    sixthPlayerScore = [[UILabel alloc] init];
    sixthPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    sixthPlayerScore.textAlignment = NSTextAlignmentCenter;
    sixthPlayerScore.textColor = [UIColor  whiteColor];
    sixthPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthPlayerScore.backgroundColor = [UIColor clearColor];
    sixthPlayerScore.adjustsFontSizeToFitWidth = YES;
    [sixthbedirBG addSubview:sixthPlayerScore];
    
    sixthProfileImageBG.hidden=YES;
    
    seventhbedirBG=[[UIImageView alloc]initWithImage:seventhEmptyChair];
    seventhbedirBG.frame=CGRectMake(108+25*isiPhone5(), 59.5-1.5*isiPhone5(),seventhEmptyChair.size.width , seventhEmptyChair.size.height);
    [self.view addSubview:seventhbedirBG];
    
    UIImage *seventhProfileImage =[UIImage imageNamed:@"playes6"];
    seventhProfileImageBG=[[UIImageView alloc]initWithImage:seventhProfileImage];
    seventhProfileImageBG.frame=CGRectMake(4, 4,seventhProfileImage.size.width-7 , seventhProfileImage.size.height-6);
    seventhProfileImageBG.layer.masksToBounds = YES;
    seventhProfileImageBG.layer.cornerRadius=27;
    [seventhbedirBG addSubview:seventhProfileImageBG];
    
    /***
     * Seventh Player Name Label
     **/
    seventhPlayerName = [[UILabel alloc] init];
    seventhPlayerName.frame = CGRectMake(12, 60,36 , 15);
    seventhPlayerName.textAlignment = NSTextAlignmentCenter;
    seventhPlayerName.textColor = [UIColor  whiteColor];
    seventhPlayerName.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhPlayerName.backgroundColor = [UIColor clearColor];
    seventhPlayerName.adjustsFontSizeToFitWidth = YES;
    [seventhbedirBG addSubview:seventhPlayerName];
    
    /***
     * Second Player Score Label
     **/
    seventhPlayerScore = [[UILabel alloc] init];
    seventhPlayerScore.frame = CGRectMake(10, 72,40 , 15);
    seventhPlayerScore.textAlignment = NSTextAlignmentCenter;
    seventhPlayerScore.textColor = [UIColor  whiteColor];
    seventhPlayerScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhPlayerScore.backgroundColor = [UIColor clearColor];
    seventhPlayerScore.adjustsFontSizeToFitWidth = YES;
    [seventhbedirBG addSubview:seventhPlayerScore];
    seventhProfileImageBG.hidden=YES;
    
    firtPlayerstatusLabel = [[UILabel alloc] init];
    firtPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    firtPlayerstatusLabel.textColor = [UIColor  yellowColor];
    firtPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firtPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    firtPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //firtPlayerstatusLabel.text=@"Check";
    firtPlayerstatusLabel.frame=CGRectMake(320.0+65*isiPhone5(), 1.0+2*isiPhone5(), 40, 15);
    [self.view addSubview:firtPlayerstatusLabel];
    
    secondPlayerstatusLabel = [[UILabel alloc] init];
    secondPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    secondPlayerstatusLabel.textColor = [UIColor  yellowColor];
    secondPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    secondPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //secondPlayerstatusLabel.text=@"Check";
    secondPlayerstatusLabel.frame=CGRectMake(419+88*isiPhone5(), 70-3*isiPhone5(), 40, 15);
    [self.view addSubview:secondPlayerstatusLabel];
    
    thirdPlayerstatusLabel = [[UILabel alloc] init];
    thirdPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    thirdPlayerstatusLabel.textColor = [UIColor  yellowColor];
    thirdPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    thirdPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    thirdPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //thirdPlayerstatusLabel.text=@"Check";
    thirdPlayerstatusLabel.frame=CGRectMake(330.0+75*isiPhone5(), 197, 40, 15);
    [self.view addSubview:thirdPlayerstatusLabel];
    
    fourthPlayerstatusLabel = [[UILabel alloc] init];
    fourthPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    fourthPlayerstatusLabel.textColor = [UIColor  yellowColor];
    fourthPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fourthPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    fourthPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //fourthPlayerstatusLabel.text=@"Check";
    fourthPlayerstatusLabel.frame=CGRectMake(220.0+45*isiPhone5(), 198,40, 15);
    [self.view addSubview:fourthPlayerstatusLabel];
    
    fifthPlayerstatusLabel = [[UILabel alloc] init];
    fifthPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    fifthPlayerstatusLabel.textColor = [UIColor  yellowColor];
    fifthPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fifthPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    fifthPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //fifthPlayerstatusLabel.text=@"Check";
    fifthPlayerstatusLabel.frame=CGRectMake(110.0+15*isiPhone5(), 197,40, 15);
    [self.view addSubview:fifthPlayerstatusLabel];
    
    sixthPlayerstatusLabel = [[UILabel alloc] init];
    sixthPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    sixthPlayerstatusLabel.textColor = [UIColor  yellowColor];
    sixthPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    sixthPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //sixthPlayerstatusLabel.text=@"Check";
    sixthPlayerstatusLabel.frame=CGRectMake(23-9*isiPhone5(), 70-3*isiPhone5(), 40, 15);//(23-11*isiPhone5(), 70+3*isiPhone5(), 40, 15)
    [self.view addSubview:sixthPlayerstatusLabel];
    
    seventhPlayerstatusLabel = [[UILabel alloc] init];
    seventhPlayerstatusLabel.textAlignment = NSTextAlignmentCenter;
    seventhPlayerstatusLabel.textColor = [UIColor  yellowColor];
    seventhPlayerstatusLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhPlayerstatusLabel.backgroundColor = [UIColor clearColor];
    seventhPlayerstatusLabel.adjustsFontSizeToFitWidth = YES;
    //seventhPlayerstatusLabel.text=@"Check";
    seventhPlayerstatusLabel.frame=CGRectMake(118+25*isiPhone5(), 1, 40, 15);
    [self.view addSubview:seventhPlayerstatusLabel];

    shineImage=[[UIImageView alloc]initWithImage:seventhEmptyChair];
    shineImage.image=[UIImage imageNamed:@"Shine.png"];
    shineImage.frame=CGRectMake(190.0+45*isiPhone5(), 210,100,100);
    [self.view addSubview:shineImage];
    shineImage.hidden=YES;
}

-(void)removeImagesViewsOfthePlayers
{
    [bestHandsScoreLbl removeFromSuperview];
    [DealerLabel removeFromSuperview];
    [smallBlindLabel removeFromSuperview];
    [bigBlindLabel removeFromSuperview];
    [firstbedirBG removeFromSuperview];
    [firstPlayerScore removeFromSuperview];
    [secondbedirBG removeFromSuperview];
    [secondPlayerScore removeFromSuperview];
    [thirdbedirBG removeFromSuperview];
    [fouthbedirBG removeFromSuperview];
    [fourthProfileImageBG removeFromSuperview];
    [fifthbedirBG removeFromSuperview];
    [sixthbedirBG removeFromSuperview];
    [seventhbedirBG removeFromSuperview];
    [firtPlayerstatusLabel removeFromSuperview];
    [secondPlayerstatusLabel removeFromSuperview];
    [thirdPlayerstatusLabel removeFromSuperview];
    [fourthPlayerstatusLabel removeFromSuperview];
    [fifthPlayerstatusLabel removeFromSuperview];
    [sixthPlayerstatusLabel removeFromSuperview];
    [seventhPlayerstatusLabel removeFromSuperview];
    
}
#pragma mark Score Views for all players

/**********************************************************
 * Loads the views which consists of score and name
 **********************************************************/

-(void)loadScoreViews
{
    FirstPlayerscoreView =[[UIView alloc]init];
    FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
    FirstPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:FirstPlayerscoreView];
    
    UIImage *firstChipImage =[UIImage imageNamed:@"chip-red"];
    UIImageView *firstChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    firstChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [FirstPlayerscoreView addSubview:firstChipImageView];
    
    firstScoreLabel = [[UICountingLabel alloc] init];
    firstScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    firstScoreLabel.textAlignment = NSTextAlignmentCenter;
    firstScoreLabel.textColor = [UIColor  whiteColor];
    firstScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    firstScoreLabel.backgroundColor = [UIColor blackColor];
    firstScoreLabel.layer.cornerRadius=5;
    firstScoreLabel.clipsToBounds = YES;
    firstScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    firstScoreLabel.text=@"";
    [FirstPlayerscoreView addSubview:firstScoreLabel];
    
    FirstPlayerscoreView.hidden=YES;
    
    secondPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(375+70*isiPhone5(), 147, 40, 30)];
    secondPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:secondPlayerscoreView];
    
    UIImageView *secondChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    secondChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [secondPlayerscoreView addSubview:secondChipImageView];
    
    secondScoreLabel = [[UICountingLabel alloc] init];
    secondScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    secondScoreLabel.textAlignment = NSTextAlignmentCenter;
    secondScoreLabel.textColor = [UIColor  whiteColor];
    secondScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    secondScoreLabel.backgroundColor = [UIColor blackColor];
    secondScoreLabel.layer.cornerRadius=5;
    secondScoreLabel.clipsToBounds = YES;
    secondScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    secondScoreLabel.text=@"";
    [secondPlayerscoreView addSubview:secondScoreLabel];
    
    secondPlayerscoreView.hidden=YES;
    
    thirdPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(320+75*isiPhone5(), 175, 40, 30)];
    thirdPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:thirdPlayerscoreView];
    
    UIImageView *thirdChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    thirdChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [thirdPlayerscoreView addSubview:thirdChipImageView];
    
    thirdScoreLabel = [[UICountingLabel alloc] init];
    thirdScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    thirdScoreLabel.textAlignment = NSTextAlignmentCenter;
    thirdScoreLabel.textColor = [UIColor  whiteColor];
    thirdScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    thirdScoreLabel.backgroundColor = [UIColor blackColor];
    thirdScoreLabel.layer.cornerRadius=5;
    thirdScoreLabel.clipsToBounds = YES;
    thirdScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    thirdScoreLabel.text=@"";
    [thirdPlayerscoreView addSubview:thirdScoreLabel];
    
    thirdPlayerscoreView.hidden=YES;
    
    fouthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(220+45*isiPhone5(), 180, 40, 30)];
    fouthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:fouthPlayerscoreView];
    
    UIImageView *fourthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    fourthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [fouthPlayerscoreView addSubview:fourthChipImageView];
    
    fourthScoreLabel = [[UICountingLabel alloc] init];
    fourthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    fourthScoreLabel.textAlignment = NSTextAlignmentCenter;
    fourthScoreLabel.textColor = [UIColor  whiteColor];
    fourthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fourthScoreLabel.backgroundColor = [UIColor blackColor];
    fourthScoreLabel.layer.cornerRadius=5;
    fourthScoreLabel.clipsToBounds = YES;
    fourthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    fourthScoreLabel.text=@"";
    [fouthPlayerscoreView addSubview:fourthScoreLabel];
    
    fouthPlayerscoreView.hidden=YES;
    
    fifthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(115+20*isiPhone5(), 175, 40, 30)];
    fifthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:fifthPlayerscoreView];
    
    UIImageView *fifthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    fifthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [fifthPlayerscoreView addSubview:fifthChipImageView];
    
    fifthScoreLabel = [[UICountingLabel alloc] init];
    fifthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    fifthScoreLabel.textAlignment = NSTextAlignmentCenter;
    fifthScoreLabel.textColor = [UIColor  whiteColor];
    fifthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    fifthScoreLabel.backgroundColor = [UIColor blackColor];
    fifthScoreLabel.layer.cornerRadius=5;
    fifthScoreLabel.clipsToBounds = YES;
    fifthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    fifthScoreLabel.text=@"";
    [fifthPlayerscoreView addSubview:fifthScoreLabel];
    
    fifthPlayerscoreView.hidden=YES;
    
    sixthPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(65+20*isiPhone5(), 140, 40, 30)];
    sixthPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:sixthPlayerscoreView];
    
    UIImageView *sixthChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    sixthChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [sixthPlayerscoreView addSubview:sixthChipImageView];
    
    sixthScoreLabel = [[UICountingLabel alloc] init];
    sixthScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    sixthScoreLabel.textAlignment = NSTextAlignmentCenter;
    sixthScoreLabel.textColor = [UIColor  whiteColor];
    sixthScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    sixthScoreLabel.backgroundColor = [UIColor blackColor];
    sixthScoreLabel.layer.cornerRadius=5;
    sixthScoreLabel.clipsToBounds = YES;
    sixthScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    sixthScoreLabel.text=@"";
    [sixthPlayerscoreView addSubview:sixthScoreLabel];
    
    sixthPlayerscoreView.hidden=YES;
    
    seventhPlayerscoreView =[[UIView alloc]initWithFrame:CGRectMake(125+20*isiPhone5(), 115, 40, 30)];
    seventhPlayerscoreView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:seventhPlayerscoreView];
    
    UIImageView *seventhChipImageView=[[UIImageView alloc]initWithImage:firstChipImage];
    seventhChipImageView.frame=CGRectMake(13, 5,firstChipImage.size.width , firstChipImage.size.height);
    [seventhPlayerscoreView addSubview:seventhChipImageView];
    
    seventhScoreLabel = [[UILabel alloc] init];
    seventhScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    seventhScoreLabel.textAlignment = NSTextAlignmentCenter;
    seventhScoreLabel.textColor = [UIColor  whiteColor];
    seventhScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    seventhScoreLabel.backgroundColor = [UIColor blackColor];
    seventhScoreLabel.layer.cornerRadius=5;
    seventhScoreLabel.clipsToBounds = YES;
    seventhScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    seventhScoreLabel.text=@"";
    [seventhPlayerscoreView addSubview:seventhScoreLabel];
    
    seventhPlayerscoreView.hidden=YES;
    
    totalBetamount =[[UIView alloc]initWithFrame:CGRectMake(220+45*isiPhone5(), 110, 40, 30)];
    totalBetamount.backgroundColor=[UIColor clearColor];
    [self.view addSubview:totalBetamount];
    
    UIImage *totalChipsimage =[UIImage imageNamed:@"chip-red"];
    UIImageView *totalChipImageView=[[UIImageView alloc]initWithImage:totalChipsimage];
    totalChipImageView.frame=CGRectMake(13, 5,totalChipsimage.size.width , totalChipsimage.size.height);
    [totalBetamount addSubview:totalChipImageView];
    
    totalScoreLabel = [[UICountingLabel alloc] init];
    totalScoreLabel.frame = CGRectMake(0, 13,40 , 15);
    totalScoreLabel.textAlignment = NSTextAlignmentCenter;
    totalScoreLabel.textColor = [UIColor  whiteColor];
    totalScoreLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:12];
    totalScoreLabel.backgroundColor = [UIColor blackColor];
    totalScoreLabel.layer.cornerRadius=5;
    totalScoreLabel.clipsToBounds = YES;
    totalScoreLabel.backgroundColor = [UIColor colorWithRed:0.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.5];
    totalScoreLabel.text=@"";
    [totalBetamount addSubview:totalScoreLabel];
    
    totalBetamount.hidden=YES;
}
-(void)removeScoreViews
{
    [totalBetamount removeFromSuperview];
    [FirstPlayerscoreView removeFromSuperview];
    [secondPlayerscoreView removeFromSuperview];
    [thirdPlayerscoreView removeFromSuperview];
    [fouthPlayerscoreView removeFromSuperview];
    [fifthPlayerscoreView removeFromSuperview];
    [sixthPlayerscoreView removeFromSuperview];
    [seventhPlayerscoreView removeFromSuperview];
}

#pragma mark Load Bottom Buttons

-(void)loadBottomButtons
{
    /***
     * Check Button
     **/
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton addTarget:self
                    action:@selector(checkButtonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    checkButton.backgroundColor =[UIColor clearColor];
    //[checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    //[checkButton setTitle:@"Check" forState:UIControlStateNormal];
    checkButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.frame = CGRectMake(0+1*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    checkButton.tag=1;
    [self.view addSubview:checkButton];
    
    /***
     * Call Button
     **/
    callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton addTarget:self
                   action:@selector(callButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    callButton.backgroundColor =[UIColor clearColor];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    //[callButton setTitle:@"Call" forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    callButton.tag=2;
    callButton.frame = CGRectMake(96+17.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:callButton];
    
    /***
     * Fold Button
     **/
    
    foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [foldButton addTarget:self
                   action:@selector(foldButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    foldButton.backgroundColor =[UIColor clearColor];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    //[foldButton setTitle:@"Fold" forState:UIControlStateNormal];
    foldButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    foldButton.tag=3;
    [foldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    foldButton.frame = CGRectMake(192+35.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:foldButton];
    
    /***
     * Allin Button
     **/
    allinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [allinButton addTarget:self
                    action:@selector(allinButtonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    allinButton.backgroundColor =[UIColor clearColor];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    //[allinButton setTitle:@"All in" forState:UIControlStateNormal];
    allinButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    allinButton.tag=4;
    [allinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allinButton.frame = CGRectMake(288+53.5*isiPhone5(), 320-34, 96+18*isiPhone5(), 34);
    [self.view addSubview:allinButton];
    
    bestHandsView =[[UIView alloc]initWithFrame:CGRectMake(420+88*isiPhone5(),255, 60, 30)];
    bestHandsView.backgroundColor=[UIColor clearColor];
    bestHandsView.layer.cornerRadius=5;
    bestHandsView.layer.borderWidth=1;
    bestHandsView.layer.borderColor=[[UIColor clearColor] CGColor];
    [self.view addSubview:bestHandsView];
    
    /***
     * Bet Button
     **/
    betButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [betButton addTarget:self
                  action:@selector(betButtonPressed:)
        forControlEvents:UIControlEventTouchUpInside];
    betButton.backgroundColor =[UIColor clearColor];
    [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    //[betButton setTitle:@"Bet" forState:UIControlStateNormal];
    betButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    betButton.tag=5;
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
    //[self.view addSubview:sitOutButton];
    
    /***
     * Leave Button
     **/
    leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaveButton addTarget:self
                    action:@selector(leaveButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    leaveButton.backgroundColor =[UIColor clearColor];
    [leaveButton setBackgroundImage:[UIImage imageNamed:@"Sitout"] forState:UIControlStateNormal];
    [leaveButton setTitle:@"LEAVE" forState:UIControlStateNormal];
    [leaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leaveButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10];
    
    leaveButton.frame =CGRectMake(412+78*isiPhone5(), 15, 60, 20);
    [self.view addSubview:leaveButton];
    
    /***
     * Rules Button
     **/
    rulesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rulesButton addTarget:self
                    action:@selector(rulesButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    rulesButton.backgroundColor =[UIColor clearColor];
    [rulesButton setBackgroundImage:[UIImage imageNamed:@"Sitout"] forState:UIControlStateNormal];//rulesbg
    [rulesButton setTitle:@"RULES" forState:UIControlStateNormal];
    [rulesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rulesButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:10];
    
    rulesButton.frame = CGRectMake(10, 15, 60, 20);
    [self.view addSubview:rulesButton];
}
-(void)changeBottomButtonsColorAndText
{
    [checkButton setTitle:appDelegate().firstBetValue forState:UIControlStateNormal];
    checkButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.tag=11;
    
    [callButton setTitle:appDelegate().secondBetValue forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    callButton.tag=12;
    
    [foldButton setTitle:appDelegate().thirdBetValue forState:UIControlStateNormal];
    foldButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [foldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    foldButton.tag=13;
    
    [allinButton setTitle:appDelegate().fourthBetValue forState:UIControlStateNormal];
    allinButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [allinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allinButton.tag=14;
    
    [betButton setTitle:@"Cancel" forState:UIControlStateNormal];
    betButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [betButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    betButton.tag=15;
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;

    NSString *value =callAmount;
    if([value intValue]<=500){
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
    [checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [betButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
   
    }
    else if(500<[value intValue]&&[value intValue]<=1000){
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: callButton, foldButton,allinButton, betButton,nil]] ;
    }
    else if(1000<[value intValue]&&[value intValue]<=2000){
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [callButton setTitle:@"" forState:UIControlStateNormal];
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: foldButton,allinButton, betButton,nil]] ;
    }
    else if(2000<[value intValue]&&[value intValue]<=5000){
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [callButton setTitle:@"" forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [foldButton setTitle:@"" forState:UIControlStateNormal];
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects:allinButton, betButton,nil]] ;
    }
    else if(5000<[value intValue]){
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [callButton setTitle:@"" forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [foldButton setTitle:@"" forState:UIControlStateNormal];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [allinButton setTitle:@"" forState:UIControlStateNormal];
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: betButton,nil]] ;
    }
    
}
-(void)changeBottomButtonsToRedColor
{
    [checkButton setTitle:@"Check" forState:UIControlStateNormal];
    checkButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.tag=1;
    
    [callButton setTitle:@"Call" forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    callButton.tag=2;
    
    [foldButton setTitle:@"Fold" forState:UIControlStateNormal];
    foldButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [foldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    foldButton.tag=3;
    
    [allinButton setTitle:@"All in" forState:UIControlStateNormal];
    allinButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [allinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allinButton.tag=4;
    
    [betButton setTitle:@"Bet" forState:UIControlStateNormal];
    betButton.titleLabel.font=[UIFont fontWithName:@"Arial-BoldMT" size:17];
    [betButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    betButton.tag=5;
    
    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
    [checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [betButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
}
-(void)removeAllButtons
{
    [betButton removeFromSuperview];
    [allinButton removeFromSuperview];
    [foldButton removeFromSuperview];
    [callButton removeFromSuperview];
    [checkButton removeFromSuperview];
    [leaveButton removeFromSuperview];
    [rulesButton removeFromSuperview];
}

#pragma mark Load Sounds
- (void)loadSounds{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Dealing" withExtension:@"caf"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = -1;
        [_dealingCardsSound prepareToPlay];}
}
- (void)loadCallSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"call" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}
- (void)loadCheckSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"check" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}
- (void)loadAllinSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"allin" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}
- (void)loadBetSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"rise" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}
- (void)loadNewGameSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"newgame" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}
- (void)loadWelcomeSound
{   if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"welcome" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
    [_dealingCardsSound play];}
}
- (void)loadFoldSound{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Music"]){
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:NULL];
    [audioSession setActive:YES error:NULL];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"fold" withExtension:@"mp3"];
    _dealingCardsSound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _dealingCardsSound.numberOfLoops = 0;
        [_dealingCardsSound play];}
}

#pragma mark Adding circular progressbars and Scores

-(void)addProgressViews{
    
    circularView0 =[[CircularProgressView alloc]initWithFrame:CGRectMake(309.5+65*isiPhone5(), -5, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    [self.view addSubview:circularView0];
    circularView0.delegate=self;
    circularView0.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
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

#pragma mark Adding Scores

-(void)addScoresInFrontOfPlayers:(PlayerPosition)position{
    Player *player = [game activePlayer];
    PlayerPosition playerposition = position;
    switch (playerposition)
    {
        case PlayerPositionLTop:{
            if(player!=nil){
            FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
            if([player.smallBlind isEqualToString:@"Yes"])
            firstScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
            firstScoreLabel.text=appDelegate().bigBlindValue;
            else
            firstScoreLabel.text=callAmount;
            FirstPlayerscoreView.hidden=NO;
        }
            break;
        }
        case PlayerPositionLMiddle:
        {
            if(player!=nil){
            secondPlayerscoreView.frame=CGRectMake(375+70*isiPhone5(), 147, 40, 30);
            if([player.smallBlind isEqualToString:@"Yes"])
            secondScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
            secondScoreLabel.text=appDelegate().bigBlindValue;
            else
            secondScoreLabel.text=callAmount;
            secondPlayerscoreView.hidden=NO;
            }
            break;
        }
        case PlayerPositionLBottom:
        {
            if(player!=nil){
            thirdPlayerscoreView.hidden=NO;
            if([player.smallBlind isEqualToString:@"Yes"])
                thirdScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
                thirdScoreLabel.text=appDelegate().bigBlindValue;
            else
                thirdScoreLabel.text=callAmount;
            thirdPlayerscoreView.frame=CGRectMake(320+75*isiPhone5(), 170, 40, 30);
            }
            break;
        }
        case PlayerPositionMiddle:{
            if(ActiveAtPositionMiddle==NO)
            {   if(player!=nil)
            {
                fouthPlayerscoreView.hidden=NO;
                if([player.smallBlind isEqualToString:@"Yes"])
                    fourthScoreLabel.text=appDelegate().smallBlindValue;
                else if([player.bigBlind isEqualToString:@"Yes"])
                    fourthScoreLabel.text=appDelegate().bigBlindValue;
                else
                    fourthScoreLabel.text=callAmount;
                fouthPlayerscoreView.frame=CGRectMake(220+45*isiPhone5(), 173, 40, 30);
            }
            }
            break;
        }
        case PlayerPositionRBottom:{
            if(player!=nil){
            fifthPlayerscoreView.hidden=NO;
            if([player.smallBlind isEqualToString:@"Yes"])
                fifthScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
                fifthScoreLabel.text=appDelegate().bigBlindValue;
            else
                fifthScoreLabel.text=callAmount;
            fifthPlayerscoreView.frame=CGRectMake(115+20*isiPhone5(), 170, 40, 30);
        }
            break;
        }
        case PlayerPositionRMiddle:{
            if(player!=nil){
            sixthPlayerscoreView.hidden=NO;
            if([player.smallBlind isEqualToString:@"Yes"])
                sixthScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
                sixthScoreLabel.text=appDelegate().bigBlindValue;
            else
                sixthScoreLabel.text=callAmount;
            sixthPlayerscoreView.frame=CGRectMake(65+20*isiPhone5(), 140, 40, 30);
        }
            break;
        }
        case PlayerPositionRTop:{
            if(player!=nil){
            seventhPlayerscoreView.hidden=NO;
            if([player.smallBlind isEqualToString:@"Yes"])
                seventhScoreLabel.text=appDelegate().smallBlindValue;
            else if([player.bigBlind isEqualToString:@"Yes"])
                seventhScoreLabel.text=appDelegate().bigBlindValue;
            else
                seventhScoreLabel.text=callAmount;
            seventhPlayerscoreView.frame=CGRectMake(125+20*isiPhone5(), 115, 40, 30);
        }
            break;
        }
    }
}

-(void)addCallScoresInFrontOfPlayers:(PlayerPosition)position{
    PlayerPosition playerposition = position;
    Player *player =[game activePlayer];
    switch (playerposition)
    {
        case PlayerPositionLTop:
        {
            FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
               newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                
            }
            if([game.firstPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]-[game.betValue intValue]];
            else if([game.firstPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.firstPlayerBet intValue]];
            else
                callAmount=newString;
            game.betValue=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[callAmount intValue]];
            firstScoreLabel.text=[self abbreviateNumber:[game.firstPlayerBet intValue]+[callAmount intValue]];
            game.firstPlayerBet=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[callAmount intValue];
            firstPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            FirstPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLMiddle:
        {
            secondPlayerscoreView.frame=CGRectMake(375+70*isiPhone5(), 147, 40, 30);
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
                newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
            }
            if([game.secondPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]-[game.betValue intValue]];
            else if([game.secondPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.secondPlayerBet intValue]];
            else
                callAmount=newString;
            game.betValue=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[callAmount intValue]];
            secondScoreLabel.text=[self abbreviateNumber:[game.secondPlayerBet intValue]+[callAmount intValue]];
            game.secondPlayerBet=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[callAmount intValue];
            secondPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            secondPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLBottom:
        {
            thirdPlayerscoreView.hidden=NO;
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
                newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                
            }
            if([game.thirdPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]-[game.betValue intValue]];
            else if([game.thirdPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.thirdPlayerBet intValue]];
            else
                callAmount=newString;
            game.betValue=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[callAmount intValue]];
            thirdScoreLabel.text=[self abbreviateNumber:[game.thirdPlayerBet intValue]+[callAmount intValue]];
            game.thirdPlayerBet=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[callAmount intValue];
            thirdPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            thirdPlayerscoreView.frame=CGRectMake(320+75*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionMiddle:
        {
            if(ActiveAtPositionMiddle==NO){
                fouthPlayerscoreView.hidden=NO;
                NSString * str = callAmount;
                NSString * newString;
                if ( [str length] > 0 ){
                    if ([str rangeOfString:@"k"].location == NSNotFound){
                    }
                    else {
                        if([str rangeOfString:@"."].location == NSNotFound)
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        else
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                    }
                    if ([str rangeOfString:@"M"].location == NSNotFound) {
                    }
                    else{
                        if([str rangeOfString:@"."].location == NSNotFound)
                            str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                        else
                            str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                    }
                    if ([str rangeOfString:@"B"].location == NSNotFound){
                    }
                    else{
                        if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                    }
                    newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                    
                }
                if([game.fourthPlayerBet intValue]>[game.betValue intValue])
                    callAmount =[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]-[game.betValue intValue]];
                else if([game.fourthPlayerBet intValue]<[game.betValue intValue])
                    callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.fourthPlayerBet intValue]];
                else
                    callAmount=newString;
                 game.betValue=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[callAmount intValue]];
                fourthScoreLabel.text=[self abbreviateNumber:[game.fourthPlayerBet intValue]+[callAmount intValue]];
                game.fourthPlayerBet=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[callAmount intValue]];
                int currentammount = [player.Score intValue]-[callAmount intValue];
                fourthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
                fouthPlayerscoreView.frame=CGRectMake(220+45*isiPhone5(), 173, 40, 30);
            }
            break;
        }
        case PlayerPositionRBottom:
        {
            fifthPlayerscoreView.hidden=NO;
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound){
                }
                else {
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound) {
                }
                else {
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
                newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
            }
            if([game.fifthPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]-[game.betValue intValue]];
            else if([game.fifthPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.fifthPlayerBet intValue]];
            else
                callAmount=newString;
             game.betValue=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[callAmount intValue]];
            fifthScoreLabel.text=[self abbreviateNumber:[game.fifthPlayerBet intValue]+[callAmount intValue]];
            game.fifthPlayerBet=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[callAmount intValue];
            fifthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            fifthPlayerscoreView.frame=CGRectMake(115+20*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionRMiddle:
        {
            sixthPlayerscoreView.hidden=NO;
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound) {
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound) {
                }
                else {
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound){
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
                newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
            }
            if([game.sixthPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]-[game.betValue intValue]];
            else if([game.sixthPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.sixthPlayerBet intValue]];
            else
                callAmount=newString;
            game.betValue=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[callAmount intValue]];
             sixthScoreLabel.text=[self abbreviateNumber:[game.sixthPlayerBet intValue]+[callAmount intValue]];
            game.sixthPlayerBet=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[callAmount intValue];
            sixthPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            sixthPlayerscoreView.frame=CGRectMake(65+20*isiPhone5(), 140, 40, 30);
            break;
        }
        case PlayerPositionRTop:
        {
            seventhPlayerscoreView.hidden=NO;
            NSString * str = callAmount;
            NSString * newString;
            if ( [str length] > 0 ){
                if ([str rangeOfString:@"k"].location == NSNotFound) {
                }
                else{
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                }
                if ([str rangeOfString:@"M"].location == NSNotFound){
                }
                else {
                    if([str rangeOfString:@"."].location == NSNotFound)
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                    else
                        str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                }
                if ([str rangeOfString:@"B"].location == NSNotFound){
                }
                else {
                    if([str rangeOfString:@"."].location == NSNotFound)
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                else
                    str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                }
                newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                
            }
            if([game.seventhPlayerBet intValue]>[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]-[game.betValue intValue]];
            else if([game.seventhPlayerBet intValue]<[game.betValue intValue])
                callAmount =[NSString stringWithFormat:@"%d",[game.betValue intValue]-[game.seventhPlayerBet intValue]];
            else
                callAmount=newString;
            game.betValue=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[callAmount intValue]];
            seventhScoreLabel.text=[self abbreviateNumber:[game.seventhPlayerBet intValue]+[callAmount intValue]];
            game.seventhPlayerBet=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[callAmount intValue]];
            int currentammount = [player.Score intValue]-[newString intValue];
            seventhPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
            player.Score=[NSString stringWithFormat:@"%d",currentammount];
            seventhPlayerscoreView.frame=CGRectMake(125+20*isiPhone5(), 115, 40, 30);
            break;
        }
    }
}

-(void)addAllInScoresInFrontOfPlayers:(PlayerPosition)position{
    PlayerPosition playerposition = position;
    Player *player =[game activePlayer];
    switch (playerposition)
    {
        case PlayerPositionLTop:
        {
            FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
            
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                firstPlayerScore.text=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[allInAmount intValue]];
                firstScoreLabel.text=[self abbreviateNumber:[game.firstPlayerBet intValue]+[allInAmount intValue]];
                game.firstPlayerBet=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[allInAmount intValue]];
            }
            else if ([player.Score intValue]<=[allInAmount intValue]){
                game.betValue=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+amount];
                firstScoreLabel.text=[self abbreviateNumber:[game.firstPlayerBet intValue]+amount];
                game.firstPlayerBet=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+amount];
                player.Score=@"all in";
                firstPlayerScore.text=@"all in";
            }
            FirstPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLMiddle:
        {
            secondPlayerscoreView.frame=CGRectMake(375+70*isiPhone5(), 147, 40, 30);
            
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
            
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                secondPlayerScore.text=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[allInAmount intValue]];
                secondScoreLabel.text=[self abbreviateNumber:[game.secondPlayerBet intValue]+[allInAmount intValue]];
                game.secondPlayerBet=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[allInAmount intValue]];
            }
            else if ([player.Score intValue]<=[allInAmount intValue]){
                game.betValue=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+amount];
                secondScoreLabel.text=[self abbreviateNumber:[game.secondPlayerBet intValue]+amount];
                game.secondPlayerBet=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+amount];
                player.Score=@"all in";
                secondPlayerScore.text=@"all in";
            }
            secondPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLBottom:
        {
            thirdPlayerscoreView.hidden=NO;
            
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
        
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                thirdPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[allInAmount intValue]];
                thirdScoreLabel.text=[self abbreviateNumber:[game.thirdPlayerBet intValue]+[allInAmount intValue]];
                game.thirdPlayerBet=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[allInAmount intValue]];}
            else if (([player.Score intValue]<=[allInAmount intValue])){
                game.betValue=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+amount];
                thirdScoreLabel.text=[self abbreviateNumber:[game.thirdPlayerBet intValue]+amount];
                game.thirdPlayerBet=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+amount];
                player.Score=@"all in";
                thirdPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
            }
            
            thirdPlayerscoreView.frame=CGRectMake(320+75*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionMiddle:
        {
            if(ActiveAtPositionMiddle==NO){
                fouthPlayerscoreView.hidden=NO;
                NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
                [numFormatter setPositiveFormat:@"0k"];
                [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
                int amount =[player.Score intValue];
                
                if([player.Score intValue]>[allInAmount intValue]){
                    callAmount=[self abbreviateNumber:[allInAmount intValue]];
                    player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,amount -[allInAmount intValue]];
                    game.betValue=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[allInAmount intValue]];
                    fourthScoreLabel.text=[self abbreviateNumber:[game.fourthPlayerBet intValue]+[allInAmount intValue]];
                    game.fourthPlayerBet=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[allInAmount intValue]];
                }
                else if ([player.Score intValue]<=[allInAmount intValue]){
                    game.betValue=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+amount];
                    fourthScoreLabel.text=[self abbreviateNumber:[game.fourthPlayerBet intValue]+amount];
                    game.fourthPlayerBet=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+amount];
                    player.Score=@"0";
                    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
                }
                fouthPlayerscoreView.frame=CGRectMake(220+45*isiPhone5(), 173, 40, 30);
            }
            break;
        }
        case PlayerPositionRBottom:
        {
            fifthPlayerscoreView.hidden=NO;
            
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
    
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                fifthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[allInAmount intValue]];
                fifthScoreLabel.text=[self abbreviateNumber:[game.fifthPlayerBet intValue]+[allInAmount intValue]];
                game.fifthPlayerBet=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[allInAmount intValue]];
            }
            else if ([player.Score intValue]<=[allInAmount intValue]){
                game.betValue=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+amount];
                fifthScoreLabel.text=[self abbreviateNumber:[game.fifthPlayerBet intValue]+amount];
                game.fifthPlayerBet=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+amount];
                player.Score=@"0";
                fifthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
            }
            fifthPlayerscoreView.frame=CGRectMake(115+20*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionRMiddle:
        {
            sixthPlayerscoreView.hidden=NO;
            
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                sixthPlayerScore.text=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[allInAmount intValue]];
                sixthScoreLabel.text=[self abbreviateNumber:[game.sixthPlayerBet intValue]+[allInAmount intValue]];
                game.sixthPlayerBet=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[allInAmount intValue]];
            }
            else if ([player.Score intValue]<=[allInAmount intValue]){
                player.Score=@"all in";
                sixthPlayerScore.text=@"all in";
                game.betValue=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+amount];
                sixthScoreLabel.text=[self abbreviateNumber:[game.sixthPlayerBet intValue]+amount];
                game.sixthPlayerBet=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+amount];
            }
            sixthPlayerscoreView.frame=CGRectMake(65+20*isiPhone5(), 140, 40, 30);
            break;
        }
        case PlayerPositionRTop:
        {
            seventhPlayerscoreView.hidden=NO;
            
            NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
            [numFormatter setPositiveFormat:@"0k"];
            [numFormatter setMultiplier:[NSNumber numberWithDouble:0.001]];
            int amount =[player.Score intValue];
            
            if([player.Score intValue]>[allInAmount intValue]){
                callAmount=[self abbreviateNumber:[allInAmount intValue]];
                player.Score=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                seventhPlayerScore.text=[NSString stringWithFormat:@"%d",amount -[allInAmount intValue]];
                game.betValue=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[allInAmount intValue]];
                seventhScoreLabel.text=[self abbreviateNumber:[game.seventhPlayerBet intValue]+[allInAmount intValue]];
                game.seventhPlayerBet=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[allInAmount intValue]];
            }
            else if ([player.Score intValue]<=[allInAmount intValue]){
                game.betValue=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+amount];
                seventhScoreLabel.text=[self abbreviateNumber:[game.seventhPlayerBet intValue]+amount];
                game.seventhPlayerBet=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+amount];
                player.Score=@"all in";
                seventhPlayerScore.text=@"all in";
            }
            seventhPlayerscoreView.frame=CGRectMake(125+20*isiPhone5(), 115, 40, 30);
            break;
        }
    }
}

-(void)addBetAmountInFrontOfPlayers:(PlayerPosition)position withAmount:(NSString*)amount{
    PlayerPosition playerposition = position;
    Player *player = [game activePlayer];
    switch (playerposition)
    {
        case PlayerPositionLTop:
        {
            NSString * str = amount;
            if ( [str length] > 0 ){
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue]){
                int currentammount = [player.Score intValue]-[str intValue];
                
                game.betValue=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[str intValue]];
                firstScoreLabel.text=[self abbreviateNumber:[game.firstPlayerBet intValue]+[str intValue]];
                game.firstPlayerBet=[NSString stringWithFormat:@"%d",[game.firstPlayerBet intValue]+[str intValue]];
                
                firstPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else {
                game.betValue=[NSString stringWithFormat:@"allin"];
                firstScoreLabel.text=[self abbreviateNumber:[game.firstPlayerBet intValue]+[player.Score intValue]];
                game.firstPlayerBet=[NSString stringWithFormat:@"allin"];
                
                firstPlayerScore.text=[NSString stringWithFormat:@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            FirstPlayerscoreView.Frame=CGRectMake(315+70*isiPhone5(), 115, 40, 30);
            FirstPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLMiddle:
        {
            NSString * str = amount;
            if ( [str length] > 0 ){
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue]){
                int currentammount = [player.Score intValue]-[str intValue];
                game.betValue=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[str intValue]];
                secondScoreLabel.text=[self abbreviateNumber:[game.secondPlayerBet intValue]+[str intValue]];
                game.secondPlayerBet=[NSString stringWithFormat:@"%d",[game.secondPlayerBet intValue]+[str intValue]];
                
                secondPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else{
                game.betValue=[NSString stringWithFormat:@"allin"];
                secondScoreLabel.text=[self abbreviateNumber:[game.secondPlayerBet intValue]+[player.Score intValue]];
                game.secondPlayerBet=[NSString stringWithFormat:@"allin"];
                
                secondPlayerScore.text=[NSString stringWithFormat:@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            secondPlayerscoreView.frame=CGRectMake(375+70*isiPhone5(), 147, 40, 30);
            secondPlayerscoreView.hidden=NO;
            break;
        }
        case PlayerPositionLBottom:
        {
            NSString * str = amount;
            if ( [str length] > 0 ) {
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue]) {
                int currentammount = [player.Score intValue]-[str intValue];
                
                game.betValue=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[str intValue]];
                thirdScoreLabel.text=[self abbreviateNumber:[game.thirdPlayerBet intValue]+[str intValue]];
                game.thirdPlayerBet=[NSString stringWithFormat:@"%d",[game.thirdPlayerBet intValue]+[str intValue]];
                
                thirdPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else {
                game.betValue=[NSString stringWithFormat:@"allin"];
                thirdScoreLabel.text=[self abbreviateNumber:[game.thirdPlayerBet intValue]+[player.Score intValue]];
                game.thirdPlayerBet=[NSString stringWithFormat:@"allin"];
                
                thirdPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            thirdPlayerscoreView.hidden=NO;
            thirdPlayerscoreView.frame=CGRectMake(320+75*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionMiddle:
        {
            if(ActiveAtPositionMiddle==NO) {
                NSString * str = amount;
                if ( [str length] > 0 ){
                    str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                }
                callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
                if([str intValue]<[player.Score intValue])  {
                    int currentammount = [player.Score intValue]-[str intValue];
                    
                    game.betValue=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[str intValue]];
                    fourthScoreLabel.text=[self abbreviateNumber:[game.fourthPlayerBet intValue]+[str intValue]];
                    game.fourthPlayerBet=[NSString stringWithFormat:@"%d",[game.fourthPlayerBet intValue]+[str intValue]];
                    
                    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                    player.Score=[NSString stringWithFormat:@"%d",currentammount];
                }
                else {
                    game.betValue=[NSString stringWithFormat:@"allin"];
                    fourthScoreLabel.text=[self abbreviateNumber:[game.fourthPlayerBet intValue]+[player.Score intValue]];
                    game.fourthPlayerBet=[NSString stringWithFormat:@"allin"];
                    
                    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
                    player.Score=[NSString stringWithFormat:@"all in"];
                    player.allin=@"Yes";
                }
                fouthPlayerscoreView.hidden=NO;
                fouthPlayerscoreView.frame=CGRectMake(220+45*isiPhone5(), 173, 40, 30);
            }
            break;
        }
        case PlayerPositionRBottom:
        {
            NSString * str = amount;
            if ( [str length] > 0 ){
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue])  {
                int currentammount = [player.Score intValue]-[str intValue];
                fifthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                
                game.betValue=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[str intValue]];
                fifthScoreLabel.text=[self abbreviateNumber:[game.fifthPlayerBet intValue]+[str intValue]];
                game.fifthPlayerBet=[NSString stringWithFormat:@"%d",[game.fifthPlayerBet intValue]+[str intValue]];
                
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else{
                game.betValue=[NSString stringWithFormat:@"allin"];
                fifthScoreLabel.text=[self abbreviateNumber:[game.fifthPlayerBet intValue]+[player.Score intValue]];
                game.fifthPlayerBet=[NSString stringWithFormat:@"allin"];
                
                fifthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            fifthPlayerscoreView.hidden=NO;
            fifthPlayerscoreView.frame=CGRectMake(115+20*isiPhone5(), 170, 40, 30);
            break;
        }
        case PlayerPositionRMiddle:
        {
            NSString * str = amount;
            if ( [str length] > 0 ) {
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue]){
                int currentammount = [player.Score intValue]-[str intValue];
                
                game.betValue=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[str intValue]];
                sixthScoreLabel.text=[self abbreviateNumber:[game.sixthPlayerBet intValue]+[str intValue]];
                game.sixthPlayerBet=[NSString stringWithFormat:@"%d",[game.sixthPlayerBet intValue]+[str intValue]];
                
                sixthPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else{
                game.betValue=[NSString stringWithFormat:@"allin"];
                sixthScoreLabel.text=[self abbreviateNumber:[game.sixthPlayerBet intValue]+[player.Score intValue]];
                game.sixthPlayerBet=[NSString stringWithFormat:@"allin"];
                
                sixthPlayerScore.text=[NSString stringWithFormat:@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            sixthPlayerscoreView.hidden=NO;
            sixthPlayerscoreView.frame=CGRectMake(65+20*isiPhone5(), 140, 40, 30);
            break;
        }
        case PlayerPositionRTop:
        {
            NSString * str = amount;
            if ( [str length] > 0 ){
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            }
            callAmount =[NSString stringWithFormat:@"%d",[str intValue]-[callAmount intValue]];
            if([str intValue]<[player.Score intValue]){
                int currentammount = [player.Score intValue]-[str intValue];
                
                game.betValue=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[str intValue]];
                seventhScoreLabel.text=[self abbreviateNumber:[game.seventhPlayerBet intValue]+[str intValue]];
                game.seventhPlayerBet=[NSString stringWithFormat:@"%d",[game.seventhPlayerBet intValue]+[str intValue]];
                
                seventhPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                player.Score=[NSString stringWithFormat:@"%d",currentammount];
            }
            else{
                game.betValue=[NSString stringWithFormat:@"allin"];
                seventhScoreLabel.text=[self abbreviateNumber:[game.seventhPlayerBet intValue]+[player.Score intValue]];
                game.seventhPlayerBet=[NSString stringWithFormat:@"allin"];
                
                seventhPlayerScore.text=[NSString stringWithFormat:@"all in"];
                player.Score=[NSString stringWithFormat:@"all in"];
                player.allin=@"Yes";
            }
            seventhPlayerscoreView.hidden=NO;
            seventhPlayerscoreView.frame=CGRectMake(125+20*isiPhone5(), 115, 40, 30);
            break;
        }
    }
}
#pragma mark Game Object Delegate Method

/**********************************************************
 * Game object delegate method called from game object once cards has beed arrived from dealer
 **********************************************************/
- (void)gameShouldDealCards:(Game *)gamee startingWithPlayer:(Player *)startingPlayer{
    gameStarted=YES;
    Received=YES;
    game.Received=YES;
    centerLbl.text=@"";
    if([appDelegate().gameStarted isEqualToString:@"No"]){
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    [self hideAllImageViewOfallPlayers];
    [self performSelector:@selector(DistributeCradsWithStartingPlayer:) withObject:startingPlayer afterDelay:1.0];
    }
    else{
        [self exitFromTableInBackGroundMode];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond gameShouldDealCards" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=222;
        [alert show];
    }
}
#pragma mark Distribute cards
/**********************************************************
 * Start animating cards to all players
 **********************************************************/
-(void)DistributeCradsWithStartingPlayer:(Player*)startingPlayer{
    NSTimeInterval delay = 1.0f;
        ActiveAtPositionLTop=YES;
        ActiveAtPositionLMiddle=YES;
        ActiveAtPositionLBottom=YES;
        ActiveAtPositionMiddle=YES;
        ActiveAtPositionRBottom=YES;
        ActiveAtPositionRMiddle=YES;
        ActiveAtPositionRTop=YES;
    for (int t = 0; t < 2; ++t){
        for (PlayerPosition p = startingPlayer.position; p < startingPlayer.position + 7; ++p){
            Player *player = [game playerAtPosition:p % 7];
            if (player != nil && t < [player.closedCards cardCount]){
                if(player.position==0){
                    ActiveAtPositionLTop=NO;
                    firstPlayerName.text=[NSString stringWithFormat:@"%@",player.name];
                    firstbedirBG.hidden=NO;
                    firstbedirBG.frame=CGRectMake(310.0+65*isiPhone5(), 15.0,bedirimage.size.width , bedirimage.size.height);
                    firstProfileImageBG.hidden=NO;
                    firstbedirBG.image=bedirimage;
                    firstPlayerScore.text=[NSString stringWithFormat:@"%@",player.Score];
                    [firstProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0){
                        if([player.dealer isEqualToString:@"Yes"]){
                            DealerLabel.frame =CGRectMake(333+65*isiPhone5(), 105, 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]){
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]){
                        }
                    }
                }
                if(player.position==1) {
                    ActiveAtPositionLMiddle=NO;
                    secondPlayerName.text=[NSString stringWithFormat:@"%@",player.name];
                    secondbedirBG.hidden=NO;
                    secondPlayerScore.text=[NSString stringWithFormat:@"%@",player.Score];
                    secondbedirBG.frame=CGRectMake(410+90*isiPhone5(), 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
                    secondProfileImageBG.hidden=NO;
                    secondbedirBG.image=bedirimage;
                    [secondProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0) {
                        if([player.dealer isEqualToString:@"Yes"]) {
                            DealerLabel.frame =CGRectMake(403+88*isiPhone5(), 140, 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]) {
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]) {
                        }
                    }
                }
                if(player.position==2){
                    ActiveAtPositionLBottom=NO;
                    thirdPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,player.Score];
                    thirdbedirBG.hidden=NO;
                    thirdbedirBG.frame=CGRectMake(310.0+75*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
                    thirdProfileImageBG.hidden=NO;
                    thirdbedirBG.image=thirdbedirimage;
                    [thirdProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0){
                        if([player.dealer isEqualToString:@"Yes"]){
                            DealerLabel.frame =CGRectMake(315+75*isiPhone5(), 200, 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]) {
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]){
                        }
                    }
                }
                if(player.position==3) {
                    ActiveAtPositionMiddle=NO;
                    fourthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,player.Score];
                    fouthbedirBG.hidden=NO;
                    fouthbedirBG.frame=CGRectMake(200.0+45*isiPhone5(), 210,fourthbedirimage.size.width , fourthbedirimage.size.height);
                    fourthProfileImageBG.hidden=NO;
                    fouthbedirBG.image=thirdbedirimage;
                    [fourthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0) {
                        if([player.dealer isEqualToString:@"Yes"]) {
                            DealerLabel.frame =CGRectMake(203+45*isiPhone5(), 200+5*isiPhone5(), 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]){
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]){
                        }
                    }
                }
                if(player.position==4) {
                    ActiveAtPositionRBottom=NO;
                    fifthPlayerName.text=[NSString stringWithFormat:@"%@...%@",player.name,player.Score];
                    fifthbedirBG.hidden=NO;
                    fifthbedirBG.frame=CGRectMake(90.0+15*isiPhone5(), 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
                    fifthProfileImageBG.hidden=NO;
                    fifthbedirBG.image=thirdbedirimage;
                    [fifthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0) {
                        if([player.dealer isEqualToString:@"Yes"]){
                            DealerLabel.frame =CGRectMake(97+10*isiPhone5(), 195, 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]){
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]) {
                        }
                    }
                }
                if(player.position==5){
                    ActiveAtPositionRMiddle=NO;
                    sixthPlayerName.text=[NSString stringWithFormat:@"%@",player.name];
                    sixthbedirBG.hidden=NO;
                    sixthPlayerScore.text=[NSString stringWithFormat:@"%@",player.Score];
                    sixthbedirBG.frame=CGRectMake(10.0, 85-5*isiPhone5(),bedirimage.size.width , bedirimage.size.height);
                    sixthbedirBG.image=bedirimage;
                    sixthProfileImageBG.hidden=NO;
                    [sixthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if(t==0){
                        if([player.dealer isEqualToString:@"Yes"]) {
                            DealerLabel.frame =CGRectMake(62, 140, 15, 15);
                            DealerLabel.hidden=NO;
                        }
                        else if ([player.smallBlind isEqualToString:@"Yes"]){
                        }
                        else if ([player.bigBlind isEqualToString:@"Yes"]) {
                        }
                    }
                }
                if(player.position==6){
                    ActiveAtPositionRTop=NO;
                    seventhPlayerName.text=[NSString stringWithFormat:@"%@",player.name];
                    seventhbedirBG.hidden=NO;
                    seventhbedirBG.frame=CGRectMake(108+25*isiPhone5(), 15,bedirimage.size.width , bedirimage.size.height);
                    seventhProfileImageBG.hidden=NO;
                    seventhPlayerScore.text=[NSString stringWithFormat:@"%@",player.Score];
                    seventhbedirBG.image=bedirimage;
                    [seventhProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseProfileImageUrl,player.Image]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
                    if([player.dealer isEqualToString:@"Yes"]) {
                        DealerLabel.frame =CGRectMake(132+25+isiPhone5(), 104, 15, 15);
                        DealerLabel.hidden=NO;
                    }
                    else if ([player.smallBlind isEqualToString:@"Yes"]) {
                    }
                    else if ([player.bigBlind isEqualToString:@"Yes"]) {
                    }
                }
                CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                cardView.card = [player.closedCards cardAtIndex:t];
                [self.cardContainerView addSubview:cardView];
                if(player.position<4)
                    [cardView animateDealingToPlayer:player withDelay:delay angle:0*t Xvalue:0+5*t Yvalue:0+5*t];
                else
                    [cardView animateDealingToPlayer:player withDelay:delay angle:0*t Xvalue:0-5*t Yvalue:0+5*t];
                delay += 0.1f;
            }
}
}
    [self performSelector:@selector(afterDealing) withObject:nil afterDelay:delay];
}

#pragma mark After Dealing
/**********************************************************
 * Method
 **********************************************************/
- (void)afterDealing{
    	[_dealingCardsSound stop];
        [self beginRound];
}
#pragma mark Begin Round
-(void)beginRound{
    isfirst= YES;
    [self performSelector:@selector(turnCardForPlayerAtBottom) withObject:nil afterDelay:0.0];
    [game performSelector:@selector(beginRound) withObject:nil afterDelay:1.5];
    [self performSelector:@selector(CheckForBestHandsInHoleCards) withObject:nil afterDelay:1.5];
    NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
    for(int i=0;i<=7;i++){
        Player *allPlayers =[game playerAtPosition:i];
        if (allPlayers != nil ){
            int value = [allPlayers.Score intValue];
            [allPlayersScore addObject:[NSNumber numberWithInt:value]];
        }
    }
    NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    allInAmount=[filteredArray objectAtIndex:0];
}
-(void)CheckForBestHandsInHoleCards{
    NSMutableArray *firstTempArray =[[NSMutableArray alloc]init];
    NSMutableArray *secondTempArray=[[NSMutableArray alloc]init];
    NSMutableArray *scores =[[NSMutableArray alloc]init];
    int total1=0;
    int total2=0;
    if(myOpencards.count>0){
    for(int i=0;i<2;i++){
        Card *card =[myOpencards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        if(i==0){
            [dict setObject:card forKey:@"Card"];
            [dict setObject:@"PlayerCard" forKey:@"Type"];
            [firstTempArray addObject:dict];
            firstTime =YES;
        }
        else{
            Card *firstcardsuit =[[firstTempArray objectAtIndex:0] valueForKey:@"Card"];
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
            dict =[[NSMutableDictionary alloc]init];
            if(firstsuitString==secondsuitString){
                [dict setObject:card forKey:@"Card"];
                [dict setObject:@"PlayerCard" forKey:@"Type"];
                [firstTempArray addObject:dict];
                firstTime =NO;
            }
            else{
                [dict setObject:card forKey:@"Card"];
                [dict setObject:@"PlayerCard" forKey:@"Type"];
                [secondTempArray addObject:dict];
                firstTime =NO;
            }
        }
    }
    if(firstTempArray.count>0){
        for(int k=0;k<firstTempArray.count;k++){
            Card *cardvalue =[[firstTempArray valueForKey:@"Card"] objectAtIndex:k];
            NSString *valueString;
            switch (cardvalue.value)
            {
                case CardAce:   valueString = @"11"; break;
                case CardJack:  valueString = @"10"; break;
                case CardQueen: valueString = @"10"; break;
                case CardKing:  valueString = @"10"; break;
                default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
            }
            switch (cardvalue.suit)
            {
                case SuitClubs:    firstSuitString = @"Clubs"; break;
                case SuitDiamonds: firstSuitString = @"Diamonds"; break;
                case SuitHearts:   firstSuitString = @"Hearts"; break;
                case SuitSpades:   firstSuitString = @"Spades"; break;
                default:        firstSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
            }
            int value = [valueString intValue];
            total1 = total1+value;
        }
    }
    if(secondTempArray.count>0){
        for(int l=0;l<secondTempArray.count;l++){
            Card *cardvalue =[[secondTempArray  valueForKey:@"Card"] objectAtIndex:l];
            NSString *valueString;
            switch (cardvalue.value)
            {
                case CardAce:   valueString = @"11"; break;
                case CardJack:  valueString = @"10"; break;
                case CardQueen: valueString = @"10"; break;
                case CardKing:  valueString = @"10"; break;
                default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
            }
            switch (cardvalue.suit)
            {
                case SuitClubs:    secondSuitString = @"Clubs"; break;
                case SuitDiamonds: secondSuitString = @"Diamonds"; break;
                case SuitHearts:   secondSuitString = @"Hearts"; break;
                case SuitSpades:   secondSuitString = @"Spades"; break;
                default:        secondSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
            }
            int value = [valueString intValue];
            total2 = total2+value;
        }
    }
    if(total1>total2){
        NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:4];
        [tempdict setValue:[NSNumber numberWithInt:total1] forKey:@"Score"];
        [tempdict setValue:[firstTempArray mutableCopy] forKey:@"Cards"];
        
        [scores addObject:tempdict];
        for (int t = 0; t < firstTempArray.count; ++t){
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
            cardView.card = [[firstTempArray valueForKey:@"Card"] objectAtIndex:t];
            if(t==0)
                cardView.isFirst=NO;
            else
                cardView.isFirst=YES;
            [bestHandsView addSubview:cardView];
            [cardView animateBestHandsCardsWithDelay:1.0];
        }
        [bestHandsArray removeAllObjects];
        [bestHandsArray addObjectsFromArray:[firstTempArray valueForKey:@"Card"]];
    }
    else{
        NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:4];
        [tempdict setValue:[NSNumber numberWithInt:total2] forKey:@"Score"];
        [tempdict setValue:[secondTempArray mutableCopy] forKey:@"Cards"];
        [scores addObject:tempdict];
        for (int t = 0; t < secondTempArray.count; ++t){
            CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
            cardView.card = [[secondTempArray valueForKey:@"Card"] objectAtIndex:t];
            if(t==0)
                cardView.isFirst=NO;
            else
                cardView.isFirst=YES;
            [bestHandsView addSubview:cardView];
            [cardView animateBestHandsCardsWithDelay:1.0];
        }
        [bestHandsArray removeAllObjects];
        [bestHandsArray addObjectsFromArray:[secondTempArray valueForKey:@"Card"] ];
    }
    isFirstBestCard=YES;
    [self frontEndOfBestHandCards];
    bestHandsScoreLbl.hidden=NO;
    bestHandsScoreLbl.text=[NSString stringWithFormat:@"%@",[[scores valueForKey:@"Score"] objectAtIndex:0]];
    }
    else
    {
        [self exitFromTableInBackGroundMode];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond CheckForBestHandsInHoleCards" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=222;
        [alert show];
    }
}
- (void)game:(Game *)game didActivatePlayer:(Player *)player{
    if(Received==YES&& myOpencards.count>0&&[appDelegate().gameStarted isEqualToString:@"No"])
    {
          [self  showIndicatorForActivePlayer];
        
    }
    else if (Received==NO)
    {
        [self exitFromTableInBackGroundMode];
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Your internet connection is too slow to respond showIndicatorForActivePlayer" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag=222;
        [alert show];
    }
 
}
#pragma mark Show Indicater For Player
-(void)showIndicatorForActivePlayer{
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [betButton setTitle:@"" forState:UIControlStateNormal];
    [allinButton setTitle:@"" forState:UIControlStateNormal];
    [foldButton setTitle:@"" forState:UIControlStateNormal];
    [callButton setTitle:@"" forState:UIControlStateNormal];
    [checkButton setTitle:@"" forState:UIControlStateNormal];
    PlayerPosition position = [game activePlayer].position;
    
    
    Player *player = [game activePlayer];
    switch (position)
    {
        case PlayerPositionLTop:
        {
            if(player==nil||ActiveAtPositionLTop==YES){
                game.firstPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else if ([player.allin isEqual:@"Yes"] ||(ActiveAtPositionLMiddle==YES&&ActiveAtPositionLBottom==YES&&ActiveAtPositionMiddle==YES&&ActiveAtPositionRBottom==YES&&ActiveAtPositionRMiddle==YES&&ActiveAtPositionRTop==YES)){
                game.firstPlayerBet=game.betValue;
                 game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else{
                if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])){
                  if([player.smallBlind isEqualToString:@"Yes"]){
                      firstScoreLabel.text=appDelegate().smallBlindValue;
                      NSString * str = appDelegate().smallBlindValue;
                      if ( [str length] > 0 ){
                          str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                      }
                      int currentammount = [player.Score intValue]-[str intValue];
                      firstPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                      player.Score=[NSString stringWithFormat:@"%d",currentammount];
                      game.betValue=str;
                      game.firstPlayerBet=game.betValue;
                      callAmount=appDelegate().smallBlindValue;
                      [self addScoresInFrontOfPlayers:position];
                  }
                   else if([player.bigBlind isEqualToString:@"Yes"]){
                      firstScoreLabel.text=appDelegate().bigBlindValue;
                       NSString * str = appDelegate().bigBlindValue;
                       if ( [str length] > 0 ){
                           str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                       }
                       int currentammount = [player.Score intValue]-[str intValue];
                       firstPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                       player.Score=[NSString stringWithFormat:@"%d",currentammount];
                       game.betValue=str;
                       game.firstPlayerBet=game.betValue;
                       callAmount=appDelegate().bigBlindValue;
                       [self addScoresInFrontOfPlayers:position];
                   }
                    game._activePlayerPosition++;
                    [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
                }
                else{
                    shineImage.frame=CGRectMake(290.0+65*isiPhone5(), 15.0,100,100);
                   circularView0.hidden = NO;
                   circularView0.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                   [circularView0 play];
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                shineImage.hidden=NO;
                }
            }
            break;
        }
        case PlayerPositionLMiddle:
        {
            if(player==nil||ActiveAtPositionLMiddle==YES){
                game.secondPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else if ([player.allin isEqual:@"Yes"]||(ActiveAtPositionLTop==YES&&ActiveAtPositionLBottom==YES&&ActiveAtPositionMiddle==YES&&ActiveAtPositionRBottom==YES&&ActiveAtPositionRMiddle==YES&&ActiveAtPositionRTop==YES)){
                game.secondPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else{
                if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])) {
                    if([player.smallBlind isEqualToString:@"Yes"]) {
                        secondScoreLabel.text=appDelegate().smallBlindValue;
                        NSString * str = appDelegate().smallBlindValue;
                        if ( [str length] > 0 ) {
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        secondPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.secondPlayerBet=game.betValue;
                        callAmount=appDelegate().smallBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    else if([player.bigBlind isEqualToString:@"Yes"]) {
                        secondScoreLabel.text=appDelegate().bigBlindValue;
                        NSString * str = appDelegate().bigBlindValue;
                        if ( [str length] > 0 ) {
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        secondPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.secondPlayerBet=game.betValue;
                        callAmount=appDelegate().bigBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    game._activePlayerPosition++;
                    [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
                }
                else{
                    shineImage.frame = CGRectMake(390+90*isiPhone5(), 85-5*isiPhone5(),100,100);
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                   if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                    shineImage.hidden=NO;
                  circularView1.hidden = NO;
                   circularView1.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                  [circularView1 play];
                }
            }
            break;
        }
        case PlayerPositionLBottom:
        {
            if(player==nil||ActiveAtPositionLBottom==YES){
                game.thirdPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else if ([player.allin isEqual:@"Yes"]||((ActiveAtPositionLTop==YES)&&(ActiveAtPositionLMiddle==YES)&&(ActiveAtPositionMiddle==YES)&&(ActiveAtPositionRBottom==YES)&&(ActiveAtPositionRMiddle==YES)&&(ActiveAtPositionRTop==YES))){
                game.thirdPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else {
                if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])) {
                    if([player.smallBlind isEqualToString:@"Yes"]){
                        thirdScoreLabel.text=appDelegate().smallBlindValue;
                        NSString * str = appDelegate().smallBlindValue;
                        player.bet=appDelegate().smallBlindValue;
                        game.thirdPlayerBet=appDelegate().smallBlindValue;
                        if ( [str length] > 0 ){
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        thirdPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.thirdPlayerBet=game.betValue;
                        callAmount=appDelegate().smallBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    else if([player.bigBlind isEqualToString:@"Yes"]) {
                        thirdScoreLabel.text=appDelegate().bigBlindValue;
                        NSString * str = appDelegate().bigBlindValue;
                        player.bet=appDelegate().bigBlindValue;
                        game.thirdPlayerBet=appDelegate().bigBlindValue;
                        if ( [str length] > 0 ) {
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        thirdPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.thirdPlayerBet=game.betValue;
                        callAmount=appDelegate().bigBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    game._activePlayerPosition++;
                    [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
                }
                else{
                    shineImage.frame = CGRectMake(300.0+75*isiPhone5(), 210,100 ,100);
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                    shineImage.hidden=NO;
                 circularView2.hidden = NO;
                 circularView2.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                 [circularView2 play];
                }
            }
            break;
        }
        case PlayerPositionMiddle:
        {
            if(player==nil||ActiveAtPositionMiddle==YES){
                game.fourthPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else if ([player.allin isEqual:@"Yes"]||((ActiveAtPositionLTop==YES)&&(ActiveAtPositionLBottom==YES)&&(ActiveAtPositionLMiddle==YES)&&(ActiveAtPositionRBottom==YES)&&(ActiveAtPositionRMiddle==YES)&&(ActiveAtPositionRTop==YES))){
                game.fourthPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else{
                if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])){
                    if([player.smallBlind isEqualToString:@"Yes"]){
                        fourthScoreLabel.text=appDelegate().smallBlindValue;
                        NSString * str = appDelegate().smallBlindValue;
                        player.bet=appDelegate().smallBlindValue;
                        game.fourthPlayerBet=appDelegate().smallBlindValue;
                        if ( [str length] > 0 ){
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        fourthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.fourthPlayerBet=game.betValue;
                        callAmount=appDelegate().smallBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    else if([player.bigBlind isEqualToString:@"Yes"]){
                        fourthScoreLabel.text=appDelegate().bigBlindValue;
                        NSString * str = appDelegate().bigBlindValue;
                        player.bet=appDelegate().bigBlindValue;
                        game.fourthPlayerBet=appDelegate().bigBlindValue;
                        if ( [str length] > 0 ){
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        fourthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.fourthPlayerBet=game.betValue;
                        callAmount=appDelegate().bigBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    game._activePlayerPosition++;
                    [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
                }
              else{
                  [self changeBottomButtonsToRedColor];
                  [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,nil]] ;
                  if(([game.fourthPlayerBet isEqualToString:game.betValue ])){
                      [checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
                      [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
                      [callButton setTitle:@"" forState:UIControlStateNormal];
                    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: checkButton,nil]];
                    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: callButton,nil]];
                  }
                  else{
                    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
                    [callButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
                    [checkButton setTitle:@"" forState:UIControlStateNormal];
                    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton,nil]];
                    [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: callButton,nil]];
                  }
                  NSString * str = callAmount;
                  NSString * newString;
                  if ( [str length] > 0 ) {
                      if ([str rangeOfString:@"k"].location == NSNotFound) {
                      }
                      else{
                          if([str rangeOfString:@"."].location == NSNotFound)
                              str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                          else
                              str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                      }
                      if ([str rangeOfString:@"M"].location == NSNotFound){
                      }
                      else{
                          if([str rangeOfString:@"."].location == NSNotFound)
                              str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                          else
                              str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                      }
                      if ([str rangeOfString:@"B"].location == NSNotFound){
                      }
                      else {
                          if([str rangeOfString:@"."].location == NSNotFound)
                          str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                      else
                          str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                      }
                      newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                  }
                  if([newString intValue]>[player.Score intValue]){
                      NSLog(@"Value is greater");
                      [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
                      [betButton setTitle:@"" forState:UIControlStateNormal];
                      [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
                      [callButton setTitle:@"" forState:UIControlStateNormal];
                      [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: betButton,callButton,nil]];
                      
                  }else{
                     [betButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
                      [self enableInteraction:YES arrayOfViews:[[NSArray alloc]initWithObjects: betButton,nil]];
                  }
                  [foldButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
                  [allinButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
                 circularView3.hidden = NO;
                   shineImage.frame = CGRectMake(190.0+45*isiPhone5(), 210,100,100);
                  [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                  if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                  shineImage.hidden=NO;
                 circularView3.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                 [circularView3 play];
              }
            }
            break;
        }
        case PlayerPositionRBottom:
        {
            if(player==nil||ActiveAtPositionRBottom==YES) {
                game.fifthPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else if ([player.allin isEqual:@"Yes"]||((ActiveAtPositionLTop==YES)&&(ActiveAtPositionLBottom==YES)&&(ActiveAtPositionLMiddle==YES)&&(ActiveAtPositionMiddle==YES)&&(ActiveAtPositionRMiddle==YES)&&(ActiveAtPositionRTop==YES))){
                game.fifthPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
            else{
                if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])) {
                    if([player.smallBlind isEqualToString:@"Yes"]) {
                        fifthScoreLabel.text=appDelegate().smallBlindValue;
                        NSString * str = appDelegate().smallBlindValue;
                        player.bet=appDelegate().smallBlindValue;
                        game.fifthPlayerBet=appDelegate().smallBlindValue;
                        if ( [str length] > 0 ){
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        fifthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.fifthPlayerBet=game.betValue;
                        callAmount=appDelegate().smallBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    else if([player.bigBlind isEqualToString:@"Yes"]){
                        fifthScoreLabel.text=appDelegate().bigBlindValue;
                        NSString * str = appDelegate().bigBlindValue;
                        player.bet=appDelegate().bigBlindValue;
                        game.fifthPlayerBet=appDelegate().bigBlindValue;
                        if ( [str length] > 0 ){
                            str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                        }
                        int currentammount = [player.Score intValue]-[str intValue];
                        fifthPlayerName.text=[NSString stringWithFormat:@"%@...%d",player.name,currentammount];
                        player.Score=[NSString stringWithFormat:@"%d",currentammount];
                        game.betValue=str;
                        game.fifthPlayerBet=game.betValue;
                        callAmount=appDelegate().bigBlindValue;
                        [self addScoresInFrontOfPlayers:position];
                    }
                    game._activePlayerPosition++;
                    [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
                }
                else {
                     shineImage.frame = CGRectMake(80.0+15*isiPhone5(), 210,100,100);
                    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                    if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                    shineImage.hidden=NO;
                    circularView4.hidden = NO;
                    circularView4.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                    [circularView4 play];
                }
            }
            break;
        }
        case PlayerPositionRMiddle:
        {
            if(player==nil||ActiveAtPositionRMiddle==YES){
            game.sixthPlayerBet=game.betValue;
            game._activePlayerPosition++;
            [game turnCardForActivePlayer];
        }
            else if ([player.allin isEqual:@"Yes"]||(ActiveAtPositionLTop==YES&&ActiveAtPositionLBottom==YES&&ActiveAtPositionLMiddle==YES&&ActiveAtPositionMiddle==YES&&ActiveAtPositionRBottom==YES&&ActiveAtPositionRTop==YES)) {
                game.sixthPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
        else {
            if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])){
                if([player.smallBlind isEqualToString:@"Yes"]) {
                    sixthScoreLabel.text=appDelegate().smallBlindValue;
                    NSString * str = appDelegate().smallBlindValue;
                    if ( [str length] > 0 ){
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    }
                    int currentammount = [player.Score intValue]-[str intValue];
                    sixthPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                    player.Score=[NSString stringWithFormat:@"%d",currentammount];
                    game.betValue=str;
                    game.sixthPlayerBet=game.betValue;
                    callAmount=appDelegate().smallBlindValue;
                    [self addScoresInFrontOfPlayers:position];
                }
                else if([player.bigBlind isEqualToString:@"Yes"]){
                    sixthScoreLabel.text=appDelegate().bigBlindValue;
                    NSString * str = appDelegate().bigBlindValue;
                    if ( [str length] > 0 ){
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    }
                    int currentammount = [player.Score intValue]-[str intValue];
                    sixthPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                    player.Score=[NSString stringWithFormat:@"%d",currentammount];
                    game.betValue=str;
                    game.sixthPlayerBet=game.betValue;
                    callAmount=appDelegate().bigBlindValue;
                    [self addScoresInFrontOfPlayers:position];
                }
                game._activePlayerPosition++;
                [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
            }
            else{
                 shineImage.frame = CGRectMake(-10, 85-5*isiPhone5(),100,100);
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                shineImage.hidden=NO;
                circularView5.hidden = NO;
                circularView5.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
                [circularView5 play];
            }
        }
            break;
        }
        case PlayerPositionRTop:
        {
            if(player==nil||ActiveAtPositionRTop==YES){
            game.seventhPlayerBet=game.betValue;
           game._activePlayerPosition++;
            [game turnCardForActivePlayer];
        }
            else if ([player.allin isEqual:@"Yes"]|(ActiveAtPositionLTop==YES&&ActiveAtPositionLBottom==YES&&ActiveAtPositionLMiddle==YES&&ActiveAtPositionMiddle==YES&&ActiveAtPositionRBottom==YES&&ActiveAtPositionRMiddle==YES)) {   game.seventhPlayerBet=game.betValue;
                game._activePlayerPosition++;
                [game turnCardForActivePlayer];
            }
        else {
            if((round==0&&[player.smallBlind isEqualToString:@"Yes"])||(round==0&&[player.bigBlind isEqualToString:@"Yes"])) {
                if([player.smallBlind isEqualToString:@"Yes"]){
                    seventhScoreLabel.text=appDelegate().smallBlindValue;
                    NSString * str = appDelegate().smallBlindValue;
                    if ( [str length] > 0 ) {
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    }
                    int currentammount = [player.Score intValue]-[str intValue];
                    seventhPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                    player.Score=[NSString stringWithFormat:@"%d",currentammount];
                    game.betValue=str;
                    game.seventhPlayerBet=game.betValue;
                    callAmount=appDelegate().smallBlindValue;
                    [self addScoresInFrontOfPlayers:position];
                }
                else if([player.bigBlind isEqualToString:@"Yes"]){
                    seventhScoreLabel.text=appDelegate().bigBlindValue;
                    NSString * str = appDelegate().bigBlindValue;
                    if ( [str length] > 0 ) {
                        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                    }
                    int currentammount = [player.Score intValue]-[str intValue];
                    seventhPlayerScore.text=[NSString stringWithFormat:@"%d",currentammount];
                    player.Score=[NSString stringWithFormat:@"%d",currentammount];
                    game.betValue=str;
                    game.seventhPlayerBet=game.betValue;
                    callAmount=appDelegate().bigBlindValue;
                    [self addScoresInFrontOfPlayers:position];
                }
                game._activePlayerPosition++;
                [game performSelector:@selector(turnCardForActivePlayer) withObject:Nil afterDelay:0.1];
            }
            else {
                shineImage.frame = CGRectMake(85+25*isiPhone5(), 15,100,100);
                [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeSpotlight) userInfo:nil repeats:NO];
                if([[NSUserDefaults standardUserDefaults]boolForKey:@"Spotlight"])
                shineImage.hidden=NO;
               circularView6.hidden = NO;
               circularView6.audioPath= [[NSBundle mainBundle] URLForResource:@"Music" withExtension:@"mp4"];
               [circularView6 play];
            }
            }
            break;
    }
    }
}
-(void)removeSpotlight{
    shineImage.hidden=YES;
}

#pragma mark Rounds Handling

-(void)playerDidFinishPlaying{
    [sliderView removeFromSuperview];
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
    [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    Player *player =[game activePlayer];
    playerId = [player.ID intValue];
    [self performSelector:@selector(playerIsNotResponding) withObject:self afterDelay:4.0];
    [NSTimer scheduledTimerWithTimeInterval:2//1sec
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}
-(void)playerIsNotResponding{
    Player *player =[game playerWithPeerID:[NSString stringWithFormat:@"%d",playerId]];
    
    if(isPoped==NO)
    [self loadFoldSound];
     if(player.position==PlayerPositionLTop){
     firstbedirBG.alpha=0.5;
     circularView0.hidden=YES;
     [circularView0 stop];
     
     firtPlayerstatusLabel.text=@"Fold";
     [firstProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
     for(int i=0;i<2;i++){
     Card *card = [player turnOverTopCard];
     CardView *cardView = [self cardViewForCard:card];
     [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
     }
     [player.openCards removeAllCards];
     [player.closedCards removeAllCards];
     player.status=@"Not Active";
     if(ActiveAtPositionLTop ==NO){
     }
     ActiveAtPositionLTop =YES;
     }
     else if (player.position==PlayerPositionLMiddle){
     secondbedirBG.alpha=0.5;
     circularView1.hidden=YES;
     [circularView1 stop];
     
     secondPlayerstatusLabel.text=@"Fold";
     [secondProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
     for(int i=0;i<2;i++){
     Card *card = [player turnOverTopCard];
     CardView *cardView = [self cardViewForCard:card];
     [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
     }
     [player.openCards removeAllCards];
     [player.closedCards removeAllCards];
     player.status=@"Not Active";
     if(ActiveAtPositionLMiddle ==NO){
     }
     ActiveAtPositionLMiddle =YES;
     }
     else if (player.position==PlayerPositionLBottom){
     thirdbedirBG.alpha=0.5;
     circularView2.hidden=YES;
     [circularView2 stop];
     
     thirdPlayerstatusLabel.text=@"Fold";
     [thirdProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
     for(int i=0;i<2;i++){
     Card *card = [player turnOverTopCard];
     CardView *cardView = [self cardViewForCard:card];
     [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
     }
     [player.openCards removeAllCards];
     [player.closedCards removeAllCards];
     player.status=@"Not Active";
         if(ActiveAtPositionLBottom ==NO){
     }
     ActiveAtPositionLBottom =YES;
     }
  else  if (player.position==PlayerPositionMiddle){
        fouthbedirBG.alpha=0.5;
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"Fold";
        NSMutableArray *array =[[NSMutableArray alloc]init];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:player.ID forKey:@"Id"];
        [dict setValue:player.Score forKey:@"FinalScore"];
        [dict setValue:player.serverindex forKey:@"index"];
        [dict setValue:@"0" forKey:@"Points"];
        [array addObject:dict];
        [player.openCards removeAllCards];
        [player.closedCards removeAllCards];
        player.status=@"Not Active";
        NSString *jsonserverArray = [array JSONRepresentation];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *_response;
            NSError* _error = nil;
            NSString *_urlString = [NSString stringWithFormat:BaseUrl];
            NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
            NSString *_params = [NSString stringWithFormat:@"operation=fold_game_info&game_level=%@&player_info=%@&table_number=%@",appDelegate().LevelName,jsonserverArray,appDelegate().tableNumber];
            NSData *postData = [_params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSMutableURLRequest *_req=[[NSMutableURLRequest alloc]initWithURL:_url];
            [_req setHTTPMethod:@"POST"];
            [_req setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [_req setHTTPBody:postData];
            NSData *_data=[NSURLConnection sendSynchronousRequest:_req returningResponse:&_response error:&_error];
            dispatch_async( dispatch_get_main_queue(), ^{
                @try {
                }
                @catch (NSException *exception) {
                    
                }
            });
        });
        for(int i=0;i<2;i++){
            CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
            [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        if(ActiveAtPositionMiddle ==NO) {
        }
        ActiveAtPositionMiddle =YES;
    }
     else if (player.position==PlayerPositionRBottom){
         fifthbedirBG.alpha=0.5;
         circularView4.hidden=YES;
         [circularView4 stop];
         fifthPlayerstatusLabel.text=@"Fold";
         [fifthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
         for(int i=0;i<2;i++){
             Card *card = [player turnOverTopCard];
             CardView *cardView = [self cardViewForCard:card];
             [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
         }
         [player.openCards removeAllCards];
         [player.closedCards removeAllCards];
         player.status=@"Not Active";
         if(ActiveAtPositionRBottom ==NO){
         }
         ActiveAtPositionRBottom =YES;
     }
     else if (player.position==PlayerPositionRMiddle){
         sixthbedirBG.alpha=0.5;
         circularView5.hidden=YES;
         [circularView5 stop];
         sixthPlayerstatusLabel.text=@"Fold";
         [sixthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
         for(int i=0;i<2;i++){
             Card *card = [player turnOverTopCard];
             CardView *cardView = [self cardViewForCard:card];
             [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
         }
         [player.openCards removeAllCards];
         [player.closedCards removeAllCards];
         player.status=@"Not Active";
         if(ActiveAtPositionRMiddle ==NO){
         }
         ActiveAtPositionRMiddle =YES;
     }
     else if (player.position==PlayerPositionRTop){
         seventhbedirBG.alpha=0.5;
         circularView6.hidden=YES;
         [circularView6 stop];
         seventhPlayerstatusLabel.text=@"Fold";
         [seventhProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
         [player.openCards removeAllCards];
         for(int i=0;i<2;i++){
             Card *card = [player turnOverTopCard];
             CardView *cardView = [self cardViewForCard:card];
             [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
         }
         [player.openCards removeAllCards];
         [player.closedCards removeAllCards];
         player.status=@"Not Active";
         if(ActiveAtPositionRTop ==NO){
         }
         ActiveAtPositionRTop =YES;
     }
    if([player.dealer isEqualToString:@"No"]){
        game._activePlayerPosition++;
        [game turnCardForActivePlayer];
    }
    else{
        [game turnCardForActivePlayer];
    }
}

#pragma mark Adding circular progressbars Delegates
- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player{
    [self formatTime:(int)player.currentTime];
}
- (void)formatTime:(int)num{
    PlayerPosition position = [game activePlayer].position;
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
#pragma mark TurnBottom Player Cards

-(void)turnCardForPlayerAtBottom{
    game._activePlayerPosition =PlayerPositionMiddle;
    if ((game._activePlayerPosition ==PlayerPositionMiddle) && ([[game activePlayer].closedCards cardCount] > 0)){
        [self turnCardForActivePlayer];
    }
}
-(void)turnCardForActivePlayer{
    [self turnCardForPlayer:[game bottomactivePlayer]];
}
- (void)turnCardForPlayer:(Player *)player{
    NSAssert([player.closedCards cardCount] > 0, @"Player has no more cards");
    Card *card = [player turnOverTopCard];
    [myOpencards addObject:card];
    CardView *cardView = [self cardViewForCard:card];
    if(isfirst ==NO)
        cardView.isFirst=YES;
    else
        cardView.isFirst=NO;
    
    [cardView animateTurningOverForPlayer:player success:^(){
         if(player.position==PlayerPositionMiddle){
             if(isfirst ==YES){
                 isfirst=NO;
                 [self turnCardForPlayerAtBottom];
             }
              else{
              }
         }
     }];
}
- (CardView *)cardViewForCard:(Card *)card{
    for (CardView *cardView in self.cardContainerView.subviews){
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}
- (CardView *)cardViewForCardInCummunity:(Card *)card{
    for (CardView *cardView in self.communityView.subviews){
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}
#pragma mark Removing Cards
-(void)removeCardsAtThePlayer:(PlayerPosition)position{
    Player *player;
    player.position = PlayerPositionLTop;
}
- (CardView *)communityCardViewForCard:(Card *)card{
    for (CardView *cardView in self.communityView.subviews){
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}
- (CardView *)bestHandCardViewForCard:(Card *)card{
    for (CardView *cardView in bestHandsView.subviews){
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}
#pragma mark Picking Stating Random Player
- (void)pickRandomStartingPlayer{
    do{
        _startingPlayerPosition = 0;
    }
    while ([self playerAtPosition:_startingPlayerPosition] == nil);
    _activePlayerPosition = _startingPlayerPosition;
}
#pragma mark Player Position
- (Player *)playerAtPosition:(PlayerPosition)position{
    NSAssert(position >= PlayerPositionLTop && position <= PlayerPositionRTop, @"Invalid player position");
    __block Player *player;
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
         player = obj;
         if (player.position == position)
             *stop = YES;
         else
             player = nil;
     }];
    return player;
}
#pragma mark Active Player
- (Player *)activePlayer{
    return [self playerAtPosition:_activePlayerPosition];
}

#pragma mark Check Button Action

-(void)checkButtonPressed:(UIButton*)button{
    if(button.tag==1){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@",[game activePlayer].ID] forKey: @"UserId"];
    [dict setObject:@"Check" forKey:@"type"];
    
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
        [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
    else if(button.tag==11){
        NSString *value =callAmount;
        if(500<[value intValue]){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Bet amount should be greater than %@",callAmount ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else{
            [sliderView removeFromSuperview];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[game activePlayer].ID forKey: @"UserId"];
            [dict setObject:@"Bet" forKey:@"type"];
            [dict setObject:appDelegate().firstBetValue forKey:@"Amount"];
            [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
            [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
            [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
    }
}
-(void)actionForCheckButton:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    Player *calledPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    if(isPoped==NO)
    [self loadCheckSound];
    if(calledPlayer.position==PlayerPositionLTop){
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionLMiddle){
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionLBottom){
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionMiddle){
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionRBottom){
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionRMiddle){
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"Check";
    }
    else if (calledPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"Check";
    }
    game._activePlayerPosition++;
    [game turnCardForActivePlayer];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}
-(void)RemoveStatusText{
    firtPlayerstatusLabel.text=@"";
    secondPlayerstatusLabel.text=@"";
    thirdPlayerstatusLabel.text=@"";
    fourthPlayerstatusLabel.text=@"";
    fifthPlayerstatusLabel.text=@"";
    sixthPlayerstatusLabel.text=@"";
    seventhPlayerstatusLabel.text=@"";
}
#pragma mark Call Button Action
-(void)callButtonPressed:(UIButton*)button{
    if(button.tag==2){
    Player *player =[game activePlayer];
    NSString * str = callAmount;
    NSString * newString;
    if ( [str length] > 0 ){
        if ([str rangeOfString:@"k"].location == NSNotFound){
        }
        else{
            if([str rangeOfString:@"."].location == NSNotFound)
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
            else
                str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
        }
        if ([str rangeOfString:@"M"].location == NSNotFound){
        }
        else{
            if([str rangeOfString:@"."].location == NSNotFound)
                str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
            else
                str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
        }
        if ([str rangeOfString:@"B"].location == NSNotFound){
        }
        else{
            if([str rangeOfString:@"."].location == NSNotFound)
            str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
        else
            str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
        }
        newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    if([newString longLongValue]>[player.Score intValue]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Don't have enough credits to bet the amount entered." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
       else{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%@",[game activePlayer].ID] forKey: @"UserId"];
    [dict setObject:@"Call" forKey:@"type"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
        [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
    }
    else if (button.tag==12){
        NSString *value =callAmount;
        if(1000<[value intValue]){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Bet amount should be greater than %@",callAmount ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else{
            [sliderView removeFromSuperview];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[game activePlayer].ID forKey: @"UserId"];
            [dict setObject:@"Bet" forKey:@"type"];
            [dict setObject:appDelegate().secondBetValue forKey:@"Amount"];
            [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
            [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
            [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        }
    }
    }
-(void)actionForCallButton:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    Player *calledPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    if(isPoped==NO)
    [self loadCallSound];
    if(calledPlayer.position==PlayerPositionLTop){
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionLMiddle){
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionLBottom){
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionMiddle){
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRBottom){
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRMiddle){
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"Call";
        [self addCallScoresInFrontOfPlayers:calledPlayer.position];
    }
    game._activePlayerPosition++;
    [game turnCardForActivePlayer];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}
#pragma mark Fold Button Action

-(void)foldButtonPressed:(UIButton*)button{
    if(button.tag==3){
     NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[game activePlayer].ID forKey: @"UserId"];
    [dict setObject:@"Fold" forKey:@"type"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
        [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
    else if(button.tag==13){
        NSString *value =callAmount;
        if(2000<[value intValue]){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Bet amount should be greater than %@",callAmount ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else{
            [sliderView removeFromSuperview];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[game activePlayer].ID forKey: @"UserId"];
            [dict setObject:@"Bet" forKey:@"type"];
            [dict setObject:appDelegate().thirdBetValue forKey:@"Amount"];
            [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
            [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
            [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        }
    }
    }
-(void)actionForFoldButton:(NSDictionary *)responseDict{
     NSString * userId = [responseDict objectForKey: @"UserId"];
     Player *foldedPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    [self loadFoldSound];
    if(foldedPlayer.position==PlayerPositionLTop){
        firstbedirBG.alpha=0.5;
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"Fold";
        [firstProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLTop ==NO){
        }
        ActiveAtPositionLTop =YES;
    }
    else if (foldedPlayer.position==PlayerPositionLMiddle){
        secondbedirBG.alpha=0.5;
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"Fold";
        [secondProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLMiddle ==NO){
        }
        ActiveAtPositionLMiddle =YES;
    }
    else if (foldedPlayer.position==PlayerPositionLBottom){
        thirdbedirBG.alpha=0.5;
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"Fold";
        [thirdProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLBottom ==NO){
        }
        ActiveAtPositionLBottom =YES;
    }
    else if (foldedPlayer.position==PlayerPositionMiddle){
        fouthbedirBG.alpha=0.5;
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"Fold";
        NSMutableArray *array =[[NSMutableArray alloc]init];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:foldedPlayer.ID forKey:@"Id"];
        [dict setValue:foldedPlayer.Score forKey:@"FinalScore"];
        [dict setValue:foldedPlayer.serverindex forKey:@"index"];
        [dict setValue:@"0" forKey:@"Points"];
        [array addObject:dict];
        NSString *jsonserverArray = [array JSONRepresentation];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *_response;
            NSError* _error = nil;
            NSString *_urlString = [NSString stringWithFormat:BaseUrl];
            NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
            NSString *_params = [NSString stringWithFormat:@"operation=fold_game_info&game_level=%@&player_info=%@&table_number=%@",appDelegate().LevelName,jsonserverArray,appDelegate().tableNumber];
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
                }
                @catch (NSException *exception) {
                }
            });
        });
        for(int i=0;i<2;i++){
            CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
            [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        if(ActiveAtPositionMiddle ==NO){
        }
        ActiveAtPositionMiddle =YES;
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
    }
    else if (foldedPlayer.position==PlayerPositionRBottom){
        fifthbedirBG.alpha=0.5;
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"Fold";
        [fifthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRBottom ==NO) {
        }
        ActiveAtPositionRBottom =YES;
    }
    else if (foldedPlayer.position==PlayerPositionRMiddle){
        sixthbedirBG.alpha=0.5;
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"Fold";
        [sixthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRMiddle ==NO){
        }
        ActiveAtPositionRMiddle =YES;
    }
    else if (foldedPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"Fold";
        [seventhProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRTop ==NO){
        }
        ActiveAtPositionRTop =YES;
    }
    game._activePlayerPosition++;
    [game turnCardForActivePlayer];
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}

#pragma mark All in Button Action

-(void)allinButtonPressed:(UIButton*)button{
    if(button.tag==4){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[game activePlayer].ID forKey: @"UserId"];
    [dict setObject:@"AllIn" forKey:@"type"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
        [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
    else if (button.tag==14){
        NSString *value =callAmount;
        if(5000<[value intValue]){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Bet amount should be greater than %@",callAmount ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else{
            [sliderView removeFromSuperview];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[game activePlayer].ID forKey: @"UserId"];
            [dict setObject:@"Bet" forKey:@"type"];
            [dict setObject:appDelegate().fourthBetValue forKey:@"Amount"];
            [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
            [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
            [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
            [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        }
    }
}

-(void)actionForAllInButton:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    Player *calledPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    calledPlayer.allin =@"Yes";
    if(isPoped==NO)
    [self loadAllinSound];
    if(calledPlayer.position==PlayerPositionLTop){
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionLMiddle){
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionLBottom){
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionMiddle){
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRBottom){
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRMiddle){
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    else if (calledPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"Allin";
        [self addAllInScoresInFrontOfPlayers:calledPlayer.position];
    }
    game._activePlayerPosition++;
    [game turnCardForActivePlayer];
    [NSTimer scheduledTimerWithTimeInterval:2//1sec
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}

#pragma mark Bet Button Action

-(void)betButtonPressed :(UIButton*)button{
    if(button.tag==5){
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[game activePlayer].ID forKey: @"UserId"];
    [dict setObject:@"BetPressed" forKey:@"type"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"IsFirstTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (button.tag==15){
        [sliderView removeFromSuperview];
        [self changeBottomButtonsToRedColor];
    }
}
-(void)actionForBetButtonPressed:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    Player *betPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    if(isPoped==NO){
        if([betPlayer.smallBlind isEqualToString:@"Yes"]&& (([game.firstPlayerBet intValue]&&[game.secondPlayerBet intValue]&&[game.thirdPlayerBet intValue]&&[game.fourthPlayerBet intValue]&&[game.fifthPlayerBet intValue]&&[game.sixthPlayerBet intValue]&&[game.seventhPlayerBet intValue])==0)){
        }
        else{
        [self loadBetSound];
        }
    }
    if(betPlayer.position==PlayerPositionLTop){
        [circularView0 stop];
        circularView0.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView0 play];
    }
    else if (betPlayer.position==PlayerPositionLMiddle){
        [circularView1 stop];
        circularView1.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView1 play];
    }
    else if (betPlayer.position==PlayerPositionLBottom){
        [circularView2 stop];
        circularView2.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView2 play];
    }
    else if (betPlayer.position==PlayerPositionMiddle){
        [circularView3 stop];
        circularView3.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView3 play];
        [self changeBottomButtonsColorAndText];
        UIImage *minImage = [[UIImage imageNamed:@"slider_minimum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIImage *maxImage = [[UIImage imageNamed:@"slider_maximum.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIImage *thumbImage = [UIImage imageNamed:@"sliderhandle.png"];
        [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
        [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
        [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
        sliderView =[[UIView alloc]init];
        sliderView.frame=CGRectMake(378+80*isiPhone5(), 65, 102, 225);//95
        sliderView.backgroundColor=[UIColor  colorWithPatternImage:[UIImage imageNamed:@"rating_bg"]];
        [self.view addSubview:sliderView];
        CGRect frame = CGRectMake(-30.0, 110.0, 165, 20.0);
        slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.transform=CGAffineTransformRotate(slider.transform,270.0/180*M_PI);
        slider.minimumValue = 1.0;
        slider.maximumValue = 50.0;
        slider.continuous = YES;
        slider.value = 1.0;
        [sliderView addSubview:slider];
        
        amountLbl = [[UILabel alloc] init];
        amountLbl.frame = CGRectMake(30,5,45 , 24);//175
        amountLbl.textAlignment = NSTextAlignmentCenter;
        amountLbl.textColor = [UIColor  whiteColor];
        amountLbl.font =[UIFont fontWithName:@"ArialMT" size:16];
        amountLbl.backgroundColor = [UIColor clearColor];
        amountLbl.clipsToBounds=YES;
        amountLbl.layer.cornerRadius=5;
        amountLbl.text=[NSString stringWithFormat:@"1k"];
        [sliderView addSubview:amountLbl];
        
        /***
         * Conform Button
         **/
        UIButton *conformButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [conformButton addTarget:self
                          action:@selector(conformButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
        conformButton.backgroundColor =[UIColor clearColor];
        [conformButton setBackgroundImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
        conformButton.frame = CGRectMake(20, 200, 63, 23);
        [sliderView addSubview:conformButton];
    }
    else if (betPlayer.position==PlayerPositionRBottom){
        [circularView4 stop];
        circularView4.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView4 play];
    }
    else if (betPlayer.position==PlayerPositionRMiddle){
        [circularView5 stop];
        circularView5.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView5 play];
    }
    else if (betPlayer.position==PlayerPositionRTop){
        [circularView6 stop];
        circularView6.audioPath= [[NSBundle mainBundle] URLForResource:@"BetLength" withExtension:@"mp4"];
        [circularView6 play];
    }
}
-(void)sliderAction:(id)sender{
    UISlider *sliderr = (UISlider*)sender;
    int value = sliderr.value;
    amountLbl.text=[NSString stringWithFormat:@"%dk",value];
    Player *player =[game activePlayer];
    NSString * str = amountLbl.text;
    if ( [str length] > 0 ){
        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
    }
    if([str intValue]>[player.Score intValue]){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"IsFirstTime"]){
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"IsFirstTime"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"All in." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm",nil];
            alert.tag=555;
            [alert show];
        }
    }
}

-(void)conformButtonPressed{
    NSString * str = amountLbl.text;
    if ( [str length] > 0 ){
        str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
    }
    NSString *value =callAmount;
    if ( [value length] > 0 ){
        value = [value stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
    }
    if([str intValue]<[value intValue]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Bet amount should be greater than %@",callAmount ] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [sliderView removeFromSuperview];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[game activePlayer].ID forKey: @"UserId"];
        [dict setObject:@"Bet" forKey:@"type"];
        [dict setObject:amountLbl.text forKey:@"Amount"];
        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
        [checkButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [callButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [foldButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [allinButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
        [betButton setBackgroundImage:[UIImage imageNamed:@"black_withborder"] forState:UIControlStateNormal];
    }
}
-(void)actionForBetButton:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    NSString * amount = [responseDict objectForKey: @"Amount"];
    Player *betPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    if(betPlayer.position==PlayerPositionLTop){
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionLMiddle){
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionLBottom){
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionMiddle){
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionRBottom){
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionRMiddle){
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    else if (betPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"";
        [self addBetAmountInFrontOfPlayers:betPlayer.position withAmount:amount];
    }
    game._activePlayerPosition++;
    [game turnCardForActivePlayer];
}
#pragma mark SitOut Button Action

-(void)sitOutButtonPressed{
    ActiveAtPositionMiddle =NO;
    fouthbedirBG.alpha=0.5;
    for(int i=0;i<2;i++){
        CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
        [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
    }
}
#pragma mark Leave Button Action
-(void)leaveButtonPressed{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Are you sure to exit?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Sitout",@"Leave",nil];
    alert.tag=111;
    [alert show];
}
-(void)actionForSitOutButton:(NSDictionary *)responseDict{
    NSString * userId = [responseDict objectForKey: @"UserId"];
    Player *foldedPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%@",userId]];
    if(foldedPlayer.position==PlayerPositionLTop){
        firstbedirBG.alpha=0.5;
        circularView0.hidden=YES;
        [circularView0 stop];
        firtPlayerstatusLabel.text=@"SitOut";
        [firstProfileImageBG removeFromSuperview];
        [firstProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLTop ==NO){
        }
        ActiveAtPositionLTop =YES;
    }
    else if (foldedPlayer.position==PlayerPositionLMiddle){
        secondbedirBG.alpha=0.5;
        circularView1.hidden=YES;
        [circularView1 stop];
        secondPlayerstatusLabel.text=@"SitOut";
        [secondProfileImageBG removeFromSuperview];
        [secondProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLMiddle ==NO){
        }
        ActiveAtPositionLMiddle =YES;
    }
    else if (foldedPlayer.position==PlayerPositionLBottom){
        thirdbedirBG.alpha=0.5;
        circularView2.hidden=YES;
        [circularView2 stop];
        thirdPlayerstatusLabel.text=@"SitOut";
        [thirdProfileImageBG removeFromSuperview];
        [thirdProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionLBottom ==NO){
        }
        ActiveAtPositionLBottom =YES;
    }
    else if (foldedPlayer.position==PlayerPositionMiddle){
        fouthbedirBG.alpha=0.5;
        circularView3.hidden=YES;
        [circularView3 stop];
        fourthPlayerstatusLabel.text=@"SitOut";
        NSMutableArray *array =[[NSMutableArray alloc]init];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:foldedPlayer.ID forKey:@"Id"];
        [dict setValue:foldedPlayer.Score forKey:@"FinalScore"];
        [dict setValue:foldedPlayer.serverindex forKey:@"index"];
        [dict setValue:@"0" forKey:@"Points"];
        [array addObject:dict];
        NSString *jsonserverArray = [array JSONRepresentation];
        dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *_response;
            NSError* _error = nil;
            NSString *_urlString = [NSString stringWithFormat:BaseUrl];
            NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
            NSString *_params = [NSString stringWithFormat:@"operation=fold_game_info&game_level=%@&player_info=%@&table_number=%@",appDelegate().LevelName,jsonserverArray,appDelegate().tableNumber];
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
                }
                @catch (NSException *exception) {
                }
            });
        });
        for(int i=0;i<2;i++){
            CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
            [cardView animateCloseAndMoveFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        if(ActiveAtPositionMiddle ==NO){
        }
        ActiveAtPositionMiddle =YES;
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
    }
    else if (foldedPlayer.position==PlayerPositionRBottom){
        fifthbedirBG.alpha=0.5;
        circularView4.hidden=YES;
        [circularView4 stop];
        fifthPlayerstatusLabel.text=@"Fold"; [fifthProfileImageBG removeFromSuperview];
        [fifthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRBottom ==NO){
        }
        ActiveAtPositionRBottom =YES;
    }
    else if (foldedPlayer.position==PlayerPositionRMiddle){
        sixthbedirBG.alpha=0.5;
        circularView5.hidden=YES;
        [circularView5 stop];
        sixthPlayerstatusLabel.text=@"SitOut";
        [sixthProfileImageBG removeFromSuperview];
        [sixthProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRMiddle ==NO){
        }
        ActiveAtPositionRMiddle =YES;
    }
    else if (foldedPlayer.position==PlayerPositionRTop){
        circularView6.hidden=YES;
        [circularView6 stop];
        seventhPlayerstatusLabel.text=@"SitOut";
        [seventhProfileImageBG removeFromSuperview];
        [seventhProfileImageBG setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"Image.png"]];
        for(int i=0;i<2;i++){
            Card *card = [foldedPlayer turnOverTopCard];
            CardView *cardView = [self cardViewForCard:card];
            [cardView animateCloseAndRemoveFoldCardsFromPlayer:PlayerPositionLTop value:cardView.card.value];
        }
        [foldedPlayer.openCards removeAllCards];
        [foldedPlayer.closedCards removeAllCards];
        foldedPlayer.status=@"Not Active";
        if(ActiveAtPositionRTop ==NO){
        }
        ActiveAtPositionRTop =YES;
    }
    [NSTimer scheduledTimerWithTimeInterval:2//1sec
                                     target:self
                                   selector:@selector(RemoveStatusText)
                                   userInfo:nil
                                    repeats:NO];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==111&buttonIndex==2||alertView.tag==444 ||(alertView.tag==333 && buttonIndex==1)||(alertView.tag==666 && buttonIndex==0)){
        PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
        [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
            if(subscriptionError != nil){
            }
            else{
            }
        }];
        [[PNObservationCenter defaultCenter] removeMessageReceiveObserver:self];
        [[PNObservationCenter defaultCenter] removeMessageReceiveObserver:game];
        [[PNObservationCenter defaultCenter] removeClientConnectionStateObserver:self];
        [[PNObservationCenter defaultCenter]removePresenceEventObserver:self];
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Leaving Table..."];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        NSMutableString *postData;
        if(gameStarted){
        postData = [NSMutableString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=Yes",appDelegate().tableNumber,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
        }
        else{
         postData = [NSMutableString stringWithFormat:@"operation=exit_table&table_num=%@&user_id=%@&error=No",appDelegate().tableNumber,[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]];
        }
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonDataExitTableResponse:)];
        objAPI = nil;
    }
    else if (alertView.tag==111&buttonIndex==1){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]] forKey: @"UserId"];
        [dict setObject:@"SitOut" forKey:@"type"];
        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
    }
    else if (alertView.tag==222){
        PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
        [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
            if(subscriptionError != nil){
            }
            else{
            }
        }];
        [[PNObservationCenter defaultCenter] removeMessageReceiveObserver:self];
        [[PNObservationCenter defaultCenter] removeMessageReceiveObserver:game];
        [[PNObservationCenter defaultCenter] removeClientConnectionStateObserver:self];
        [[PNObservationCenter defaultCenter] removePresenceEventObserver:self];
        isPoped=YES;
        [myQueue cancelAllOperations];
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
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"winningConditions" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
            for (UIViewController *aViewController in allViewControllers) {
                if ([aViewController isKindOfClass:[SelectViewController class]]) {
                    [self.navigationController popToViewController:aViewController animated:NO];
                }
            }
        });
    }
    else if (alertView.tag==333){
         if (buttonIndex==0){
            PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber shouldObservePresence:YES];
            [PubNub subscribeOnChannel: channel_self];
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            self.progressView = [objAPI createProgressViewToParentView:self.view withTitle:@"Please wait"];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=play_now&user_id=%@&game_level=%@&buy_ins=%@&buy_inPoints=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"],appDelegate().LevelName,[[NSUserDefaults standardUserDefaults] valueForKey:@"Buyins"],appDelegate().buyInValue];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonPlayNowResponse:)];
            objAPI = nil;
        }
    }
    else if (alertView.tag==555){
        if(buttonIndex==0){
        [self conformButtonPressed];
        }
    }
}
-(void)jsonPlayNowResponse:(id)responseDict{
    
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    [appDelegate().clients removeAllObjects];
    if([[responseDict valueForKey:@"success"]integerValue ]==1){
        if([[responseDict valueForKey:@"data"] count]>0){
            for(int i=0;i<7;i++){
                if(![[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]isEqual:@""]){
                    [appDelegate().clients addObject:[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]];
                }
            }
        appDelegate().tableNumber =[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"table_number"]];
        [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"table_number"]] forKey:@"Tablenumber" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if(appDelegate().clients.count>=2){
            appDelegate().gameStarted=[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"]valueForKey:@"game_status"]];
            flopCradCount=0;
            round=0;
            centerLbl.text=@"new game";
            firstProfileImageBG.hidden=YES;
            secondProfileImageBG.hidden=YES;
            thirdProfileImageBG.hidden=YES;
            fifthProfileImageBG.hidden=YES;
            sixthProfileImageBG.hidden=YES;
            seventhProfileImageBG.hidden=YES;
            [firstTotalScore removeFromSuperview];
            [secondTotalScore removeFromSuperview];
            [thirdTotalScore removeFromSuperview];
            [fourthTotalScore removeFromSuperview];
            [fifthTotalScore removeFromSuperview];
            [sixthTotalScore removeFromSuperview];
            [seventhTotalScore removeFromSuperview];

            
            [_dealingCardsSound stop];
            [[AVAudioSession sharedInstance] setActive:NO error:NULL];
            
            [circularView0 stop];
            circularView0.hidden=YES;
            [circularView1  stop];
            circularView1.hidden=YES;
            [circularView2 stop];
            circularView2.hidden=YES;
            [circularView3 stop];
            circularView3.hidden=YES;
            [circularView4  stop];
            circularView4.hidden=YES;
            [circularView5 stop];
            circularView5.hidden=YES;
            [circularView6 stop];
            circularView6.hidden=YES;
            totalBetamount.hidden=YES;
            bestHandsScoreLbl.hidden=YES;
            DealerLabel.hidden=YES;
            smallBlindLabel.hidden=YES;
            bigBlindLabel.hidden=YES;
            firstbedirBG.hidden=YES;
            firstbedirBG.alpha=1.0;
            secondbedirBG.hidden=YES;
            secondbedirBG.alpha=1.0;
            thirdbedirBG.hidden=YES;
            thirdbedirBG.alpha=1.0;
            fouthbedirBG.hidden=YES;
            fouthbedirBG.alpha=1.0;
            fifthbedirBG.hidden=YES;
            fifthbedirBG.alpha=1.0;
            sixthbedirBG.hidden=YES;
            sixthbedirBG.alpha=1.0;
            seventhbedirBG.hidden=YES;
            seventhbedirBG.alpha=1.0;
            
            for (UIView *view in [bestHandsView subviews]){
                [view removeFromSuperview];
            }
            for (UIView *view in [_communityView subviews]){
                [view removeFromSuperview];
            }
            for (UIView *view in [_cardContainerView subviews]){
                [view removeFromSuperview];
            }
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showIndicatorForActivePlayer) object:Nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnRiverCards) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(winningConditions) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnFlopCards) object:nil];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(afterDealing) object:nil];//turnTurnCards
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnTurnCards) object:nil];

            if([appDelegate().gameStarted isEqualToString:@"Yes"]){
                centerLbl.text=@"Please wait for your turn";
                [self checkForGameStatus];
            }
            else{
                WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
                objAPI.showActivityIndicator = YES;
                NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
                
                NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=table_information&table_number=%@&dealer=%@",appDelegate().tableNumber,appDelegate().dealerId];
                [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonUpdatedTableDataResponse:)];
                objAPI = nil;
            }
        }
        else {
            WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
            objAPI.showActivityIndicator = YES;
            NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
            NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=table_information&table_number=%@&dealer=%@",appDelegate().tableNumber,appDelegate().dealerId];
            [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonUpdatedTableDataResponse:)];
            objAPI = nil;
        }
    }
    }
    else{
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        [objAPI hideProgressView:self.progressView];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"You don't have enough credits in your bank account." delegate:self
                                              cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        alert.tag=666;
        [alert show];
    }
}
-(void)jsonDataExitTableResponse:(id)responseDict{
    appDelegate().tableNumber=nil;
    [_dealingCardsSound stop];
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    if([[responseDict valueForKey:@"success"]integerValue ]==1){
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
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"winningConditions" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
        isPoped=YES;
        [myQueue cancelAllOperations];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
        });
    }
    else if([[responseDict valueForKey:@"success"] integerValue]==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation" message:[responseDict valueForKey:@"description"] delegate:nil
                                              cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        [alert show];
    }
}
#pragma mark Rules Button Action

-(void)rulesButtonPressed{
    [rulesView ShowViewWithRules:self.view];
}

-(void)checkForRoundCompletion{
    round=round+1;
    Player *startingPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
    game._activePlayerPosition = startingPlayer.position;
    [self performSelector:@selector(showIndicatorForActivePlayer) withObject:nil afterDelay:0.5];
}
#pragma mark Updating Flop Cards

- (void)updateFlopCards{
    callAmount=@"0";
    game.betValue=@"0";
    game.firstPlayerBet=@"0";
    game.secondPlayerBet=@"0";
    game.thirdPlayerBet=@"0";
    game.fourthPlayerBet=@"0";
    game.fifthPlayerBet=@"0";
    game.sixthPlayerBet=@"0";
    game.seventhPlayerBet=@"0";
    NSTimeInterval delayy = 1.0f;
    [self performSelector:@selector(turnFlopCards) withObject:Nil afterDelay:delayy];
    NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
    for(int i=0;i<=7;i++){
        Player *allPlayers =[game playerAtPosition:i];
        if (allPlayers != nil ){
            int value = [allPlayers.Score intValue];
            [allPlayersScore addObject:[NSNumber numberWithInt:value]];
        }
    }
    NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    allInAmount=[filteredArray objectAtIndex:0];
}
-(void)turnFlopCards{
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
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
         potValue =0;
         NSMutableArray *labelsarray =[[NSMutableArray alloc]initWithObjects:firstScoreLabel.text,secondScoreLabel.text,thirdScoreLabel.text,fourthScoreLabel.text,fifthScoreLabel.text,sixthScoreLabel.text,seventhScoreLabel.text ,nil];
         for(int a=0;a<labelsarray.count;a++){
         NSString * str = [labelsarray objectAtIndex:a];
         if ( [str length] > 0 ){
             if ([str rangeOfString:@"k"].location == NSNotFound){
             }
             else{
                 if([str rangeOfString:@"."].location == NSNotFound)
                     str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                 else
                     str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
             }
             if ([str rangeOfString:@"M"].location == NSNotFound){
             }
             else{
                if([str rangeOfString:@"."].location == NSNotFound)
                str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                 else
                 str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
             }
             if ([str rangeOfString:@"B"].location == NSNotFound){
             }
             else{
                 if([str rangeOfString:@"."].location == NSNotFound)
                 str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                 else
                 str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
             }
             NSString * newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
             potValue =potValue+[newString longLongValue];
         }
         }
         NSTimeInterval delayy = 1.0f;
         
         for (int t = 0; t < 2; ++t){
             if ([appDelegate().cummulativeCards count]>0){
                 CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                 cardView.card = [appDelegate().cummulativeCards objectAtIndex:t];
                 if(t==0)
                     cardView.isFirst=NO;
                 else
                     cardView.isFirst=YES;
                 [self.communityView addSubview:cardView];
                 [cardView animateFlopCardswithDelay:delayy];
                 delayy += 0.1f;
                 if(t==1){
                     isfirst=YES;
                 }
                 ;
             }
         }
         [self performSelector:@selector(frontEndOfFlopCards) withObject:Nil afterDelay:2.0];
     }];
}

-(void)frontEndOfFlopCards{
    Card *card = [appDelegate().cummulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    CardView *cardView = [self communityCardViewForCard:card];
    
    [cardView animateFlopCardsTurnOverWithsuccess:^()
     {
         if(isfirst ==YES)
         {
             isfirst=NO;
             flopCradCount=flopCradCount+1;
             [self frontEndOfFlopCards];
         }
         else
         {
             flopCradCount=flopCradCount+1;
             for (UIView *view in [bestHandsView subviews])
             {
                 [view removeFromSuperview];
             }
             
             int finalValue =0;
             int firstValue=0;
             int secondValue =0;
             NSArray *bestHands =[NSArray bestHandsInFlopCardsWithOpencards:myOpencards];
             NSString *firstString =[[bestHands valueForKey:@"Suit"] objectAtIndex:0];
             NSString *secondString =[[bestHands valueForKey:@"Suit"] objectAtIndex:1];
             NSString *thirdString;
             if(bestHands.count>2)
             thirdString =[[bestHands valueForKey:@"Suit"] objectAtIndex:2];
             if(bestHands.count>2){
             if([firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString]){
                 for(int i=0;i<3;i++){
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue;
             }
             else if ([firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString])
             {    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=0;i<2;i++){
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=0;i<2;i++)
                     {
                         if(i==0)
                             finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                         else if (i==1)
                             finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&![secondString isEqualToString:thirdString])
             {   //for(int i=0;i<3;i++){
                 if([[[bestHands valueForKey:@"Type"] objectAtIndex:0] isEqualToString:@"HoleCard"]){
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 }
                 else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:1] isEqualToString:@"HoleCard"]){
                    finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 }
                 else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:2] isEqualToString:@"HoleCard"]){
                   finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 secondValue =secondValue;
             //}
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&[secondString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:0];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=1;i<3;i++){
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
             }
             }
             else{
                 if([firstString isEqualToString:secondString])
                 {
                     for(int i=0;i<2;i++)
                     {
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                     firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                     secondValue =secondValue;
                 }
                 else{
                     for(int i=0;i<2;i++)
                     {   if ([[[bestHands valueForKey:@"Type"] objectAtIndex:i] isEqualToString:@"HoleCard"]){
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                     }
                     firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                     secondValue =secondValue;
                 }
             }
             for (int t = 0; t < bestHands.count; ++t)
             {
                 CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
                 cardView.card = [[bestHands valueForKey:@"Card"] objectAtIndex:t];
                 if(t==0)
                     cardView.isFirst=NO;
                 else
                     cardView.isFirst=YES;
                 [bestHandsView addSubview:cardView];
                 [cardView animateBestHandsCardsWithDelay:1.0];
             }
             [bestHandsArray removeAllObjects];
             [bestHandsArray addObjectsFromArray:[bestHands valueForKey:@"Card"] ];
             
             isFirstBestCard=YES;
             [self frontEndOfBestHandCards];
             bestHandsScoreLbl.hidden=NO;
             if(firstValue>secondValue)
             bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",firstValue];
             else
             bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",secondValue];
             round=round+1;
             //game._activePlayerPosition=0;
             Player *startingPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
             game._activePlayerPosition = startingPlayer.position;
             [self performSelector:@selector(showIndicatorForActivePlayer) withObject:nil afterDelay:1.0];
             
         }
         FirstPlayerscoreView.hidden=YES;
         secondPlayerscoreView.hidden=YES;
         thirdPlayerscoreView.hidden=YES;
         fouthPlayerscoreView.hidden=YES;
         fifthPlayerscoreView.hidden=YES;
         sixthPlayerscoreView.hidden=YES;
         seventhPlayerscoreView.hidden=YES;
         totalBetamount.hidden=NO;
         firstScoreLabel.text=@"";
         secondScoreLabel.text=@"";
         thirdScoreLabel.text=@"";
         fourthScoreLabel.text=@"";
         fifthScoreLabel.text=@"";
         sixthScoreLabel.text=@"";
         seventhScoreLabel.text=@"";
         totalScoreLabel.text=[self abbreviateNumber:potValue];
         firtPlayerstatusLabel.text=@"";
         secondPlayerstatusLabel.text=@"";
         thirdPlayerstatusLabel.text=@"";
         fourthPlayerstatusLabel.text=@"";
         fifthPlayerstatusLabel.text=@"";
         sixthPlayerstatusLabel.text=@"";
         seventhPlayerstatusLabel.text=@"";
         
     }];
}
-(NSString *)abbreviateNumber:(long long int)num {
    NSString *abbrevNum;
    float number = (float)num;
    if (num >= 1000) {
        NSArray *abbrev = @[@"k",@"M",@"B"];
        for (int i = abbrev.count - 1; i >= 0; i--) {
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            if(size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K instead of 1K
                number = number/size;
                NSString *numberString = [self floatToString:number];
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
        }
    } else {
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    return abbrevNum;
}
- (NSString *) floatToString:(float) val {
    NSString *ret = [NSString stringWithFormat:@"%.1f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    while (c == 48) { // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        //After finding the "." we know that everything left is the decimal number, so get a substring excluding the "."
        if(c == 46) { // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    return ret;
}
-(void)frontEndOfBestHandCards{
    Card *card;
    if(isFirstBestCard ==YES){
        card = [bestHandsArray objectAtIndex:0];
    }
    else if(isSecondBestCard ==YES){
        card = [bestHandsArray objectAtIndex:1];
    }
    else if(isThirdBestCard ==YES){
        card = [bestHandsArray objectAtIndex:2];
    }
    card.isTurnedOver=YES;
    CardView *cardView = [self bestHandCardViewForCard:card];
    if(isFirstBestCard ==YES){
        cardView.isFirstBestCard=YES;
        cardView.isSecondBestCard=NO;
        cardView.isThirdBestCard=NO;
    }
    else  if(isSecondBestCard ==YES){
        cardView.isFirstBestCard=NO;
        cardView.isSecondBestCard=YES;
        cardView.isThirdBestCard=NO;
    }
    else  if(isThirdBestCard ==YES){
        cardView.isFirstBestCard=NO;
        cardView.isSecondBestCard=NO;
        cardView.isThirdBestCard=YES;
    }
    [cardView animateBestHandCardsTurnOverWithsuccess:^(){
         if(isFirstBestCard ==YES){
             isFirstBestCard=NO;
             isSecondBestCard=YES;
             isThirdBestCard=NO;
             if(bestHandsArray.count>1)
                 [self frontEndOfBestHandCards];
         }
         else if(isSecondBestCard ==YES){
             isFirstBestCard=NO;
             isSecondBestCard=NO;
             isThirdBestCard=YES;
             if(bestHandsArray.count>2)
                 [self frontEndOfBestHandCards];
         }
     }];
}
#pragma mark Updating Turn Cards

-(void)updateTurnCard{
    callAmount=@"0";
    game.betValue=@"0";
    game.firstPlayerBet=@"0";
    game.secondPlayerBet=@"0";
    game.thirdPlayerBet=@"0";
    game.fourthPlayerBet=@"0";
    game.fifthPlayerBet=@"0";
    game.sixthPlayerBet=@"0";
    game.seventhPlayerBet=@"0";
    NSTimeInterval delayy = 1.0f;
    [self performSelector:@selector(turnTurnCards) withObject:Nil afterDelay:delayy];
    NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
    for(int i=0;i<=7;i++){
        Player *allPlayers =[game playerAtPosition:i];
        if (allPlayers != nil ){
            int value = [allPlayers.Score intValue];
            [allPlayersScore addObject:[NSNumber numberWithInt:value]];
        }
    }
    NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    allInAmount=[filteredArray objectAtIndex:0];
}
-(void)turnTurnCards{
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
    }
                     completion:^(BOOL finished){
         NSMutableArray *labelsarray =[[NSMutableArray alloc]initWithObjects:firstScoreLabel.text,secondScoreLabel.text,thirdScoreLabel.text,fourthScoreLabel.text,fifthScoreLabel.text,sixthScoreLabel.text,seventhScoreLabel.text ,nil];
         for(int a=0;a<labelsarray.count;a++){
             NSString * str = [labelsarray objectAtIndex:a];
             if ( [str length] > 0 ){
                 if ([str rangeOfString:@"k"].location == NSNotFound){
                 }
                 else{
                     if([str rangeOfString:@"."].location == NSNotFound)
                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                     else
                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                 }
                 if ([str rangeOfString:@"M"].location == NSNotFound){
                 }
                 else{
                     if([str rangeOfString:@"."].location == NSNotFound)
                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                     else
                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                 }
                 if ([str rangeOfString:@"B"].location == NSNotFound) {
                 }
                 else{
                     if([str rangeOfString:@"."].location == NSNotFound)
                     str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                 else
                     str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                 }
                 NSString * newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                 potValue =potValue+[newString longLongValue];
             }
         }
         NSTimeInterval delayy = 1.0f;
         for (int t = 2; t < 4; ++t){
             if ([appDelegate().cummulativeCards count]>0){
                 CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                 cardView.card = [appDelegate().cummulativeCards objectAtIndex:t];
                 [bestHandsArray addObject:[appDelegate().cummulativeCards objectAtIndex:t]];
                 if(t==2)
                     cardView.isFirst=NO;
                 else
                     cardView.isFirst=YES;
                 [self.communityView addSubview:cardView];
                 [cardView animateTurnCardswithDelay:delayy];
                 delayy += 0.1f;
                 if(t==3){
                     isfirst=YES;
                 }
             }
         }
        [self performSelector:@selector(frontEndOfTurnCards) withObject:Nil afterDelay:2.0];
     }];
}

-(void)frontEndOfTurnCards{
    Card *card = [appDelegate().cummulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    CardView *cardView = [self communityCardViewForCard:card];
    
    [cardView animateTurnCardsTurnOverWithsuccess:^()
     {
         if(isfirst ==YES)
         {
             isfirst=NO;
             flopCradCount=flopCradCount+1;
             [self frontEndOfTurnCards];
         }
         else
         {
             flopCradCount=flopCradCount+1;
             
             for (UIView *view in [bestHandsView subviews])
             {
                 [view removeFromSuperview];
             }
             NSArray *bestHands =[NSArray bestHandsInTurnCardsWithOpencards:myOpencards];
             int finalValue =0;
             int firstValue=0;
             int secondValue =0;
             NSString *firstString =[[bestHands valueForKey:@"Suit"] objectAtIndex:0];
             NSString *secondString =[[bestHands valueForKey:@"Suit"] objectAtIndex:1];
             NSString *thirdString =[[bestHands valueForKey:@"Suit"] objectAtIndex:2];
             if([firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString])
             {
                 for(int i=0;i<3;i++)
                 {
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue;
             }
             else if ([firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString])
             {    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                 for(int i=0;i<2;i++)
                 {
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                 }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                 for(int i=0;i<2;i++)
                 {
                     if(i==0)
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                     else if (i==1)
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 }
                 }
                 else{
                   finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&![secondString isEqualToString:thirdString])
             {   if([[[bestHands valueForKey:@"Type"] objectAtIndex:0] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
             }
             else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:1] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
             }
             else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:2] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
             }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 secondValue =secondValue;
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&[secondString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:0];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                 for(int i=1;i<3;i++){
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                 }
             }
                 else{
                    finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
             }
             for (int t = 0; t < bestHands.count; ++t)
             {
                 CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
                 cardView.card = [[bestHands valueForKey:@"Card"] objectAtIndex:t];
                 if(t==0)
                     cardView.isFirst=NO;
                 else
                     cardView.isFirst=YES;
                 [bestHandsView addSubview:cardView];
                 [cardView animateBestHandsCardsWithDelay:1.0];
             }
             [bestHandsArray removeAllObjects];
             [bestHandsArray addObjectsFromArray:[bestHands valueForKey:@"Card"] ];
             isFirstBestCard=YES;
             [self frontEndOfBestHandCards];
             if(firstValue>secondValue)
                 bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",firstValue];
             else
                 bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",secondValue];
             //bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",finalValue];
             round=round+1;
             Player *startingPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
             game._activePlayerPosition = startingPlayer.position;
             [self performSelector:@selector(showIndicatorForActivePlayer) withObject:Nil afterDelay:1.0];
         }
         
         FirstPlayerscoreView.hidden=YES;
         secondPlayerscoreView.hidden=YES;
         thirdPlayerscoreView.hidden=YES;
         fouthPlayerscoreView.hidden=YES;
         fifthPlayerscoreView.hidden=YES;
         sixthPlayerscoreView.hidden=YES;
         seventhPlayerscoreView.hidden=YES;
         totalBetamount.hidden=NO;
         firstScoreLabel.text=@"";
         secondScoreLabel.text=@"";
         thirdScoreLabel.text=@"";
         fourthScoreLabel.text=@"";
         fifthScoreLabel.text=@"";
         sixthScoreLabel.text=@"";
         seventhScoreLabel.text=@"";
         totalScoreLabel.text=[self abbreviateNumber:potValue];
         firtPlayerstatusLabel.text=@"";
         secondPlayerstatusLabel.text=@"";
         thirdPlayerstatusLabel.text=@"";
         fourthPlayerstatusLabel.text=@"";
         fifthPlayerstatusLabel.text=@"";
         sixthPlayerstatusLabel.text=@"";
         seventhPlayerstatusLabel.text=@"";
     }];
}
#pragma mark Updating River Cards

-(void)updateRiverCard{
    callAmount=@"0";
    game.betValue=@"0";
    game.firstPlayerBet=@"0";
    game.secondPlayerBet=@"0";
    game.thirdPlayerBet=@"0";
    game.fourthPlayerBet=@"0";
    game.fifthPlayerBet=@"0";
    game.sixthPlayerBet=@"0";
    game.seventhPlayerBet=@"0";
    NSTimeInterval delayy = 1.0f;
    [self performSelector:@selector(turnRiverCards) withObject:Nil afterDelay:delayy];
    NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
    for(int i=0;i<=7;i++){
        Player *allPlayers =[game playerAtPosition:i];
        if (allPlayers != nil ){
            int value = [allPlayers.Score intValue];
            [allPlayersScore addObject:[NSNumber numberWithInt:value]];
        }
    }
    NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    allInAmount=[filteredArray objectAtIndex:0];
}
-(void)turnRiverCards{
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
    }
                     completion:^(BOOL finished){
         NSMutableArray *labelsarray =[[NSMutableArray alloc]initWithObjects:firstScoreLabel.text,secondScoreLabel.text,thirdScoreLabel.text,fourthScoreLabel.text,fifthScoreLabel.text,sixthScoreLabel.text,seventhScoreLabel.text ,nil];
         for(int a=0;a<labelsarray.count;a++) {
             NSString * str = [labelsarray objectAtIndex:a];
             if ( [str length] > 0 ){
                 if ([str rangeOfString:@"k"].location == NSNotFound){
                 }
                 else{
                     if([str rangeOfString:@"."].location == NSNotFound)
                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                     else
                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                 }
                 if ([str rangeOfString:@"M"].location == NSNotFound){
                 }
                 else {
                     if([str rangeOfString:@"."].location == NSNotFound)
                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                     else
                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                 }
                 if ([str rangeOfString:@"B"].location == NSNotFound){
                 }
                 else{
                     if([str rangeOfString:@"."].location == NSNotFound)
                     str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                 else
                     str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                 }
                 NSString * newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                 potValue =potValue+[newString intValue];
             }
         }
         NSTimeInterval delayy = 1.0f;
         for (int t = 4; t < 5; ++t){
             if ([appDelegate().cummulativeCards count]>0){
                 CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                 cardView.card = [appDelegate().cummulativeCards objectAtIndex:t];
                 [bestHandsArray addObject:[appDelegate().cummulativeCards objectAtIndex:t]];
                 if(t==4)
                     cardView.isFirst=NO;
                 [self.communityView addSubview:cardView];
                 [cardView animateRiverCardswithDelay:delayy];
                 delayy += 0.1f;
                 if(t==5) {
                     isfirst=YES;
                 }
             }
         }
         [self performSelector:@selector(frontEndOfRiverCards) withObject:Nil afterDelay:2.0];
     }];
}
-(void)frontEndOfRiverCards{
    Card *card = [appDelegate().cummulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    CardView *cardView = [self communityCardViewForCard:card];
    [cardView animateRiverCardsTurnOverWithsuccess:^(){
         if(isfirst ==YES){
             isfirst=NO;
             //[self  turnsAllPlayersCards];
         }
         else{
             game._activePlayerPosition=PlayerPositionMiddle;
           //  [self  turnsAllPlayersCards];
             for (UIView *view in [bestHandsView subviews]){
                 [view removeFromSuperview];
             }
             NSArray *bestHands =[NSArray bestHandsInRiverCardsWithOpencards:myOpencards];
             int finalValue =0;
             int firstValue=0;
             int secondValue =0;
             NSString *firstString =[[bestHands valueForKey:@"Suit"] objectAtIndex:0];
             NSString *secondString =[[bestHands valueForKey:@"Suit"] objectAtIndex:1];
             NSString *thirdString =[[bestHands valueForKey:@"Suit"] objectAtIndex:2];
             if([firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString])
             {
                 for(int i=0;i<3;i++)
                 {
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue;
             }
             else if ([firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString])
             {    NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=0;i<2;i++)
                     {
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&[firstString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:2];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=0;i<2;i++)
                     {
                         if(i==0)
                             finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                         else if (i==1)
                             finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&![secondString isEqualToString:thirdString])
             {   if([[[bestHands valueForKey:@"Type"] objectAtIndex:0] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
             }
             else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:1] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue];
             }
             else if ([[[bestHands valueForKey:@"Type"] objectAtIndex:2] isEqualToString:@"HoleCard"]){
                 finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
             }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 secondValue =secondValue;
             }
             else if (![firstString isEqualToString:secondString]&&![firstString isEqualToString:thirdString]&&[secondString isEqualToString:thirdString])
             {
                 NSMutableArray *tempArray =[[NSMutableArray alloc]initWithArray:bestHands];
                 [tempArray removeObjectAtIndex:0];
                 if([[tempArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
                     for(int i=1;i<3;i++){
                         finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:i] intValue];
                     }
                 }
                 else{
                     finalValue=finalValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
                 }
                 firstValue =firstValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:1] intValue]+[[[bestHands valueForKey:@"Value"] objectAtIndex:2] intValue];
                 secondValue =secondValue+[[[bestHands valueForKey:@"Value"] objectAtIndex:0] intValue];
             }
                 for (int t = 0; t < bestHands.count; ++t){
                     CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 15, 25)];
                     cardView.card = [[bestHands valueForKey:@"Card"] objectAtIndex:t];
                     if(t==0)
                         cardView.isFirst=NO;
                     else
                         cardView.isFirst=YES;
                     [bestHandsView addSubview:cardView];
                     [cardView animateBestHandsCardsWithDelay:1.0];
                 }
                 [bestHandsArray removeAllObjects];
                 [bestHandsArray addObjectsFromArray:[bestHands valueForKey:@"Card"] ];
             isFirstBestCard=YES;
             [self frontEndOfBestHandCards];
             if(firstValue>secondValue)
                 bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",firstValue];
             else
                 bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",secondValue];
              //bestHandsScoreLbl.text=[NSString stringWithFormat:@"%d",finalValue];
             round=round+1;
             Player *startingPlayer = [game playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
             game._activePlayerPosition = startingPlayer.position;
             [self performSelector:@selector(showIndicatorForActivePlayer) withObject:Nil afterDelay:1.0];
         }
             ////[self performSelector:@selector(winningConditions) withObject:Nil afterDelay:4.0];
             FirstPlayerscoreView.hidden=YES;
             secondPlayerscoreView.hidden=YES;
             thirdPlayerscoreView.hidden=YES;
             fouthPlayerscoreView.hidden=YES;
             fifthPlayerscoreView.hidden=YES;
             sixthPlayerscoreView.hidden=YES;
             seventhPlayerscoreView.hidden=YES;
             totalBetamount.hidden=NO;
             firstScoreLabel.text=@"";
             secondScoreLabel.text=@"";
             thirdScoreLabel.text=@"";
             fourthScoreLabel.text=@"";
             fifthScoreLabel.text=@"";
             sixthScoreLabel.text=@"";
             seventhScoreLabel.text=@"";
            totalScoreLabel.text=[self abbreviateNumber:potValue ];
             firtPlayerstatusLabel.text=@"";
             secondPlayerstatusLabel.text=@"";
             thirdPlayerstatusLabel.text=@"";
             fourthPlayerstatusLabel.text=@"";
             fifthPlayerstatusLabel.text=@"";
             sixthPlayerstatusLabel.text=@"";
             seventhPlayerstatusLabel.text=@"";
         
     }];
}
#pragma mark Turn All Player Cards

-(void)turnsAllPlayersCards{
    [game activePlayerForWinningConditions];
    //Player *player =[game activePlayer];
    if(game._activePlayerPosition>PlayerPositionRTop){
        _activePlayerPosition = PlayerPositionLTop;
        [self turnAllCardsForAllPlayers:[game activePlayer]];
    }
    else if (game._activePlayerPosition == PlayerPositionMiddle){
        if(isfirst ==NO){
            isfirst=YES;
        }
        else if (isfirst==YES){
            game._activePlayerPosition=PlayerPositionMiddle;
            return;
        }
        [self turnsAllPlayersCards];
        return;
    }
    else{
        [self turnAllCardsForAllPlayers:[game activePlayer]];
    }
}
-(void)turnAllCardsForAllPlayers:(Player*)player{
    NSAssert([player.closedCards cardCount] > 0, @"Player has no more cards");
    if( [player.closedCards cardCount]>0){
        Card *card = [player turnOverTopCard];
        CardView *cardView = [self cardViewForCard:card];
        if(isfirst ==NO)
            cardView.isFirst=YES;
        else
            cardView.isFirst=NO;
        [cardView animateTurningOverForAllPlayer:player success:^(){
             [self turnsAllPlayersCards];
             
         }];
    }
    else{
        [self turnsAllPlayersCards];
    }
}
#pragma mark Winnning conditions
-(void)CheckForWin{
        callAmount=@"0";
        game.betValue=@"0";
        game.firstPlayerBet=@"0";
        game.secondPlayerBet=@"0";
        game.thirdPlayerBet=@"0";
        game.fourthPlayerBet=@"0";
        game.fifthPlayerBet=@"0";
        game.sixthPlayerBet=@"0";
        game.seventhPlayerBet=@"0";
        NSTimeInterval delayy = 1.0f;
        [self performSelector:@selector(checkFinalCards) withObject:Nil afterDelay:delayy];
    NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
    for(int i=0;i<=7;i++){
        Player *allPlayers =[game playerAtPosition:i];
        if (allPlayers != nil ){
            int value = [allPlayers.Score intValue];
            [allPlayersScore addObject:[NSNumber numberWithInt:value]];
        }
    }
    NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    allInAmount=[filteredArray objectAtIndex:0];
}
-(void)checkFinalCards{
    [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        FirstPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        secondPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        thirdPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fouthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        fifthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        sixthPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
        seventhPlayerscoreView.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
    }
                     completion:^(BOOL finished){
                         NSMutableArray *labelsarray =[[NSMutableArray alloc]initWithObjects:firstScoreLabel.text,secondScoreLabel.text,thirdScoreLabel.text,fourthScoreLabel.text,fifthScoreLabel.text,sixthScoreLabel.text,seventhScoreLabel.text ,nil];
                         for(int a=0;a<labelsarray.count;a++) {
                             NSString * str = [labelsarray objectAtIndex:a];
                             if ( [str length] > 0 ){
                                 if ([str rangeOfString:@"k"].location == NSNotFound){
                                 }
                                 else{
                                     if([str rangeOfString:@"."].location == NSNotFound)
                                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"000"];
                                     else
                                         str = [str stringByReplacingOccurrencesOfString:@"k" withString:@"00"];
                                 }
                                 if ([str rangeOfString:@"M"].location == NSNotFound){
                                 }
                                 else {
                                     if([str rangeOfString:@"."].location == NSNotFound)
                                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"000000"];
                                     else
                                         str = [str stringByReplacingOccurrencesOfString:@"M" withString:@"00000"];
                                 }
                                 if ([str rangeOfString:@"B"].location == NSNotFound){
                                 }
                                 else{
                                     if([str rangeOfString:@"."].location == NSNotFound)
                                         str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"000000000"];
                                     else
                                         str = [str stringByReplacingOccurrencesOfString:@"B" withString:@"00000000"];
                                 }
                                 NSString * newString = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
                                 potValue =potValue+[newString intValue];
                             }
                         }
                         FirstPlayerscoreView.hidden=YES;
                         secondPlayerscoreView.hidden=YES;
                         thirdPlayerscoreView.hidden=YES;
                         fouthPlayerscoreView.hidden=YES;
                         fifthPlayerscoreView.hidden=YES;
                         sixthPlayerscoreView.hidden=YES;
                         seventhPlayerscoreView.hidden=YES;
                         totalBetamount.hidden=NO;
                         firstScoreLabel.text=@"";
                         secondScoreLabel.text=@"";
                         thirdScoreLabel.text=@"";
                         fourthScoreLabel.text=@"";
                         fifthScoreLabel.text=@"";
                         sixthScoreLabel.text=@"";
                         seventhScoreLabel.text=@"";
                         totalScoreLabel.text=[self abbreviateNumber:potValue];
                         firtPlayerstatusLabel.text=@"";
                         secondPlayerstatusLabel.text=@"";
                         thirdPlayerstatusLabel.text=@"";
                         fourthPlayerstatusLabel.text=@"";
                         fifthPlayerstatusLabel.text=@"";
                         sixthPlayerstatusLabel.text=@"";
                         seventhPlayerstatusLabel.text=@"";
                         game._activePlayerPosition=PlayerPositionMiddle;
                         [self turnsAllPlayersCards];
                         [self performSelector:@selector(winningConditions) withObject:Nil afterDelay:4.0];
                     }];
}
-(void)winningConditions{
  
    firsttotal=0;
    secondtotal=0;
    [final1 removeAllObjects];
    [final2 removeAllObjects];
    [first removeAllObjects];
    [second removeAllObjects];
    if(game._activePlayerPosition>PlayerPositionRTop){
        NSMutableArray *filteredArray;
        if(scoreArray.count>0) {
        filteredArray = [scoreArray mutableCopy];
        }
        else{
            [self restartTheGame];
            return;
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Score" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        NSMutableArray *cardsArray =[[NSMutableArray alloc]init];
        if(filteredArray.count>=2){
            if(filteredArray.count>=3){
                if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                    for(int i=0;i<3;i++){
                        [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"] objectAtIndex:i]  ];
                    }
                }
                else if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                    for(int i=0;i<2;i++) {
                        [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"]objectAtIndex:i] ];
                    }
                }
                else{
                    [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"]objectAtIndex:0 ] ];
                }
            }
            else{
                if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                    for(int i=0;i<2;i++){
                        [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"]objectAtIndex:i] ];
                    }
                }
                else{
                    [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"]objectAtIndex:0 ] ];
                }
            }
        }
        else{
            [cardsArray addObjectsFromArray:[[filteredArray valueForKey:@"Cards"]objectAtIndex:0 ] ];
        }
        if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==0 && ActiveAtPositionLTop==NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"]  objectAtIndex:i]];
                [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];{
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3) {
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                        
                    }
                    else if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else {
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            totalBetamount.frame = CGRectMake(325.0+70*isiPhone5(), 35.0, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLTop];
                             firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            totalBetamount.frame = CGRectMake(325.0+70*isiPhone5(), 35.0, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLTop];
                             firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    totalBetamount.frame = CGRectMake(325.0+70*isiPhone5(), 35.0, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionLTop];
                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==1 && ActiveAtPositionLMiddle==NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews) {
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
            }
            for(int i=0;i<cardsArray.count;i++) {
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];{
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                        
                    }
                    else   if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(430+90*isiPhone5(), 100, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLMiddle];
                             secondPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                    
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]) {
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(430+90*isiPhone5(), 100, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLMiddle];
                             secondPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(430+90*isiPhone5(), 100, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionLMiddle];
                     secondPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==2 && ActiveAtPositionLBottom==NO){
            for (CardView *cardView in self.cardContainerView.subviews) {
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++) {
                
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]]; {
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(325+80*isiPhone5(), 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLBottom];
                             thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(325+80*isiPhone5(), 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionLBottom];
                             thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(325+80*isiPhone5(), 230, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionLBottom];
                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==3 && ActiveAtPositionMiddle == NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                {
                    [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
                }
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                {
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else  if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else {
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(225+40*isiPhone5(), 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionMiddle];
                             fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++)  {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(225+40*isiPhone5(), 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionMiddle];
                             fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(225+40*isiPhone5(), 230, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionMiddle];
                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==4 && ActiveAtPositionRBottom==NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];{
                    [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
                }
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]]; {
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])) {
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else  if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else {
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(125.0, 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRBottom];
                             fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else {
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(125.0, 230, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRBottom];
                             fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(125.0, 230, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionRBottom];
                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==5 && ActiveAtPositionRMiddle==NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++){
                
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                {
                    [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
                }
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]];
                {
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++) {
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else  if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]) {
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else {
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(30.0, 100, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRMiddle];
                             sixthPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(30.0, 100, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRMiddle];
                             sixthPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else{
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(30.0, 100, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionRMiddle];
                     sixthPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:0] integerValue] ==6 && ActiveAtPositionRTop==NO){
            for (CardView *cardView in self.cardContainerView.subviews){
                [cardView animateRecycleForAllPlayers];
            }
            for (CardView *cardView in self.communityView.subviews) {
                [cardView animateRecycleForAllPlayers];
            }
            for(int i=0;i<cardsArray.count;i++) {
                CardView *bestCard = [self cardViewForCard:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]]; {
                    [bestCard animateBestHandCardsForAllPlayersWithValue:bestCard.card.value];
                }
            }
            for(int i=0;i<cardsArray.count;i++){
                CardView *bestCummCard = [self cardViewForCardInCummunity:[[cardsArray valueForKey:@"Card"] objectAtIndex:i]]; {
                    [bestCummCard animateBestHandCardsForAllPlayersWithValue:bestCummCard.card.value];
                }
            }
            if(filteredArray.count>=2){
                if(filteredArray.count>=3){
                    if(([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue])&&([[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]==[[[filteredArray valueForKey:@"Score"]objectAtIndex:2] intValue])){
                        NSString *myString = [NSString stringWithFormat:@"%@.%@.%@ TIES with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:2],[[filteredArray valueForKey:@"Score"]objectAtIndex:2],[[filteredArray valueForKey:@"Suit"]objectAtIndex:2]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/3;
                             for(int i=0;i<3;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else  if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(133+20*isiPhone5(), 35, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRTop];
                             seventhPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
                else{
                    if([[[filteredArray valueForKey:@"Score"]objectAtIndex:1] intValue] == [[[filteredArray valueForKey:@"Score"]objectAtIndex:0] intValue]){
                        NSString *myString = [NSString stringWithFormat:@"%@ with %@ %@ TIES %@ with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0],[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:1],[[filteredArray valueForKey:@"Score"]objectAtIndex:1],[[filteredArray valueForKey:@"Suit"]objectAtIndex:1]];
                        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];
                        NSRange range = [myString rangeOfString:@"TIES"];
                        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
                        centerLbl.attributedText = attString;
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        }
                                         completion:^(BOOL finished)
                         {   potValue =potValue/2;
                             for(int i=0;i<2;i++){
                                 Player *player =[game playerAtPosition:[[[filteredArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
                                 if(player.position==PlayerPositionLTop)
                                     firstPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLMiddle)
                                     secondPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionLBottom)
                                     thirdPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionMiddle)
                                     fourthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRBottom)
                                     fifthPlayerName.text = [NSString stringWithFormat:@"%@...%lld",player.name,potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRMiddle)
                                     sixthPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 else if (player.position==PlayerPositionRTop)
                                     seventhPlayerScore.text=[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                                 player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             }
                             totalBetamount.hidden=YES;
                         }];
                    }
                    else{
                        centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                        [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            totalBetamount.frame = CGRectMake(133+20*isiPhone5(), 35, 40, 30);
                        }
                                         completion:^(BOOL finished)
                         {
                             Player *player =[game playerAtPosition:PlayerPositionRTop];
                             seventhPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                             totalBetamount.hidden=YES;
                         }];
                    }
                }
            }
            else {
                centerLbl.text = [NSString stringWithFormat:@"%@ wins with %@ %@",[[filteredArray valueForKey:@"PlayerName"] objectAtIndex:0], [[filteredArray valueForKey:@"Score"]objectAtIndex:0],[[filteredArray valueForKey:@"Suit"]objectAtIndex:0]];
                [UIView animateWithDuration:0.6f delay:0.6f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    totalBetamount.frame = CGRectMake(133+20*isiPhone5(), 35, 40, 30);
                }
                                 completion:^(BOOL finished)
                 {
                     Player *player =[game playerAtPosition:PlayerPositionRTop];
                     seventhPlayerScore.text = [NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     player.Score =[NSString stringWithFormat:@"%lld",potValue+[player.Score intValue]];
                     totalBetamount.hidden=YES;
                 }];
            }
        }
        if(ActiveAtPositionMiddle ==NO){
            for(int i=0;i<2;i++){
                CardView *cardView = [self cardViewForCard:[myOpencards objectAtIndex:i]];
                if(i==0)
                    [cardView animateTheCradsToMoveAsideForPlayer:PlayerPositionLTop value:cardView.card.value OnFirstTime:YES];
                else
                    [cardView animateTheCradsToMoveAsideForPlayer:PlayerPositionLTop value:cardView.card.value OnFirstTime:NO];
            }
        }
        for(int i=0;i<filteredArray.count;i++){
            if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==0 && ActiveAtPositionLTop == NO) {
                firstTotalScore = [[UILabel alloc] init];
                firstTotalScore.frame = CGRectMake(0, 0,59,59);
                firstTotalScore.textAlignment = NSTextAlignmentCenter;
                firstTotalScore.textColor = [UIColor  whiteColor];
                firstTotalScore.layer.masksToBounds = YES;
                firstTotalScore.layer.cornerRadius=27;
                firstTotalScore.tag=1;
                firstTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
                firstTotalScore.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                firstTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [firstbedirBG addSubview:firstTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==1 && ActiveAtPositionLMiddle==NO){
                secondTotalScore = [[UILabel alloc] init];
                secondTotalScore.frame = CGRectMake(0, 0,59,59);
                secondTotalScore.textAlignment = NSTextAlignmentCenter;
                secondTotalScore.textColor = [UIColor  whiteColor];
                secondTotalScore.layer.masksToBounds = YES;
                secondTotalScore.layer.cornerRadius=27;
                secondTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
                secondTotalScore.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                secondTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [secondbedirBG addSubview:secondTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==2 && ActiveAtPositionLBottom==NO){
                thirdTotalScore = [[UILabel alloc] init];
                thirdTotalScore.frame = CGRectMake(10,0,59,59);
                thirdTotalScore.textAlignment = NSTextAlignmentCenter;
                thirdTotalScore.textColor = [UIColor  whiteColor];
                thirdTotalScore.layer.masksToBounds = YES;
                thirdTotalScore.layer.cornerRadius=27;
                thirdTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
                thirdTotalScore.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                thirdTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [thirdbedirBG addSubview:thirdTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==3 && ActiveAtPositionMiddle==NO){
                fourthTotalScore= [[UILabel alloc] init];
                fourthTotalScore.frame = CGRectMake(10,0,59,59);
                fourthTotalScore.textAlignment = NSTextAlignmentCenter;
                fourthTotalScore.textColor = [UIColor  whiteColor];
                fourthTotalScore.layer.masksToBounds = YES;
                fourthTotalScore.layer.cornerRadius=27;
                fourthTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];
                fourthTotalScore.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                fourthTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [fouthbedirBG addSubview:fourthTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==4 && ActiveAtPositionRBottom==NO)
            {
                fifthTotalScore = [[UILabel alloc] init];
                fifthTotalScore.frame = CGRectMake(10,0,59,59);
                fifthTotalScore.textAlignment = NSTextAlignmentCenter;
                fifthTotalScore.textColor = [UIColor  whiteColor];
                fifthTotalScore.layer.masksToBounds = YES;
                fifthTotalScore.layer.cornerRadius=27;
                fifthTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];//ArialMT
                fifthTotalScore.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                fifthTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [fifthbedirBG addSubview:fifthTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==5 && ActiveAtPositionRMiddle==NO) {
                sixthTotalScore = [[UILabel alloc] init];
                sixthTotalScore.frame = CGRectMake(0,0,59,59);
                sixthTotalScore.textAlignment = NSTextAlignmentCenter;
                sixthTotalScore.textColor = [UIColor  whiteColor];
                sixthTotalScore.layer.masksToBounds = YES;
                sixthTotalScore.layer.cornerRadius=27;
                sixthTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];//ArialMT
                sixthTotalScore.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                sixthTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [sixthbedirBG addSubview:sixthTotalScore];
            }
            else if([[[filteredArray valueForKey:@"PlayerPosition"]objectAtIndex:i] integerValue]==6 && ActiveAtPositionRTop==NO){
                seventhTotalScore = [[UILabel alloc] init];
                seventhTotalScore.frame = CGRectMake(0,0,59,59);
                seventhTotalScore.textAlignment = NSTextAlignmentCenter;
                seventhTotalScore.textColor = [UIColor  whiteColor];
                seventhTotalScore.layer.masksToBounds = YES;
                seventhTotalScore.layer.cornerRadius=27;
                seventhTotalScore.font =[UIFont fontWithName:@"Arial-BoldMT" size:14];//ArialMT
                seventhTotalScore.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"GlowCirlce.png"]];
                seventhTotalScore.text=[NSString stringWithFormat:@"%@",[[filteredArray valueForKey:@"Score"] objectAtIndex:i]];
                [seventhbedirBG addSubview:seventhTotalScore];
            }
        }
        NSMutableArray *serverArray =[[NSMutableArray alloc]init];
        for(int i=0;i<scoreArray.count;i++){
            Player *player =[game playerAtPosition:[[[scoreArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setValue:[[scoreArray valueForKey:@"Id"] objectAtIndex:i] forKey:@"Id"];
            [dict setValue:player.Score forKey:@"FinalScore"];
            [dict setValue:player.serverindex forKey:@"index"];
            [dict setValue:[[scoreArray valueForKey:@"Score"] objectAtIndex:i] forKey:@"Points"];
            [serverArray addObject:dict];
        }
        [self performSelector:@selector(restartTheGame) withObject:nil afterDelay:2.0];
        [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton, betButton,sitOutButton,nil]] ;
    }
    else {
        if(isfirst==YES){
            game._activePlayerPosition=0;
            isfirst=NO;
        }
        Player *player = [game activePlayer];
        if (player == nil|| [player.openCards cardCount]==0){
            game._activePlayerPosition++;
            [self winningConditions];
            return;
        }
        else{
            for(int i=0;i<2;i++){
                Card *card =[player turnOveropenCards];
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                if(i==0){
                    [dict setObject:card forKey:@"Card"];
                    [dict setObject:@"PlayerCard" forKey:@"Type"];
                    [first addObject:dict];
                    firstTime =YES;
                }
                else{
                    Card *firstcardsuit =[[first objectAtIndex:0] valueForKey:@"Card"];
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
                    dict =[[NSMutableDictionary alloc]init];
                    if(firstsuitString==secondsuitString){
                        [dict setObject:card forKey:@"Card"];
                        [dict setObject:@"PlayerCard" forKey:@"Type"];
                        [first addObject:dict];
                        firstTime =NO;
                    }
                    else {
                        [dict setObject:card forKey:@"Card"];
                        [dict setObject:@"PlayerCard" forKey:@"Type"];
                        [second addObject:dict];
                        firstTime =NO;
                    }
                }
                for(int j =0 ;j<5;j++){
                    Card *card1 =[appDelegate().cummulativeCards objectAtIndex:j];
                    NSString *suitString;
                    switch (card.suit)
                    {
                        case SuitClubs:    suitString = @"Clubs"; break;
                        case SuitDiamonds: suitString = @"Diamonds"; break;
                        case SuitHearts:   suitString = @"Hearts"; break;
                        case SuitSpades:   suitString = @"Spades"; break;
                    }
                    NSString *suitString1;
                    switch (card1.suit)
                    {
                        case SuitClubs:    suitString1 = @"Clubs"; break;
                        case SuitDiamonds: suitString1 = @"Diamonds"; break;
                        case SuitHearts:   suitString1 = @"Hearts"; break;
                        case SuitSpades:   suitString1 = @"Spades"; break;
                    }
                    if(firstTime==YES){
                        dict =[[NSMutableDictionary alloc]init];
                        if(suitString == suitString1){
                            [dict setObject:[appDelegate().cummulativeCards objectAtIndex:j] forKey:@"Card"];
                            [dict setObject:@"Dealcards" forKey:@"Type"];
                            [first addObject:dict];
                        }
                    }
                    else if (firstTime==NO){
                        if(second.count>0) {
                            dict =[[NSMutableDictionary alloc]init];
                            if(suitString == suitString1) {
                                [dict setObject:[appDelegate().cummulativeCards objectAtIndex:j] forKey:@"Card"];
                                [dict setObject:@"Dealcards" forKey:@"Type"];
                                [second addObject:dict];
                            }
                        }
                    }
                }
            }
            if(first.count>3){
                for(int k=0;k<first.count;k++) {
                    Card *cardvalue =[[first  valueForKey:@"Card"] objectAtIndex:k];
                    NSString *valueString;
                    switch (cardvalue.value)
                    {
                        case CardAce:   valueString = @"11"; break;
                        case CardJack:  valueString = @"10"; break;
                        case CardQueen: valueString = @"10"; break;
                        case CardKing:  valueString = @"10"; break;
                        default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                    }
                    switch (cardvalue.suit)
                    {
                        case SuitClubs:    firstSuitString = @"Clubs"; break;
                        case SuitDiamonds: firstSuitString = @"Diamonds"; break;
                        case SuitHearts:   firstSuitString = @"Hearts"; break;
                        case SuitSpades:   firstSuitString = @"Spades"; break;
                        default:        firstSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
                    }
                    int value = [valueString intValue];
                    NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:2];
                    [tempdict setValue:[NSNumber numberWithInt:value] forKey:@"Value"];
                    [tempdict setValue:cardvalue forKey:@"Card"];
                    [tempdict setValue:[[first objectAtIndex:k] valueForKey:@"Type"] forKey:@"Type"];
                    [final1 addObject:tempdict];
                }
                NSMutableArray *filteredArray = [final1 mutableCopy];
                NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
                [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
                [final1 removeAllObjects];
                [first removeAllObjects];
                
                NSMutableArray *checkArray =[[NSMutableArray alloc]init];
                for(int z=0;z<3;z++){
                    [checkArray addObject:[filteredArray objectAtIndex:z]];
                }
                if([[checkArray valueForKey:@"Type"] containsObject:@"PlayerCard"]) {
                }
                else{
                    [filteredArray removeObjectAtIndex:2];
                    [checkArray removeObjectAtIndex:2];
                    [checkArray addObject:[filteredArray objectAtIndex:2]];
                    if([[checkArray valueForKey:@"Type"] containsObject:@"PlayerCard"]){
                        NSLog(@"Contains");
                    }
                    else{
                        [filteredArray removeObjectAtIndex:2];
                        [checkArray removeObjectAtIndex:2];
                        [checkArray addObject:[filteredArray objectAtIndex:2]];
                    }
                }
                for(int z=0;z<3;z++){
                    NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
                    [final1 addObject:[[filteredArray valueForKey:@"Value"] objectAtIndex:z]];
                    firsttotal =firsttotal+[[[filteredArray valueForKey:@"Value"] objectAtIndex:z] integerValue];
                    [dict setObject:[[filteredArray valueForKey:@"Card"] objectAtIndex:z ] forKey:@"Card"];
                    [dict setObject:@"Card" forKey:@"Type"];
                    [first addObject:dict];
                }
            }
            else{
                for(int k=0;k<first.count;k++){
                    Card *cardvalue =[[first valueForKey:@"Card"] objectAtIndex:k];
                    NSString *valueString;
                    switch (cardvalue.value)
                    {
                        case CardAce:   valueString = @"11"; break;
                        case CardJack:  valueString = @"10"; break;
                        case CardQueen: valueString = @"10"; break;
                        case CardKing:  valueString = @"10"; break;
                        default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                    }
                    switch (cardvalue.suit)
                    {
                        case SuitClubs:    firstSuitString = @"Clubs"; break;
                        case SuitDiamonds: firstSuitString = @"Diamonds"; break;
                        case SuitHearts:   firstSuitString = @"Hearts"; break;
                        case SuitSpades:   firstSuitString = @"Spades"; break;
                        default:        firstSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
                    }
                    int value = [valueString intValue];
                    firsttotal = firsttotal+value;
                }
            }
            if(second.count>3){
                for(int k=0;k<second.count;k++){
                    Card *cardvalue =[[second  valueForKey:@"Card"] objectAtIndex:k];
                    NSString *valueString;
                    switch (cardvalue.value)
                    {
                        case CardAce:   valueString = @"11"; break;
                        case CardJack:  valueString = @"10"; break;
                        case CardQueen: valueString = @"10"; break;
                        case CardKing:  valueString = @"10"; break;
                        default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                    }
                    switch (cardvalue.suit)
                    {
                        case SuitClubs:    secondSuitString = @"Clubs"; break;
                        case SuitDiamonds: secondSuitString = @"Diamonds"; break;
                        case SuitHearts:   secondSuitString = @"Hearts"; break;
                        case SuitSpades:   secondSuitString = @"Spades"; break;
                        default:        secondSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
                    }
                    int value = [valueString intValue];
                    NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:2];
                    [tempdict setValue:[NSNumber numberWithInt:value] forKey:@"Value"];
                    [tempdict setValue:cardvalue forKey:@"Card"];
                    [tempdict setValue:[[second objectAtIndex:k] valueForKey:@"Type"] forKey:@"Type"];
                    [final2 addObject:tempdict];
                }
                NSMutableArray *filteredArray = [final2 mutableCopy];
                NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
                [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
                [second removeAllObjects];
                [final2 removeAllObjects];
                NSMutableArray *checkArray =[[NSMutableArray alloc]init];
                for(int z=0;z<3;z++){
                    [checkArray addObject:[filteredArray objectAtIndex:z]];
                }
                if([[checkArray valueForKey:@"Type"] containsObject:@"PlayerCard"]){
                    NSLog(@"Contains");
                }
                else{
                    [filteredArray removeObjectAtIndex:2];
                    [checkArray removeObjectAtIndex:2];
                    [checkArray addObject:[filteredArray objectAtIndex:2]];
                    if([[checkArray valueForKey:@"Type"] containsObject:@"PlayerCard"]){
                        NSLog(@"Contains");
                    }
                    else{
                        [filteredArray removeObjectAtIndex:2];
                        [checkArray removeObjectAtIndex:2];
                        [checkArray addObject:[filteredArray objectAtIndex:2]];
                    }
                }
                for(int z=0;z<3;z++) {
                    NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
                    [final2 addObject:[[filteredArray valueForKey:@"Value"] objectAtIndex:z]];
                    secondtotal =secondtotal+[[[filteredArray valueForKey:@"Value"] objectAtIndex:z] integerValue];
                    [dict setObject:[[filteredArray valueForKey:@"Card"] objectAtIndex:z ] forKey:@"Card"];
                    [dict setObject:@"Card" forKey:@"Type"];
                    [second addObject:dict];
                }
            }
            else if(second.count>0){
                for(int l=0;l<second.count;l++) {
                    Card *cardvalue =[[second  valueForKey:@"Card"] objectAtIndex:l];
                    NSString *valueString;
                    switch (cardvalue.value)
                    {
                        case CardAce:   valueString = @"11"; break;
                        case CardJack:  valueString = @"10"; break;
                        case CardQueen: valueString = @"10"; break;
                        case CardKing:  valueString = @"10"; break;
                        default:        valueString = [NSString stringWithFormat:@"%d", cardvalue.value];
                    }
                    switch (cardvalue.suit)
                    {
                        case SuitClubs:    secondSuitString = @"Clubs"; break;
                        case SuitDiamonds: secondSuitString = @"Diamonds"; break;
                        case SuitHearts:   secondSuitString = @"Hearts"; break;
                        case SuitSpades:   secondSuitString = @"Spades"; break;
                        default:        secondSuitString = [NSString stringWithFormat:@"%d", cardvalue.suit];
                    }
                    int value = [valueString intValue];
                    secondtotal = secondtotal+value;
                }
            }
            if(firsttotal>secondtotal){
                NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:6];
                [tempdict setValue:[NSNumber numberWithInt:firsttotal] forKey:@"Score"];
                [tempdict setValue:firstSuitString forKey:@"Suit"];
                [tempdict setValue:[first mutableCopy] forKey:@"Cards"];
                [tempdict setValue:game.activePlayer.name forKey:@"PlayerName"];
                [tempdict setValue:game.activePlayer.ID forKey:@"Id"];
                [tempdict setValue:[NSString stringWithFormat:@"%u",game._activePlayerPosition]  forKey:@"PlayerPosition"];
                [scoreArray addObject:tempdict];
            }
            else{
                NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]initWithCapacity:6];
                [tempdict setValue:[NSNumber numberWithInt:secondtotal] forKey:@"Score"];
                [tempdict setValue:secondSuitString forKey:@"Suit"];
                [tempdict setValue:[second mutableCopy] forKey:@"Cards"];
                [tempdict setValue:game.activePlayer.name forKey:@"PlayerName"];
                [tempdict setValue:game.activePlayer.ID forKey:@"Id"];
                [tempdict setValue:[NSString stringWithFormat:@"%u",game._activePlayerPosition]  forKey:@"PlayerPosition"];
                [scoreArray addObject:tempdict];
            }
            game._activePlayerPosition++;
            if(game._activePlayerPosition == PlayerPositionMiddle){
                if(ActiveAtPositionMiddle==YES)
                    game._activePlayerPosition++;
            }
           else if(game._activePlayerPosition == PlayerPositionLMiddle) {
                if(ActiveAtPositionLMiddle==YES)
                    game._activePlayerPosition++;
            }else if(game._activePlayerPosition == PlayerPositionLBottom){
                if(ActiveAtPositionLBottom==YES)
                    game._activePlayerPosition++;
            }
            [self winningConditions];
        }
    }
}
-(void)restartTheGame{
    Received=NO;
    game.Received=NO;
    NSMutableArray *serverArray =[[NSMutableArray alloc]init];
    if(scoreArray.count>0){
    for(int i=0;i<scoreArray.count;i++){
        if([[[scoreArray valueForKey:@"Id"] objectAtIndex:i] isEqual:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"]]){
        Player *player =[game playerAtPosition:[[[scoreArray valueForKey:@"PlayerPosition"] objectAtIndex:i] integerValue]];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:[[scoreArray valueForKey:@"Id"] objectAtIndex:i] forKey:@"Id"];
        [dict setValue:player.Score forKey:@"FinalScore"];
        [dict setValue:player.serverindex forKey:@"index"];
        [dict setValue:[[scoreArray valueForKey:@"Score"] objectAtIndex:i] forKey:@"Points"];
        [serverArray addObject:dict];
        [[NSUserDefaults standardUserDefaults] setValue:player.Score forKey:@"temp_score"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    }
    if(serverArray.count>0){
    if([[[serverArray valueForKey:@"FinalScore"] objectAtIndex:0] isEqualToString:@"0"]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You don't have enough score to play game, please buy credits from the bank account" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Buy back-in",@"Leave",nil];
        alert.tag=333;
        [alert show];
        PNChannel *channel_self = [PNChannel channelWithName:appDelegate().tableNumber];
        [PubNub unsubscribeFromChannel:channel_self withCompletionHandlingBlock:^(NSArray *channels, PNError *subscriptionError){
            if(subscriptionError != nil){
            }
            else{NSLog(@"subscriptionError  %@",subscriptionError);}}];}
    }
     NSString *jsonserverArray = [serverArray JSONRepresentation];
     WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
     objAPI.showActivityIndicator = YES;
     NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
    NSMutableString *postData;
    if(serverArray.count>0)
     postData = [NSMutableString stringWithFormat:@"operation=update_game_information&game_level=%@&player_info=%@&table_number=%@&fold=No&buy_ins=%@",appDelegate().LevelName,jsonserverArray,appDelegate().tableNumber,appDelegate().buyInValue];
    else
    postData = [NSMutableString stringWithFormat:@"operation=update_game_information&game_level=%@&player_info=%@&table_number=%@&fold=Yes&buy_ins=%@",appDelegate().LevelName,jsonserverArray,appDelegate().tableNumber,appDelegate().buyInValue];
     [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonUpdatedDataResponse:)];
     objAPI = nil;
}
-(void)jsonUpdatedDataResponse:(id)responseDict{
    WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
    [objAPI hideProgressView:self.progressView];
    if([[responseDict valueForKey:@"success"]integerValue ]==1) {
        WebServiceInterface *objAPI = [WebServiceInterface sharedManager];
        objAPI.showActivityIndicator = YES;
        NSString *strConnectionUrl = [NSString stringWithFormat:@"%@",BaseUrl];
        
        NSMutableString *postData = [NSMutableString stringWithFormat:@"operation=table_information&table_number=%@&dealer=%@",appDelegate().tableNumber,appDelegate().dealerId];
        [objAPI fetchDataForURL:strConnectionUrl withData:postData withTarget:self withSelector:@selector(jsonUpdatedTableDataResponse:)];
        objAPI = nil;
    }
    else{
    }
}
-(void)jsonUpdatedTableDataResponse:(id)responseDict{
    appDelegate().gameStarted=[NSString stringWithFormat:@"%@",[responseDict valueForKey:@"game_status"]];
    flopCradCount=0;
    round=0;
    centerLbl.text=@"new game";
    firstProfileImageBG.hidden=YES;
    secondProfileImageBG.hidden=YES;
    thirdProfileImageBG.hidden=YES;
    fifthProfileImageBG.hidden=YES;
    sixthProfileImageBG.hidden=YES;
    seventhProfileImageBG.hidden=YES;
    [firstTotalScore removeFromSuperview];
    [secondTotalScore removeFromSuperview];
    [thirdTotalScore removeFromSuperview];
    [fourthTotalScore removeFromSuperview];
    [fifthTotalScore removeFromSuperview];
    [sixthTotalScore removeFromSuperview];
    [seventhTotalScore removeFromSuperview];
    [_dealingCardsSound stop];
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
    
    [circularView0 stop];
    circularView0.hidden=YES;
    [circularView1  stop];
     circularView1.hidden=YES;
    [circularView2 stop];
    circularView2.hidden=YES;
    [circularView3 stop];
    circularView3.hidden=YES;
    [circularView4  stop];
    circularView4.hidden=YES;
    [circularView5 stop];
    circularView5.hidden=YES;
    [circularView6 stop];
    circularView6.hidden=YES;
    totalScoreLabel.text=@"";
    totalBetamount.frame = CGRectMake(220+45*isiPhone5(), 110, 40, 30);
    totalBetamount.hidden=YES;
    bestHandsScoreLbl.hidden=YES;
    DealerLabel.hidden=YES;
    smallBlindLabel.hidden=YES;
    bigBlindLabel.hidden=YES;
    firstbedirBG.hidden=YES;
    firstbedirBG.alpha=1.0;
    secondbedirBG.hidden=YES;
    secondbedirBG.alpha=1.0;
    thirdbedirBG.hidden=YES;
    thirdbedirBG.alpha=1.0;
    fouthbedirBG.hidden=YES;
    fouthbedirBG.alpha=1.0;
    fifthbedirBG.hidden=YES;
    fifthbedirBG.alpha=1.0;
    sixthbedirBG.hidden=YES;
    sixthbedirBG.alpha=1.0;
    seventhbedirBG.hidden=YES;
    seventhbedirBG.alpha=1.0;
    
    for (UIView *view in [bestHandsView subviews]){
        [view removeFromSuperview];
    }
    for (UIView *view in [_communityView subviews]){
        [view removeFromSuperview];
    }
    for (UIView *view in [_cardContainerView subviews]){
        [view removeFromSuperview];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showIndicatorForActivePlayer) object:Nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnRiverCards) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(winningConditions) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnFlopCards) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(afterDealing) object:nil];[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(turnTurnCards) object:nil];
    [[PNObservationCenter defaultCenter] removeMessageReceiveObserver:game];
    
    
    
    if([[responseDict valueForKey:@"success"]integerValue ]==1){
        game =[[Game alloc]init];
        game.delegate=self;
        [appDelegate().clients removeAllObjects];
        [appDelegate().cummulativeCards removeAllObjects];
        if([[responseDict valueForKey:@"data"] count]>0){
            for(int i=0;i<7;i++){
                if(![[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]isEqual:@""]){
                     [appDelegate().clients addObject:[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%d",i]]];
                }
            }
        }
    }
    else if([[responseDict valueForKey:@"success"]integerValue ]==0){
        myQueue = [[NSOperationQueue alloc] init];
        [myQueue addOperationWithBlock:^{
            NSURLResponse *_response;
            NSError* _error = nil;
            NSString *_urlString = [NSString stringWithFormat:BaseUrl];
            NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
            NSString *_params = [NSString stringWithFormat:@"operation=table_information&table_number=%@&dealer=%@",appDelegate().tableNumber,appDelegate().dealerId];
            NSData *postData = [_params dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSMutableURLRequest *_req=[[NSMutableURLRequest alloc]initWithURL:_url];
            [_req setHTTPMethod:@"POST"];
            [_req setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [_req setHTTPBody:postData];
            NSData *_data=[NSURLConnection sendSynchronousRequest:_req returningResponse:&_response error:&_error];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                @try {
                    NSDictionary *_responsedict=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
                    if(isPoped==NO){
                    [self jsonUpdatedTableDataResponse:_responsedict];
                    }
                }
                @catch (NSException *exception) {
                }

            }];
        }];
    }
    if(appDelegate().clients.count>1)
    {
        int dealer = 0 ;
        int smallBlind = 0;
        int bigBlind = 0;
        for(int i=0;i<appDelegate().clients.count;i++){
            if([[[responseDict valueForKey:@"data"] valueForKey:@"dealer"] isEqualToString:[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i]]) {
                if(appDelegate().clients.count>2){
                    dealer=i;
                    bigBlind=dealer+1;
                    if(bigBlind==appDelegate().clients.count){
                        bigBlind=0;
                    }
                    else if(bigBlind==appDelegate().clients.count+1){
                        bigBlind=1;
                    }
                    else if (bigBlind<0){
                        bigBlind=appDelegate().clients.count-1;
                    }
                    smallBlind=dealer+2;
                    if(smallBlind==appDelegate().clients.count){
                        smallBlind=0;
                    }
                    else if(smallBlind==appDelegate().clients.count+1){
                        smallBlind=1;
                    }
                    else if(smallBlind==appDelegate().clients.count+2){
                        smallBlind=2;
                    }
                    else if (smallBlind<0){
                        smallBlind=appDelegate().clients.count-1;
                    }
                }
                else if (appDelegate().clients.count>1){
                    dealer=i;
                    bigBlind=dealer+2;
                    if(bigBlind==appDelegate().clients.count){
                        bigBlind=0;
                    }
                    else if(bigBlind==appDelegate().clients.count+1){
                        bigBlind=1;
                    }
                    else if (bigBlind<0){
                        bigBlind=appDelegate().clients.count-1;
                    }
                    smallBlind=dealer+1;
                    if(smallBlind==appDelegate().clients.count){
                        smallBlind=0;
                    }
                    else if(smallBlind==appDelegate().clients.count+1){
                        smallBlind=1;
                    }
                    else if(smallBlind==appDelegate().clients.count+2){
                        smallBlind=2;
                    }
                    else if (smallBlind<0){
                        smallBlind=appDelegate().clients.count-1;
                    }
                }
            }
        }
        NSMutableArray *playersArray =[[NSMutableArray alloc]init];
        for(int i=0;i<appDelegate().clients.count;i++){
            NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]init];
            if(appDelegate().clients.count>2){
                if(i==dealer){
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
                else if (i==smallBlind){
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
                else if (i==bigBlind){
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
                else{
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
            else{
                if(i==dealer){
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
                else if (i==smallBlind) {
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
        appDelegate().dealerId=[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"dealer"]];
        [appDelegate().clients removeAllObjects];
        [appDelegate().clients addObjectsFromArray:playersArray];
        [playersArray removeAllObjects];
        for(int i=0;i<appDelegate().clients.count;i++){
            if([[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:i] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]]){
                for(int j=0;j<appDelegate().clients.count;j++) {
                    [playersArray addObject:[appDelegate().clients objectAtIndex:i]];
                    i++;
                    if(i>=appDelegate().clients.count){
                        i=0;
                    }
                }
            }
        }
        [appDelegate().clients removeAllObjects];
        [appDelegate().clients addObjectsFromArray:playersArray];
        appDelegate().dealerId=[NSString stringWithFormat:@"%@",[[responseDict valueForKey:@"data"] valueForKey:@"dealer"]];
        centerLbl.text=@"";
        [self performSelector:@selector(startNewGame:) withObject:responseDict afterDelay:0.5];
    }
    else{
        centerLbl.text=@"";
        [self performSelector:@selector(startNewGame:) withObject:responseDict afterDelay:0.5];
    }
}
-(void)startNewGame:(id)responseDict{
    ActiveAtPositionLTop =NO;
    ActiveAtPositionLMiddle=NO;
    ActiveAtPositionLBottom=NO;
    ActiveAtPositionMiddle=NO;
    ActiveAtPositionRBottom=NO;
    ActiveAtPositionRMiddle=NO;
    ActiveAtPositionRTop=NO;
    //totalBetamount.hidden=NO;
    first =[[NSMutableArray alloc]init];
    second =[[NSMutableArray alloc]init];
    scoreDict =[[NSMutableDictionary alloc]init];
    scoreArray =[[NSMutableArray alloc]init];
    myOpencards =[[NSMutableArray alloc]init];
    rulesView =[[Rules alloc]init];
    bestHandsArray=[[NSMutableArray alloc]init];
    
    firstEmptyChair =[UIImage imageNamed:@"chair1"];
    secondEmptyChair=[UIImage imageNamed:@"chair2"];
    thirdEmptyChair =[UIImage imageNamed:@"chair3"];
    fourthEmptyChair=[UIImage imageNamed:@"chair4"];
    fifthEmptyChair=[UIImage imageNamed:@"chair5"];
    sixthEmptyChair=[UIImage imageNamed:@"chair6"];
    seventhEmptyChair=[UIImage imageNamed:@"chair7"];
    firstbedirBG.image=firstEmptyChair;
    secondbedirBG.image=secondEmptyChair;
    thirdbedirBG.image=thirdEmptyChair;
    fifthbedirBG.image=fifthEmptyChair;
    sixthbedirBG.image=sixthEmptyChair;
    seventhbedirBG.image=seventhEmptyChair;
    bedirimage =[UIImage imageNamed:@"bedir"];
    thirdbedirimage =[UIImage imageNamed:@"Secondbedir"];
    fourthbedirimage =[UIImage imageNamed:@"Secondbedir"];
    
    firstPlayerName.text=@"";
    firstPlayerScore.text=@"";
    
    secondPlayerName.text=@"";
    secondPlayerScore.text=@"";
    
    thirdPlayerName.text =@"";
    
    //fourthPlayerName.text = @"";
    
    fifthPlayerName.text =@"";
    sixthPlayerName.text =@"";
    sixthPlayerScore.text = @"";
    seventhPlayerName.text = @"";
    seventhPlayerScore.text =@"";
    final1 =[[NSMutableArray alloc]init];
    final2 =[[NSMutableArray alloc]init];
    firstDict =[[NSMutableDictionary alloc]init];
    secondDict=[[NSMutableDictionary alloc]init];
    round=0;
    flopCradCount=0;
     centerLbl.text=@"new game";
    [self loadNewGameSound];
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: checkButton, callButton, foldButton,allinButton,betButton,nil]] ;
    
    [self enableInteraction:NO arrayOfViews:[[NSArray alloc]initWithObjects: sitOutButton,nil]];
    Received=NO;
    game.Received=NO;
    gameStarted=NO;
    callAmount=appDelegate().smallBlindValue;
    if(appDelegate().clients.count>1){
            if([[[[responseDict valueForKey:@"data"] valueForKey:[NSString stringWithFormat:@"%u",appDelegate().clients.count-1]] valueForKey:@"nick_name"] isEqualToString:[[NSUserDefaults standardUserDefaults ] valueForKey:@"NickName"]]){
                    [game startServerGameWithSession:appDelegate().tableNumber playerName:[NSString stringWithFormat:@"%@",[[appDelegate().clients valueForKey:@"username"]objectAtIndex:0]] clients:appDelegate().clients];
                    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSURLResponse *_response;
                        NSError* _error = nil;
                        NSString *_urlString = [NSString stringWithFormat:BaseUrl];
                        NSURL *_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_urlString]];
                        NSString *_params;
                        _params = [NSString stringWithFormat:@"operation=update_game_status&table_number=%@",appDelegate().tableNumber];
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
                            }
                            @catch (NSException *exception) {
                                
                            }
                        });
                    });
            }
    }
}

#pragma mark Auxilliary Functions
/**********************************************************
 * Following functions enables interaction for a set
 * of views defined by an array
 **********************************************************/

- (void)enableInteraction:(BOOL)shouldInteract arrayOfViews:(NSArray *)arrayOfViews{
    for(UIView * view in arrayOfViews)
    {
        [view setUserInteractionEnabled:shouldInteract];
    }
}
- (void)didReceiveMemoryWarning{
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
