//
//  Deck.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck

{
    NSMutableArray *_cards;
    NSMutableArray *movedCards;
}

- (void)setUpCards
{   if(isFirstTime==YES)
    isFirstTime=NO;
    else
    isFirstTime=YES;
    
    for (Suit suit = SuitClubs; suit <= SuitSpades; ++suit)
    {
        
        for (int value = CardAce /*CardQueen*/; value <= CardKing; ++value)
        {
            if(isFirstTime==YES){
            if(value==2||value==3||value==4){
            }
            else{
            Card *card = [[Card alloc] initWithSuit:suit value:value];
            [_cards addObject:card];
            }
            }
            else{
            Card *card = [[Card alloc] initWithSuit:suit value:value];
            [_cards addObject:card];
            }
        }
    }
}

- (id)init
{
    if ((self = [super init]))
    {
        _cards = [NSMutableArray arrayWithCapacity:52];
        movedCards = [NSMutableArray arrayWithCapacity:5];
        [self setUpCards];
    }
    return self;
}

- (int)cardsRemaining
{
    return [_cards count];
}

- (void)shuffle
{
    NSUInteger count = [_cards count];
    NSMutableArray *shuffled = [NSMutableArray arrayWithCapacity:count];
    
    for (int t = 0; t < count; ++t)
    {
        int i = arc4random() % [self cardsRemaining];
        Card *card = [_cards objectAtIndex:i];
        [shuffled addObject:card];
        [_cards removeObjectAtIndex:i];
    }
    
    NSAssert([self cardsRemaining] == 0, @"Original deck should now be empty");
    
    _cards = shuffled;
    
    [self addcumulativecards];
}

- (NSArray*)cummilativeCards
{
    return movedCards;
}
- (int)cummilativeCardsCount
{
    return [movedCards count];
}
-(NSArray*)addcumulativecards
{
    
    for(int i=0;i<5;i++)
    {
        Card *card = [_cards objectAtIndex:i];
        [movedCards addObject:card];
        [_cards removeObjectAtIndex:i];
    }

    return movedCards;
}

- (Card *)draw
{
    NSAssert([self cardsRemaining] > 0, @"No more cards in the deck");
    Card *card = [_cards lastObject];
    [_cards removeLastObject];
    
    return card;
}

@end
