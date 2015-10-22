//
//  Deck.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Card;

@interface Deck : NSObject


- (void)shuffle;
- (Card *)draw;
- (int)cardsRemaining;
- (NSArray*)cummilativeCards;
- (int)cummilativeCardsCount;
@end
