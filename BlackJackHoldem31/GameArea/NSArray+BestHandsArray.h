//
//  NSArray+BestHandsArray.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 1/21/15.
//  Copyright (c) 2015 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Player.h"
#import "Stack.h"
#import "Deck.h"

@interface NSArray (BestHandsArray)

+(NSArray*)bestHandsInFlopCardsWithOpencards:(NSArray*)myOpencards ;

+(NSArray*)bestHandsInTurnCardsWithOpencards:(NSArray*)myOpencards ;

@end
