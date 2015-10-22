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
@property (nonatomic, assign) BOOL receivedResponse;
@property (nonatomic, assign) int gamesWon;
@property (nonatomic, strong, readonly) Stack *closedCards;
@property (nonatomic, strong, readonly) Stack *openCards;
@property (nonatomic, copy) NSString *peerID;

- (Card *)turnOverTopCard;
- (BOOL)shouldRecycle;
- (NSArray *)recycleCards;
- (int)totalCardCount;
- (Card *)turnOveropenCards;


@end
