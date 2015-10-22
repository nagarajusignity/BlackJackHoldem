//
//  Stack.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface Stack : NSObject

- (void)addCardToTop:(Card *)card;
- (NSUInteger)cardCount;
- (NSArray *)array;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)addCardsFromArray:(NSArray *)array;
- (Card *)topmostCard;
- (void)removeTopmostCard;
- (void)addCardToBottom:(Card *)card;
- (void)removeAllCards;
@end
