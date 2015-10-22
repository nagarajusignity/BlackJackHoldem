//
//  Game.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/14/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Game.h"
#import "Card.h"
#import "Deck.h"
#import "Player.h"
#import "Stack.h"
#import "AppDelegate.h"
#import "SBJSON.h"
#import "NSObject+SBJSON.h"

@implementation Game
{
    NSMutableDictionary *_players;
    PlayerPosition _startingPlayerPosition;
    //PlayerPosition _activePlayerPosition;
    
    PlayerPosition testPosition;
}
@synthesize isServer = _isServer;
@synthesize delegate = _delegate;
@synthesize Received;
@synthesize _activePlayerPosition;
@synthesize firstPlayerBet,secondPlayerBet,thirdPlayerBet,fourthPlayerBet,fifthPlayerBet,sixthPlayerBet,seventhPlayerBet,betValue;
- (id)init
{
    if ((self = [super init]))
    {
        _players = [NSMutableDictionary dictionaryWithCapacity:7];
        [[PNObservationCenter defaultCenter] addMessageReceiveObserver:self
                                                             withBlock:^(PNMessage *message) {
                                                                 NSString * type = [message.message objectForKey: @"type"];
                                                                 
                                                                 
                                                                 //NSLog(@"Message In Game: %@",message);
                                                                 //NSLog(@"Message Type In Game: %@",type);
                                                            
                                                                 if([appDelegate().gameStarted isEqualToString:@"No"])
                                                                 {
                                                                     if([type isEqualToString:@"Cards"])
                                                                     {
                                                                         
                                                                         if(!self.isServer)
                                                                         {
                                                                             [self performSelector:@selector(PerformselecterForCreatingCards:) withObject:message.message afterDelay:0.5];
                                                                         
                                                                         }
                                                                         else
                                                                         {
                                                                             [self performSelector:@selector(performSelcterForDealCards) withObject:nil afterDelay:1.0];
                                                                         }
                                                                     }
                                                                 else if ([type isEqualToString:@"ActivePlayer"])
                                                                 {
                                                                     
                                                                         if(!self.isServer)
                                                                             [self handleActivatePlayer:message.message];
                                                                         else
                                                                           [self.delegate game:self didActivatePlayer:[self activePlayer]  ];
                                                                     
                                                                 }
                                                                 else if ([type isEqualToString:@"Startingplayer"])
                                                                 {
                                                                     
                                                                     if(!self.isServer)
                                                                         appDelegate().StaringPlayer=[[message.message objectForKey: @"Id"] intValue];
                                                                     
                                                                 }
                                                                 else if ([type isEqualToString:@"Rounds"])
                                                                 {
                                                                     if(Received==YES)
                                                                     {
                                                                     if([[message.message objectForKey:@"roundCount"] isEqualToString:@"0"])
                                                                     {
                                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlopCards" object:self];//updateFlopCards
                                                                         roundCount=roundCount+1;
                                                                         Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
                                                                         _activePlayerPosition = startingPlayer.position;
                                                                         
                                                                     }
                                                                     
                                                                   else if([[message.message objectForKey:@"roundCount"] isEqualToString:@"1"])
                                                                     {
                                                                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTurnCard" object:self];
                                                                         roundCount=roundCount+1;
                                                                         Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
                                                                         _activePlayerPosition = startingPlayer.position;
                                                                         
                                                                     }
                                                                   else if([[message.message objectForKey:@"roundCount"] isEqualToString:@"2"])
                                                                   {
                                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                                                                       roundCount=roundCount+1;
                                                                       Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
                                                                       _activePlayerPosition = startingPlayer.position;;
                                                                   }
                                                                   else if([[message.message objectForKey:@"roundCount"] isEqualToString:@"3"])
                                                                   {
                                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"winningConditions" object:self];
                                                                       roundCount=0;
                                                                       
                                                                   }
                                                                  }
                                                                 }
                                                                }
                                                             }];
        roundCount=0;
    }
    return self;
}

#pragma mark Create Cards For Clients

-(void)PerformselecterForCreatingCards:(id)responseDict
{
 [self createCards:responseDict];
}

#pragma mark Deal Cards

-(void)performSelcterForDealCards
{
  [self.delegate gameShouldDealCards:self startingWithPlayer:[self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]]];
  //  [self.delegate gameShouldDealCards:self startingWithPlayer:[self playerAtPosition:appDelegate().StaringPlayer]];
}

#pragma mark Handling Active player for clients

- (void)handleActivatePlayer:(id)responseDict
{
    NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]init];
    [tempDict addEntriesFromDictionary:responseDict];

    NSString *peerID = [tempDict valueForKey:@"UserId"];
    
    Player* newPlayer = [self playerWithPeerID:peerID];
    if (newPlayer == nil)
        return;
    
    /*
     // For faking missed ActivatePlayer messages.
     static int foo = 0;
     if (foo++ % 2 == 1 && testPosition == PlayerPositionTop && newPlayer.position != PlayerPositionBottom)
     {
     //NSLog(@"*** faking missed message");
     return;
     }
     */
    PlayerPosition minPosition = _activePlayerPosition;
    if (minPosition == PlayerPositionMiddle)
        minPosition = PlayerPositionLBottom;
    
    PlayerPosition maxPosition = newPlayer.position;
    if (maxPosition < minPosition)
        maxPosition = PlayerPositionRTop + 1;
    
    [self performSelector:@selector(activatePlayerWithPeerID:) withObject:peerID afterDelay:0.5f];
}

#pragma mark Handling Active player for Server

- (void)activatePlayerWithPeerID:(NSString *)peerID
{
    NSAssert(!self.isServer, @"Must be client");
    
    Player *player = [self playerWithPeerID:peerID];
    _activePlayerPosition = player.position;
    [self activatePlayerAtPosition:_activePlayerPosition];
}

#pragma mark Create Cards

-(void)createCards:(id)responseDict
{
    NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]init];
    [tempDict addEntriesFromDictionary:responseDict];
    
    [tempDict enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *obj, BOOL *stop)
     {
         if(![key isEqualToString:@"type"]&&![key isEqualToString:@"StaringPlayer"]&&![key isEqualToString:@"CummulativeCards"])
         {
         Player * player = [[Player alloc] init];
         player.ID =key;
         
          NSArray *tempArray =[[NSArray alloc]initWithArray:obj];
         NSMutableArray *cardsArray =[[NSMutableArray alloc]init];
         for(int i=0;i<2;i++)
         {
             NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]initWithDictionary:[tempArray objectAtIndex:i]];
             if(i==0)
             {
                 player.name= [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"nick_name"]];
                 player.position=[[tempDict valueForKey:@"Position"] intValue];
                 player.Image=[tempDict valueForKey:@"user_image"];
                 player.Score=[tempDict valueForKey:@"temp_score"];
                 player.dealer =[tempDict valueForKey:@"Dealer"];
                 player.smallBlind =[tempDict valueForKey:@"SmallBlind"];
                 player.bigBlind =[tempDict valueForKey:@"BigBlind"];
                 player.status =[tempDict valueForKey:@"Status"];
                 player.serverindex =[tempDict valueForKey:@"index"];
                 player.bet =@"0";
             }
               int valueint=[[tempDict valueForKey:@"Value"] intValue];
             Card *card =[[Card alloc]initWithSuit:[[tempDict valueForKey:@"Suit"] intValue]  value:valueint];
             [cardsArray addObject:card];
            [player.closedCards addCardToTop:card];
         }
         [_players setObject:player forKey:key];
         }
         if([key isEqualToString:@"CummulativeCards"])
         {
             NSArray *tempArray =[[NSArray alloc]initWithArray:obj];
             [appDelegate().cummulativeCards removeAllObjects];
             for(int i=0;i<5;i++)
             {
                 NSMutableDictionary *tempDict =[[NSMutableDictionary alloc]initWithDictionary:[tempArray objectAtIndex:i]];
                int valueint=[[tempDict valueForKey:@"Value"] intValue];
                 Card *card =[[Card alloc]initWithSuit:[[tempDict valueForKey:@"Suit"] intValue]  value:valueint];
                 [appDelegate().cummulativeCards addObject:card];
             }
         }
         
     }];
    //[self startClientGameWithSession:@"T1" playerName:@"nag" serverid:@"2"];
    [self performSelector:@selector(startClientGameWithSession) withObject:self afterDelay:0.3];
}

- (void)dealloc
{
#ifdef DEBUG
     NSLog(@"dealloc %@", self);
#endif
}

#pragma mark - Delegate Methods of Clients and Server

- (void)startClientGameWithSession  //:(NSString *)table playerName:(NSString *)name serverid:(NSString *)ID
{
    self.isServer = NO;
    
    [self changeRelativePositionsOfPlayers];
    Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
    NSMutableDictionary *playerCards = [NSMutableDictionary dictionaryWithCapacity:7];
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, Player *obj, BOOL *stop)
     {
         NSArray *array = [obj.closedCards array];
         [playerCards setObject:array forKey:obj.ID];
     }];
    NSLog(@"Reached Clinet Delegate");
     [self.delegate gameShouldDealCards:self startingWithPlayer:startingPlayer];
}
- (void)startServerGameWithSession:(NSString *)table playerName:(NSString *)name clients:(NSMutableArray *)clients;
{
    NSLog(@"Server Delegate method");
    clients =[[NSMutableArray alloc]initWithArray:appDelegate().clients];
    self.isServer = YES;
    // Create the Player object for the server.
    Player * player = [[Player alloc] init];
    player.name = [[appDelegate().clients valueForKey:@"nick_name"] objectAtIndex:0];
    player.ID =[[appDelegate().clients valueForKey:@"user_id"] objectAtIndex:0];
    player.Image=[[appDelegate().clients valueForKey:@"user_image"] objectAtIndex:0];
    player.Score=[[appDelegate().clients valueForKey:@"temp_score"] objectAtIndex:0];
    player.dealer=[[appDelegate().clients valueForKey:@"Dealer"] objectAtIndex:0];
    player.smallBlind=[[appDelegate().clients valueForKey:@"SmallBlind"] objectAtIndex:0];
    player.bigBlind=[[appDelegate().clients valueForKey:@"BigBlind"] objectAtIndex:0];
    player.status=[[appDelegate().clients valueForKey:@"Status"] objectAtIndex:0];
    player.serverindex=[[appDelegate().clients valueForKey:@"index"] objectAtIndex:0];
    player.allin=[[appDelegate().clients valueForKey:@"Allin"] objectAtIndex:0];
    player.position = PlayerPositionMiddle;
    player.bet =@"0";
    [_players setObject:player forKey:player.ID];
    
    int index = 0;
    [clients removeObjectAtIndex:0];
    //NSMutableArray *tempArray =[[NSMutableArray alloc]init];
    
    for (NSString *ID in clients)
    //for(int i=0;i<clients.count;i++)
        {
        Player *player = [[Player alloc] init];
        player.ID = [[clients valueForKey:@"user_id"] objectAtIndex:index];
        player.name=[[clients valueForKey:@"nick_name"] objectAtIndex:index];
        player.Image=[[clients valueForKey:@"user_image"] objectAtIndex:index];
        player.Score=[[clients valueForKey:@"temp_score"] objectAtIndex:index];
        player.dealer=[[clients valueForKey:@"Dealer"] objectAtIndex:index];
        player.smallBlind=[[clients valueForKey:@"SmallBlind"] objectAtIndex:index];
        player.bigBlind=[[clients valueForKey:@"BigBlind"] objectAtIndex:index];
        player.status=[[clients valueForKey:@"Status"] objectAtIndex:index];
        player.serverindex=[[clients valueForKey:@"index"] objectAtIndex:index];
        player.allin=[[clients valueForKey:@"Allin"] objectAtIndex:index];
        player.bet =@"0";
        if (index == 0){
            player.position =PlayerPositionLBottom;   //;([clients count] == 1) ? PlayerPositionLBottom : PlayerPositionLBottom;
        }
        else if (index == 1)
        {
            player.position = PlayerPositionLMiddle;
        }
        else  if (index == 2)
        {
            player.position = PlayerPositionLTop;
        }
        else  if (index == 3)
        {
            player.position = PlayerPositionRTop;
        }
        else  if (index == 4)
        {
            player.position = PlayerPositionRMiddle;
        }
        else
        {
            player.position = PlayerPositionRBottom;
        }
            
        [_players setObject:player forKey:player.ID];
         index++;
    }
        
    [self beginGame];
    
    //[self performSelector:@selector(activeStartingPlayer) withObject:self afterDelay:0.5];
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"Startingplayer" forKey:@"type"];
    [dict setObject:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer] forKey:@"Id"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
     
}
-(void)activeStartingPlayer
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"Startingplayer" forKey:@"type"];
    [dict setObject:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer] forKey:@"Id"];
    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
}
- (Player *)playerAtPosition:(PlayerPosition)position
{
    NSAssert(position >= PlayerPositionBottom && position <= PlayerPositionRight, @"Invalid player position");
    
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
-(NSString*)playerUserId:(PlayerPosition)position
{
    NSAssert(position >= PlayerPositionBottom && position <= PlayerPositionRight, @"Invalid player position");

    __block Player *player;
    
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         
         player = obj;
         if (player.position == position)
             *stop = YES;
         else
             player = nil;
     }];
    return player.ID;
}

- (void)beginGame
{
    
    if (self.isServer)
    {
        [self pickRandomStartingPlayer];
        [self dealCards];
    }
}

- (void)changeRelativePositionsOfPlayers
{
    NSAssert(!self.isServer, @"Must be client");
   
    Player *myPlayer = [self playerWithPeerID:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]];
    int position = myPlayer.position;
    myPlayer.position = PlayerPositionMiddle;
    int diff;
    if(position>3)
    diff = position-3;
    else
    diff = 3-position;
    
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, Player *obj, BOOL *stop)
     {
         if (obj != myPlayer)
         {
//             if(obj.position<=3)
//             {
//             obj.position = (obj.position + diff)  ;
//             }
//             else
//             {
//             obj.position = (obj.position - diff)  ;
//             }
             if(position>3)
             obj.position = (obj.position - diff);
             else
             obj.position = (obj.position + diff);
             int value =obj.position;
             if(value==7)
                 obj.position=0;
             else if (value==8)
                 obj.position=1;
             else if (value==9)
                 obj.position=2;
             else if (value==-1)
                 obj.position=6;
             else if (value==-2)
                 obj.position=5;
             else if (value==-3)
                 obj.position=4;
                
         }
         
         
     }];
    testPosition = diff;
    
}
- (Player *)playerWithPeerID:(NSString *)peerID
{
    return [_players objectForKey:peerID];
}
- (void)pickRandomStartingPlayer
{
    do
    {
        _startingPlayerPosition = arc4random() % 7;
    }
    while ([self playerAtPosition:_startingPlayerPosition] == nil);
    
    _activePlayerPosition = _startingPlayerPosition;
}
- (void)beginRound
{
     Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
  //  Player *startingPlayer = [self playerAtPosition:appDelegate().StaringPlayer];
    _activePlayerPosition = startingPlayer.position;
        [self activatePlayerAtPositionat:_activePlayerPosition];
}
- (void)activatePlayerAtPosition:(PlayerPosition)playerPosition
{
    if (self.isServer)
    {
        NSString *peerID = [self activePlayer].ID;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:peerID forKey: @"UserId"];
        [dict setObject:@"ActivePlayer" forKey:@"type"];
        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
        //[self.delegate game:self didActivatePlayer:[self activePlayer]];
    }
    else
    {
     [self.delegate game:self didActivatePlayer:[self activePlayer]];
    }
}
- (void)activatePlayerAtPositionat:(PlayerPosition)playerPosition
{
    if (self.isServer)
    {
        NSString *peerID = [self activePlayer].ID;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject:peerID forKey: @"UserId"];
        [dict setObject:@"ActivePlayer" forKey:@"type"];
        
        //[PubNub sendMessage:dict toChannel:[PNChannel channelWithName:@"BlackJack"]];
        [self.delegate game:self didActivatePlayer:[self activePlayer]];
    }
    else
    {
        [self.delegate game:self didActivatePlayer:[self activePlayer]];
    }
}


- (void)turnCardForActivePlayer
{
    if (self.isServer)
        [self performSelector:@selector(activateNextPlayer) withObject:nil afterDelay:0.5f];
    
}
- (void)activateNextPlayer
{
    NSAssert(self.isServer, @"Must be server");
    
    while (true)
    {   /*
        NSMutableArray *allPlayersScore =[[NSMutableArray alloc]init];
        for(int i=0;i<=7;i++){
            Player *allPlayers =[self playerAtPosition:i];
            if (allPlayers != nil ){
                int value = [allPlayers.Score intValue];
                [allPlayersScore addObject:[NSNumber numberWithInt:value]];
            }
        }
        NSMutableArray *filteredArray = [allPlayersScore mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        NSLog(@"filteredArray %@",filteredArray);
        allInAmount=[filteredArray objectAtIndex:0];
        NSLog(@"allInAmount %@",allInAmount);*/
        if (_activePlayerPosition > PlayerPositionRTop)
            _activePlayerPosition = PlayerPositionLTop;
        
        Player *nextPlayer = [self activePlayer];
        if (nextPlayer != nil )//&& [nextPlayer.status isEqualToString:@"Active"])
        {
            //if (([nextPlayer.closedCards cardCount] >0 && ![nextPlayer.smallBlind isEqualToString:@"Yes"])||([nextPlayer.openCards cardCount]>0 && ![nextPlayer.smallBlind isEqualToString:@"Yes"])||([nextPlayer.closedCards cardCount] >0 && ![nextPlayer.bigBlind isEqualToString:@"Yes"])||([nextPlayer.openCards cardCount] >0 && ![nextPlayer.bigBlind isEqualToString:@"Yes"]))
            if(![nextPlayer.smallBlind isEqualToString:@"Yes"]||![nextPlayer.smallBlind isEqualToString:@"Yes"])
            {
                NSLog(@"First");
                if(([nextPlayer.status isEqualToString:@"Not Active"]&&[nextPlayer.dealer isEqualToString:@"Yes"]))//[nextPlayer.status isEqualToString:@"Not Active"]&&
                {
                    NSLog(@"Second");
                    if(([firstPlayerBet isEqualToString:betValue ]&&[secondPlayerBet isEqualToString:betValue ]&&[thirdPlayerBet isEqualToString:betValue ]&&[fourthPlayerBet isEqualToString:betValue ]&&[fifthPlayerBet isEqualToString:betValue ]&&[sixthPlayerBet isEqualToString:betValue ]&&[seventhPlayerBet isEqualToString:betValue ] )){
                    if(roundCount==0)
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlopCards" object:self];//updateFlopCards
                         roundCount=roundCount+1;
                         _activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==1)
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTurnCard" object:self];
                         roundCount=roundCount+1;
                         _activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==2){
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                         roundCount=0;
                         //_activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==3){
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                         roundCount=0;
                         //_activePlayerPosition = PlayerPositionMiddle;
                         */
                    }}
                    else{
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:@"checkForRoundCompletion" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                    }
                }
                else if(([nextPlayer.status isEqualToString:@"Not Active"]&&[nextPlayer.dealer isEqualToString:@"No"]))
                {
                    NSLog(@"Sixth");
                    _activePlayerPosition++;
                    Player *inside =[self playerAtPosition:_activePlayerPosition];
                    if(inside!=nil){
                        [self activatePlayerAtPosition:_activePlayerPosition];}
                    else{
                        _activePlayerPosition++;
                        [self activateNextPlayer];}
                    /*
                     NSString *peerID = [self activePlayer].ID;
                     NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                     
                     [dict setObject:peerID forKey: @"UserId"];
                     [dict setObject:@"ActivePlayer" forKey:@"type"];
                     [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:@"BlackJack"]];
                     //[self.delegate game:self didActivatePlayer:[self activePlayer]];*/
                    return;
                }
                else if(([nextPlayer.bigBlind isEqualToString:@"Yes"]&&[nextPlayer.dealer isEqualToString:@"Yes"]))
                {
                    NSLog(@"Seventh");
//                    if(roundCount==0)
//                    {
//                    [self activatePlayerAtPosition:_activePlayerPosition];
//                    Player *startingPlayer = [self playerWithPeerID:[NSString stringWithFormat:@"%d",appDelegate().StaringPlayer]];
//                    _activePlayerPosition = startingPlayer.position;
//                    NSLog(@"_activePlayerPosition %u",_activePlayerPosition);
//                    }
//                    else
                      [self activatePlayerAtPosition:_activePlayerPosition];
                    return;
                }
                else
                {
                NSLog(@"Third");
                [self activatePlayerAtPosition:_activePlayerPosition];
                    /*
                    NSString *peerID = [self activePlayer].ID;
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    
                    [dict setObject:peerID forKey: @"UserId"];
                    [dict setObject:@"ActivePlayer" forKey:@"type"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:@"BlackJack"]];
                    //[self.delegate game:self didActivatePlayer:[self activePlayer]];*/
                return;
                }
            }
            else if([nextPlayer.smallBlind isEqualToString:@"Yes"])
            {
                NSLog(@"Fifth");
                NSLog(@"Bet Values %@,%@,%@,%@,%@,%@,%@",firstPlayerBet,secondPlayerBet,thirdPlayerBet,fourthPlayerBet,fifthPlayerBet,sixthPlayerBet,seventhPlayerBet);
                if(([firstPlayerBet isEqualToString:betValue ]&&[secondPlayerBet isEqualToString:betValue ]&&[thirdPlayerBet isEqualToString:betValue ]&&[fourthPlayerBet isEqualToString:betValue ]&&[fifthPlayerBet isEqualToString:betValue ]&&[sixthPlayerBet isEqualToString:betValue ]&&[seventhPlayerBet isEqualToString:betValue ])){
                    if(roundCount==0)
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlopCards" object:self];//updateFlopCards
                         roundCount=roundCount+1;
                         _activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==1)
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTurnCard" object:self];
                         roundCount=roundCount+1;
                         _activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==2)
                    {
                        
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                         roundCount=0;
                         //_activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                    else if(roundCount==3){
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                        [dict setObject:@"Rounds" forKey:@"type"];
                        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                        [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                        return;
                        /*
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                         roundCount=0;
                         //_activePlayerPosition = PlayerPositionMiddle;
                         */
                    }
                }
                else{
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    [dict setObject:@"checkForRoundCompletion" forKey:@"type"];
                    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                    return;
                }
            }
            else
            {
                NSLog(@"Fourth");
                 if(([firstPlayerBet isEqualToString:betValue ]&&[secondPlayerBet isEqualToString:betValue ]&&[thirdPlayerBet isEqualToString:betValue ]&&[fourthPlayerBet isEqualToString:betValue ]&&[fifthPlayerBet isEqualToString:betValue ]&&[sixthPlayerBet isEqualToString:betValue ]&&[seventhPlayerBet isEqualToString:betValue ] )){
                if(roundCount==0)
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    
                    [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                    [dict setObject:@"Rounds" forKey:@"type"];
                    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];                    return;
                    /*
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateFlopCards" object:self];//updateFlopCards
                    roundCount=roundCount+1;
                    _activePlayerPosition = PlayerPositionMiddle;
                     */
                }
                else if(roundCount==1)
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                    [dict setObject:@"Rounds" forKey:@"type"];
                    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                    return;
                    /*
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTurnCard" object:self];
                    roundCount=roundCount+1;
                    _activePlayerPosition = PlayerPositionMiddle;
                     */
                }
                else if(roundCount==2)
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                    [dict setObject:@"Rounds" forKey:@"type"];
                    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                    return;
                    /*
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                    roundCount=0;
                    //_activePlayerPosition = PlayerPositionMiddle;
                     */
                }
                else if(roundCount==3){
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    [dict setObject:[NSString stringWithFormat:@"%d",roundCount] forKey: @"roundCount"];
                    [dict setObject:@"Rounds" forKey:@"type"];
                    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                    [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                    return;
                    /*
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRiverCard" object:self];//updateRiverCard
                     roundCount=0;
                     //_activePlayerPosition = PlayerPositionMiddle;
                     */
                }
                 }
                 else{
                     NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                     [dict setObject:@"checkForRoundCompletion" forKey:@"type"];
                     [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"] forKey:@"User"];
                     [PubNub sendMessage:dict toChannel:[PNChannel channelWithName:appDelegate().tableNumber]];
                     return;
                 }
            }
        }
        else{
            if(_activePlayerPosition==0){
                firstPlayerBet=betValue;
            }
            else if (_activePlayerPosition==1){
                secondPlayerBet=betValue;
            }
            else if (_activePlayerPosition==2){
                thirdPlayerBet=betValue;
            }
            else if (_activePlayerPosition==3){
                fourthPlayerBet=betValue;
            }
            else if (_activePlayerPosition==4){
                fifthPlayerBet=betValue;
            }
            else if (_activePlayerPosition==5){
                sixthPlayerBet=betValue;
            }
            else if (_activePlayerPosition==6){
                seventhPlayerBet=betValue;
            }
        }
            _activePlayerPosition++;
        
    }
}


- (void)dealCards
{
    NSAssert(self.isServer, @"Must be server");
    NSAssert(_state == GameStateDealing, @"Wrong state");
    
    Deck *deck = [[Deck alloc] init];
    [deck shuffle];
    [appDelegate().cummulativeCards removeAllObjects];
     [appDelegate().cummulativeCards  addObjectsFromArray:[deck  cummilativeCards]];
    NSMutableDictionary *CardsDict =[NSMutableDictionary dictionaryWithCapacity:7];
    
    if ([deck cardsRemaining] > 0)
    {
        for (PlayerPosition p = _startingPlayerPosition; p < _startingPlayerPosition + 7; ++p)
        {
             NSMutableArray *temprray =[[NSMutableArray alloc]init];
            Player *player = [self playerAtPosition:(p % 7)];
            if (player != nil && [deck cardsRemaining] > 0)
            {
                NSString *string =[self playerUserId:player.position];
                for( int i=0;i<2;i++)
                {
                NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]init];
                 Card *card = [deck draw];
                [player.closedCards addCardToTop:card];
                [tempdict setValue:[NSString stringWithFormat:@"%d",card.value] forKey:@"Value"];
                [tempdict setValue:[NSString stringWithFormat:@"%d",card.suit] forKey:@"Suit"];
                [tempdict setValue:player.ID forKey:@"user_id"];
                [tempdict setValue:player.name forKey:@"nick_name"];
                [tempdict setValue:player.Image forKey:@"user_image"];
                [tempdict setValue:player.Score forKey:@"temp_score"];
                [tempdict setValue:player.dealer forKey:@"Dealer"];
                [tempdict setValue:player.smallBlind forKey:@"SmallBlind"];
                [tempdict setValue:player.bigBlind forKey:@"BigBlind"];
                [tempdict setValue:player.status forKey:@"Status"];
                [tempdict setValue:player.serverindex forKey:@"index"];
                [tempdict setValue:[NSString stringWithFormat:@"%u",player.position] forKey:@"Position"];
                [temprray addObject:tempdict];
                }
             [CardsDict setObject:temprray forKey:string];
            }
            
        }
    }
    [CardsDict setObject:@"Cards" forKey:@"type"];
    Player *startingPlayer = [self activePlayer];
    [CardsDict setObject:[NSString stringWithFormat:@"%u",startingPlayer.position] forKey:@"StaringPlayer"];
    NSMutableArray *tempArray =[[NSMutableArray alloc]init];
    for(int i=0;i<5;i++)
    {
        Card *card = [appDelegate().cummulativeCards objectAtIndex:i];
        NSMutableDictionary *tempdict =[[NSMutableDictionary alloc]init];
        [tempdict setValue:[NSString stringWithFormat:@"%d",card.value] forKey:@"Value"];
        [tempdict setValue:[NSString stringWithFormat:@"%d",card.suit] forKey:@"Suit"];
        [tempArray addObject:tempdict];

    }
    [CardsDict setObject:tempArray forKey:@"CummulativeCards"];

    NSMutableDictionary *playerCards = [NSMutableDictionary dictionaryWithCapacity:7];
    [_players enumerateKeysAndObjectsUsingBlock:^(id key, Player *obj, BOOL *stop)
     {
         NSArray *array = [obj.closedCards array];
         [playerCards setObject:array forKey:obj.ID];
        
     }];
    [PubNub sendMessage:CardsDict toChannel:[PNChannel channelWithName:appDelegate().tableNumber] withCompletionBlock:^(PNMessageState message,id state)
     {
         UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Posted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         //[alert show];
     }];
    //[self.delegate gameShouldDealCards:self startingWithPlayer:startingPlayer];
}
- (Player *)activePlayer
{
   return [self playerAtPosition:_activePlayerPosition];
}
- (void)activePlayerForWinningConditions
{
        _activePlayerPosition++;
    
        if (_activePlayerPosition > PlayerPositionRTop)
            _activePlayerPosition = PlayerPositionLTop;
        
        Player *nextPlayer = [self activePlayer];
        if (nextPlayer != nil)
        {
                return ;
        }
            else
            {
                [self activePlayerForWinningConditions];
                
            }
}
- (void)CheckWinningConditions
{
    _activePlayerPosition++;
    if (_activePlayerPosition > PlayerPositionRTop)
        return;
    
    Player *nextPlayer = [self activePlayer];
    if (nextPlayer != nil)
    {
        return ;
    }
    else
    {
        [self CheckWinningConditions];
        return;
        
    }
    
    
}
- (Player *)bottomactivePlayer
{
    _activePlayerPosition=PlayerPositionMiddle;
    return [self playerAtPosition:_activePlayerPosition];
}


@end
