//
//  Player.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Player.h"
#import "Card.h"
#import "Stack.h"

@implementation Player
@synthesize position = _position;
@synthesize name = _name;
@synthesize peerID = _peerID;
@synthesize receivedResponse = _receivedResponse;
@synthesize gamesWon = _gamesWon;
@synthesize closedCards = _closedCards;
@synthesize openCards = _openCards;

- (id)init
{
    if ((self = [super init]))
    {
        _closedCards = [[Stack alloc] init];
        _openCards = [[Stack alloc] init];
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"dealloc %@", self);
#endif
}

- (Card *)turnOverTopCard
{
    NSAssert([self.closedCards cardCount] > 0, @"No more cards");
    
    Card *card = [self.closedCards topmostCard];
    card.isTurnedOver = YES;
    [self.openCards addCardToTop:card];
    [self.closedCards removeTopmostCard];
    
    return card;
}
- (Card *)turnOveropenCards
{
    NSAssert([self.openCards cardCount] > 0, @"No more cards");
    
    Card *card = [self.openCards topmostCard];
    [self.openCards removeTopmostCard];
    
    return card;
}

- (BOOL)shouldRecycle
{
    return ([self.closedCards cardCount] == 0) && ([self.openCards cardCount] > 1);
}

- (NSArray *)recycleCards
{
    return [self giveAllOpenCardsToPlayer:self];
}

- (NSArray *)giveAllOpenCardsToPlayer:(Player *)otherPlayer
{
    NSUInteger count = [self.openCards cardCount];
    NSMutableArray *movedCards = [NSMutableArray arrayWithCapacity:count];
    
    for (NSUInteger t = 0; t < count; ++t)
    {
        Card *card = [self.openCards cardAtIndex:t];
        card.isTurnedOver = NO;
        [otherPlayer.closedCards addCardToBottom:card];
        [movedCards addObject:card];
    }
    
    [self.openCards removeAllCards];
    return movedCards;
}

- (int)totalCardCount
{
    return [self.closedCards cardCount] + [self.openCards cardCount];
}

@end
