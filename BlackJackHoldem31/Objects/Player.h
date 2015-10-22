//
//  Player.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    PlayerPositionLTop,// the user
    PlayerPositionLMiddle,
    PlayerPositionLBottom,
    PlayerPositionMiddle,
    PlayerPositionRBottom,  // the user
    PlayerPositionRMiddle,
    PlayerPositionRTop,
}
PlayerPosition;

@class Card;
@class Stack;

@interface Player : NSObject

@property (nonatomic, assign) PlayerPosition position;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Score;
@property (nonatomic, copy) NSString *Image;
@property (nonatomic, copy) NSString *bigBlind;
@property (nonatomic, copy) NSString *smallBlind;
@property (nonatomic, copy) NSString *dealer;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *serverindex;
@property (nonatomic, copy) NSString *allin;
@property (nonatomic, copy) NSString *bet;
@property (nonatomic, assign) BOOL receivedResponse;
@property (nonatomic, assign) int gamesWon;
@property (nonatomic, strong, readonly) Stack *closedCards;
@property (nonatomic, strong, readonly) Stack *openCards;
@property (nonatomic, copy) NSString *ID;

- (Card *)turnOverTopCard;
- (BOOL)shouldRecycle;
- (NSArray *)recycleCards;
- (int)totalCardCount;
- (Card *)turnOveropenCards;


@end
