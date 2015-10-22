//
//  Stack.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Stack.h"
#import "Card.h"

@implementation Stack
{
    NSMutableArray *_cards;
}

- (id)init
{
    if ((self = [super init]))
    {
        _cards = [NSMutableArray arrayWithCapacity:13];
    }
    return self;
}

- (void)addCardToTop:(Card *)card
{
    NSAssert(card != nil, @"Card cannot be nil");
    NSAssert([_cards indexOfObject:card] == NSNotFound, @"Already have this Card");
    [_cards addObject:card];
}

- (NSUInteger)cardCount
{
    return [_cards count];
}

- (NSArray *)array
{
    return [_cards copy];
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return [_cards objectAtIndex:index];
}

- (void)addCardsFromArray:(NSArray *)array
{
    _cards = [array mutableCopy];
}

- (Card *)topmostCard
{
    return [_cards firstObject];
}

- (void)removeTopmostCard
{
    [_cards removeObjectAtIndex:0];
}

- (void)addCardToBottom:(Card *)card
{
    NSAssert(card != nil, @"Card cannot be nil");
    NSAssert([_cards indexOfObject:card] == NSNotFound, @"Already have this Card");
    [_cards insertObject:card atIndex:0];
}

- (void)removeAllCards
{
    [_cards removeAllObjects];
}

@end
