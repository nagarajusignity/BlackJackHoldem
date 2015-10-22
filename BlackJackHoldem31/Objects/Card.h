//
//  Card.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    SuitClubs,
    SuitDiamonds,
    SuitHearts,
    SuitSpades
}
Suit;

#define CardAce   1
#define CardJack  11
#define CardQueen 12
#define CardKing  13

@interface Card : NSObject

@property (nonatomic, assign, readonly) Suit suit;
@property (nonatomic, assign, readonly) int value;
@property (nonatomic, assign) BOOL isTurnedOver;

- (id)initWithSuit:(Suit)suit value:(int)value;
- (BOOL)isEqualToCard:(Card *)otherCard;
@end
