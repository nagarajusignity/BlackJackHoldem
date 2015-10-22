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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***
     * Background ImageView
     **/
    
    UIImage *image =[UIImage imageNamed:@"backwall"];
    UIImageView *imageViewBG=[[UIImageView alloc]initWithImage:image];//CreateSheet_BG
    imageViewBG.frame=CGRectMake(0.0, 0.0,self.view.frame.size.width , self.view.frame.size.height);
    [self.view addSubview:imageViewBG];
    
    /***
     * bedir ImageView
     **/
    
    UIImage *bedirimage =[UIImage imageNamed:@"bedir"];
    UIImageView *firstbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    firstbedirBG.frame=CGRectMake(375.0, 15.0,bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:firstbedirBG];
    
    UIImageView *secondbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    secondbedirBG.frame=CGRectMake(500, 80,bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:secondbedirBG];
    
    UIImage *thirdbedirimage =[UIImage imageNamed:@"Secondbedir"];
    UIImageView *thirdbedirBG=[[UIImageView alloc]initWithImage:thirdbedirimage];//CreateSheet_BG
    thirdbedirBG.frame=CGRectMake(385.0, 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
    [self.view addSubview:thirdbedirBG];
    
    UIImage *fourthbedirimage =[UIImage imageNamed:@"draco"];
    UIImageView *fouthbedirBG=[[UIImageView alloc]initWithImage:fourthbedirimage];//CreateSheet_BG
    fouthbedirBG.frame=CGRectMake(245.0, 222,fourthbedirimage.size.width , fourthbedirimage.size.height);
    [self.view addSubview:fouthbedirBG];
    
    UIImageView *fifthbedirBG=[[UIImageView alloc]initWithImage:thirdbedirimage];//CreateSheet_BG
    fifthbedirBG.frame=CGRectMake(105.0, 210,thirdbedirimage.size.width , thirdbedirimage.size.height);
    [self.view addSubview:fifthbedirBG];
    
    UIImageView *sixthbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    sixthbedirBG.frame=CGRectMake(10.0, 80,bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:sixthbedirBG];
    
    UIImageView *seventhbedirBG=[[UIImageView alloc]initWithImage:bedirimage];//CreateSheet_BG
    seventhbedirBG.frame=CGRectMake(133, 15,bedirimage.size.width , bedirimage.size.height);
    [self.view addSubview:seventhbedirBG];
    
    //[self addProgressViews];
    
    /***
     * Check Button
     **/
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton addTarget:self
                  action:@selector(checkButtonPressed)
        forControlEvents:UIControlEventTouchUpInside];
    checkButton.backgroundColor =[UIColor clearColor];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [checkButton setTitle:@"Check" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.frame = CGRectMake(1, self.view.frame.size.height-34, 114, 34);
    [self.view addSubview:checkButton];
    
    /***
     * Call Button
     **/
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [callButton addTarget:self
                    action:@selector(callButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    callButton.backgroundColor =[UIColor clearColor];
    [callButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [callButton setTitle:@"Call" forState:UIControlStateNormal];
    [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callButton.frame = CGRectMake(113.5, self.view.frame.size.height-34, 114, 34);
    [self.view addSubview:callButton];
    
    
    /***
     * Fold Button
     **/
    
    UIButton *foldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [foldButton addTarget:self
                   action:@selector(foldButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    foldButton.backgroundColor =[UIColor clearColor];
    [foldButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [foldButton setTitle:@"Fold" forState:UIControlStateNormal];
    [foldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    foldButton.frame = CGRectMake(227.5, self.view.frame.size.height-34, 114, 34);
    [self.view addSubview:foldButton];
    
    /***
     * Allin Button
     **/
    
    UIButton *allinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [allinButton addTarget:self
                   action:@selector(allinButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    allinButton.backgroundColor =[UIColor clearColor];
    [allinButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [allinButton setTitle:@"All in" forState:UIControlStateNormal];
    [allinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allinButton.frame = CGRectMake(341.5, self.view.frame.size.height-34, 114, 34);
    [self.view addSubview:allinButton];
    
    /***
     * Allin Button
     **/
    
    UIButton *betButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [betButton addTarget:self
                    action:@selector(betButtonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    betButton.backgroundColor =[UIColor clearColor];
    [betButton setBackgroundImage:[UIImage imageNamed:@"bottombtn"] forState:UIControlStateNormal];
    [betButton setTitle:@"Bet" forState:UIControlStateNormal];
    [betButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    betButton.frame = CGRectMake(455, self.view.frame.size.height-34, 114, 34);
    [self.view addSubview:betButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFlopCards) name:@"updateFlopCards" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTurnCard) name:@"updateTurnCard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRiverCard) name:@"updateRiverCard" object:nil];
    
    first =[[NSMutableArray alloc]init];
    second =[[NSMutableArray alloc]init];
    final1 =[[NSMutableArray alloc]init];
    final2 =[[NSMutableArray alloc]init];
    
    firstDict =[[NSMutableDictionary alloc]init];
    secondDict=[[NSMutableDictionary alloc]init];
    
    round=0;
    flopCradCount=0;
    
    centerLbl = [[UILabel alloc] init];
    centerLbl.frame = CGRectMake(140,140, 250, 40);
    centerLbl.textAlignment = NSTextAlignmentCenter;
    centerLbl.textColor = [UIColor  lightGrayColor];
    centerLbl.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18.0];
    centerLbl.backgroundColor = [UIColor redColor];
    [self.view addSubview:centerLbl];
    
    
    _communityView =[[UIView alloc]initWithFrame:CGRectMake(140,100, 250, 40)];
    _communityView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:_communityView];
    
     [self addProgressViews];
    
    _cardContainerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 568, 320)];
    _cardContainerView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_cardContainerView];
    
    
    _players = [NSMutableDictionary dictionaryWithCapacity:7];
    Player *player1 = [[Player alloc] init];
    player1.position= PlayerPositionLTop;
    player1.peerID=@"1";
    player1.name=@"Nag1";
    [_players setObject:player1 forKey:@"1"];
    
    Player *player2 = [[Player alloc] init];
    player2.position= PlayerPositionLMiddle;
    player2.peerID=@"2";
    player2.name=@"Nag2";
    [_players setObject:player2 forKey:@"2"];
    
    Player *player3 = [[Player alloc] init];
    player3.position= PlayerPositionLBottom;
    player3.peerID=@"3";
    player3.name=@"Nag3";
    [_players setObject:player3 forKey:@"3"];
    
    Player *player4 = [[Player alloc] init];
    player4.position= PlayerPositionMiddle;
    player4.peerID=@"4";
    player4.name=@"Nag4";
    [_players setObject:player4 forKey:@"4"];
    
    Player *player5 = [[Player alloc] init];
    player5.position= PlayerPositionRBottom;
    player5.peerID=@"5";
    player5.name=@"Nag5";
    [_players setObject:player5 forKey:@"5"];
    
    Player *player6 = [[Player alloc] init];
    player6.position= PlayerPositionRMiddle;
    player6.peerID=@"6";
    player6.name=@"Nag6";
    [_players setObject:player6 forKey:@"6"];
    
    Player *player7 = [[Player alloc] init];
    player7.position= PlayerPositionRTop;
    player7.peerID=@"7";
    player7.name=@"Nag7";
    [_players setObject:player7 forKey:@"7"];
    
    [self pickRandomStartingPlayer];
    
    Deck *deck =[[Deck alloc]init];
    [deck shuffle];
    cumulativeCards =[deck  cummilativeCards];
    while ([deck cardsRemaining] > 0)
    {
        NSLog(@"Not empty..%d",deck.cardsRemaining);
        for (PlayerPosition p = _startingPlayerPosition; p < _startingPlayerPosition + 4; ++p)
        {
            Player *player = [self playerAtPosition:(p % 4)];
            NSLog(@"player...%@",player);
            if ([deck cardsRemaining] > 0)
            {
                Card *card = [deck draw];
                [player.closedCards addCardToTop:card];
            }
            NSLog(@"player.closedCards....%@",player.closedCards);
            
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

#pragma mark Starting With Player

-(void)ButtonPressedstartingWithPlayer:(Player *)startingPlayer
{
    NSTimeInterval delay = 1.0f;
    
    //Player *startingPlayer; //=PlayerPositionBottom;
    
    for (int t = 0; t < 2; ++t)
    {
        for (PlayerPosition p = startingPlayer.position; p < startingPlayer.position + 4; ++p)
        {
            Player *player = [self playerAtPosition:p % 4];
            NSLog(@"player...%@",player);
            if (player != nil && t < [player.closedCards cardCount])
            {
                CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, CardWidth, CardHeight)];
                cardView.card = [player.closedCards cardAtIndex:t];
                [self.cardContainerView addSubview:cardView];
                [cardView animateDealingToPlayer:player withDelay:delay angle:0+35*t Xvalue:0+20*t Yvalue:0+10*t];
                delay += 0.1f;
            }
        }
        
        
    }
    [self performSelector:@selector(afterDealing) withObject:nil afterDelay:delay];
}

#pragma mark After Dealing

- (void)afterDealing
{
    //	[_dealingCardsSound stop];
    //	self.snapButton.hidden = NO;
    [self beginRound];
}

#pragma mark Begin Round

-(void)beginRound
{
    
    isfirst= YES;
    [self turnCardForPlayerAtBottom];
    [self  showIndicatorForActivePlayer];
    
    
}

#pragma mark Show Indicater For Player

-(void)showIndicatorForActivePlayer
{
    PlayerPosition position = [self activePlayer].position;
    
    switch (position)
    {
        case PlayerPositionLTop:
        {
            circularView0.hidden = NO;
            [circularView0 play];
            break;
        }
        case PlayerPositionLMiddle:
        {
            circularView1.hidden = NO;
            [circularView1 play];
            break;
        }
        case PlayerPositionLBottom:
        {
            circularView2.hidden = NO;
            [circularView2 play];
            break;
        }
        case PlayerPositionMiddle:
        {
            circularView3.hidden = NO;
            [circularView3 play];
            break;
        }
        case PlayerPositionRBottom:
        {
            circularView4.hidden = NO;
            [circularView4 play];
            break;
        }
        case PlayerPositionRMiddle:
        {
            circularView5.hidden = NO;
            [circularView5 play];
            break;
        }
        case PlayerPositionRTop:
        {
            circularView6.hidden = NO;
            [circularView6 play];
            break;
        }
    }
    
    if (position == PlayerPositionLTop)
        centerLbl.text = NSLocalizedString(@"Your turn. Tap the stack.", @"Status text: your turn");
    else
        centerLbl.text = [NSString stringWithFormat:NSLocalizedString(@"%@'s turn", @"Status text: other player's turn"), [self activePlayer].name];
    
}



#pragma mark TurnBottom Player Cards

-(void)turnCardForPlayerAtBottom
{
    if (_activePlayerPosition == PlayerPositionLTop
        && [[self activePlayer].closedCards cardCount] > 0)
    {
        NSLog(@"activePlayer.closedCards..%lu",(unsigned long)[[self activePlayer].closedCards cardCount]);
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
    
    NSLog(@"player..%@",player);
    NSLog(@"player.closedCards cardCount..%lu",(unsigned long)[player.closedCards cardCount]);
    //_hasTurnedCard = YES;
    
    Card *card = [player turnOverTopCard];
    NSLog(@"card..%@",card);
    CardView *cardView = [self cardViewForCard:card];
    if(isfirst ==NO)
        cardView.isFirst=YES;
    else
        cardView.isFirst=NO;
    NSLog(@"cardView..%@",cardView);
    
    [cardView animateTurningOverForPlayer:player success:^()
     {
         if(player.position==PlayerPositionLTop)
         {
             NSLog(@"Success");
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
        NSLog(@"cardView.card..%@",cardView.card);
        NSLog(@"card..%@",card);
        
        if ([cardView.card isEqualToCard:card])
            return cardView;
    }
    return nil;
}

- (CardView *)communityCardViewForCard:(Card *)card
{
    for (CardView *cardView in self.communityView.subviews)
    {
        NSLog(@"cardView.card..%@",cardView.card);
        NSLog(@"card..%@",card);
        
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
    NSLog(@"position..%u",position);
    NSAssert(position >= PlayerPositionLTop && position <= PlayerPositionRTop, @"Invalid player position");
    
    __block Player *player;
    
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         player = obj;
         
         NSLog(@"key...%@",key);
         
         NSLog(@"obj...%@",obj);
         
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
    
}

#pragma mark Call Button Action

-(void)callButtonPressed
{
    
}
#pragma mark Fold Button Action

-(void)foldButtonPressed
{
    
}

#pragma mark All in Button Action

-(void)allinButtonPressed
{
    
}
#pragma mark Bet Button Action

-(void)betButtonPressed
{
    
}

#pragma mark Adding circular progressbars

-(void)addProgressViews
{
    
    circularView0 =[[CircularProgressView alloc]initWithFrame:CGRectMake(374.5, -5, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView0.delegate=self;
    circularView0.layer.cornerRadius=-10;
    circularView0.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView0.hidden=YES;
    [circularView0 stop];
    [self.view addSubview:circularView0];
    
    circularView1 =[[CircularProgressView alloc]initWithFrame:CGRectMake(499.5, 60, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView1.delegate=self;
    circularView1.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView1.hidden=YES;
    [circularView1 stop];
    [self.view addSubview:circularView1];
    
    circularView2 =[[CircularProgressView alloc]initWithFrame:CGRectMake(395, 190, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView2.delegate=self;
    circularView2.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView2.hidden=YES;
    [circularView2 stop];
    [self.view addSubview:circularView2];
    
    circularView3 =[[CircularProgressView alloc]initWithFrame:CGRectMake(450, 150, 100, 200) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:8 audioPath:Nil];
    circularView3.delegate=self;
    circularView3.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView3.hidden=YES;
    [circularView3 stop];
    //[self.view addSubview:circularView3];
    
    circularView4 =[[CircularProgressView alloc]initWithFrame:CGRectMake(115, 190, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView4.delegate=self;
    circularView4.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView4.hidden=YES;
    [circularView4 stop];
    [self.view addSubview:circularView4];
    
    circularView5 =[[CircularProgressView alloc]initWithFrame:CGRectMake(10.0, 60, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView5.delegate=self;
    circularView5.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView5.hidden=YES;
    [circularView5 stop];
    [self.view addSubview:circularView5];
    
    circularView6 =[[CircularProgressView alloc]initWithFrame:CGRectMake(133, -5, 60, 100) backColor:[UIColor clearColor] progressColor:[UIColor greenColor] lineWidth:4 audioPath:Nil];
    circularView6.delegate=self;
    circularView6.audioPath= [[NSBundle mainBundle] URLForResource:@"HomeScreen" withExtension:@"mp3"];
    circularView6.hidden=YES;
    [circularView6 stop];
    [self.view addSubview:circularView6];
}
#pragma mark Adding circular progressbars Delegates

- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player
{
    //NSLog(@"currentTime..%d",(int)player.currentTime);
    [self formatTime:(int)player.currentTime];
    
}
- (void)formatTime:(int)num
{
    [circularView0 setWarningShadow:num gameMode:YES];
}
#pragma mark Rounds Handling


-(void)playerDidFinishPlaying
{
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
    Card *card = [cumulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    NSLog(@"card..%@",card);
    CardView *cardView = [self communityCardViewForCard:card];
    NSLog(@"cardView..%@",cardView);
    
    [cardView animateRiverCardsTurnOverWithsuccess:^()
     {
         NSLog(@"Success");
         [self  turnsAllPlayersCards];
     }];
    
    [self performSelector:@selector(winningConditions) withObject:Nil afterDelay:2];
}

#pragma mark Updating Flop Cards


-(void)turnFlopCards
{
    
    Card *card = [cumulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    NSLog(@"card..%@",card);
    CardView *cardView = [self communityCardViewForCard:card];
    NSLog(@"cardView..%@",cardView);
    
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
    Card *card = [cumulativeCards objectAtIndex:flopCradCount];
    card.isTurnedOver=YES;
    NSLog(@"card..%@",card);
    CardView *cardView = [self communityCardViewForCard:card];
    NSLog(@"cardView..%@",cardView);
    
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
    _activePlayerPosition++;
    if(_activePlayerPosition>PlayerPositionRTop)
    {
        _activePlayerPosition = PlayerPositionLTop;
        if(isfirst ==NO)
            isfirst=YES;
        [self turnAllCardsForAllPlayers:[self activePlayer]];
    }
    else
    {
        [self turnAllCardsForAllPlayers:[self activePlayer]];
    }
}
-(void)turnAllCardsForAllPlayers:(Player*)player
{
    NSAssert([player.closedCards cardCount] > 0, @"Player has no more cards");
    
    NSLog(@"player..%@",player);
    NSLog(@"player.closedCards cardCount..%lu",(unsigned long)[player.closedCards cardCount]);
    //_hasTurnedCard = YES;
    
    Card *card = [player turnOverTopCard];
    NSLog(@"card..%@",card);
    CardView *cardView = [self cardViewForCard:card];
    if(isfirst ==NO)
        cardView.isFirst=YES;
    else
        cardView.isFirst=NO;
    NSLog(@"cardView..%@",cardView);
    
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
