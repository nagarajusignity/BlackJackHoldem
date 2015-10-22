//
//  Game.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/14/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class Game;

@protocol GameDelegate <NSObject>

- (void)gameShouldDealCards:(Game *)game startingWithPlayer:(Player *)startingPlayer;
- (void)game:(Game *)game didActivatePlayer:(Player *)player;


@end

@interface Game : NSObject
{
    int                  roundCount;

}
@property (nonatomic, weak) id <GameDelegate> delegate;
@property (nonatomic, assign) BOOL isServer;
@property (nonatomic, assign) BOOL Received;
@property (nonatomic, assign) PlayerPosition _activePlayerPosition;
@property (nonatomic, copy) NSString *firstPlayerBet;
@property (nonatomic, copy) NSString *secondPlayerBet;
@property (nonatomic, copy) NSString *thirdPlayerBet;
@property (nonatomic, copy) NSString *fourthPlayerBet;
@property (nonatomic, copy) NSString *fifthPlayerBet;
@property (nonatomic, copy) NSString *sixthPlayerBet;
@property (nonatomic, copy) NSString *seventhPlayerBet;
@property (nonatomic, copy) NSString *betValue;

- (void)startClientGameWithSession:(NSString *)table playerName:(NSString *)name serverid:(NSString *)ID;
- (void)startServerGameWithSession:(NSString *)table playerName:(NSString *)name clients:(NSArray *)clients;
- (Player *)playerAtPosition:(PlayerPosition)position;
- (void)activePlayerForWinningConditions;
- (void)CheckWinningConditions;
- (void)beginGame;
- (Player *)activePlayer;
- (Player *)bottomactivePlayer;
- (Player *)playerWithPeerID:(NSString *)peerID;
- (void)beginRound;
- (void)turnCardForActivePlayer;
- (void)activateNextPlayer;
- (void)activatePlayerAtPosition:(PlayerPosition)playerPosition;

@end
