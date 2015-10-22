//
//  Card.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize suit = _suit;
@synthesize value = _value;
@synthesize isTurnedOver = _isTurnedOver;

- (id)initWithSuit:(Suit)suit value:(int)value
{
    NSAssert(value >= 1 && value <= CardAce, @"Invalid card value");
    
    if ((self = [super init]))
    {
        _suit = suit;
        _value = value;
    }
    return self;
}
- (BOOL)isEqualToCard:(Card *)otherCard
{
    return (otherCard.suit == self.suit && otherCard.value == self.value);
}



@end
