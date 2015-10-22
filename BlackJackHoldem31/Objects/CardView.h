//
//  CardView.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/29/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

const CGFloat CardWidth;
const CGFloat CardHeight;

@class Card;
@class Player;

@interface CardView : UIView

{
    BOOL isFirst;
    BOOL isFirstBestCard;
    BOOL isSecondBestCard;
    BOOL isThirdBestCard;
    
}
typedef void (^CompletionBlock)();

@property (strong,nonatomic) CompletionBlock successCallback;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,assign)BOOL isFirstBestCard;
@property(nonatomic,assign)BOOL isSecondBestCard;
@property(nonatomic,assign)BOOL isThirdBestCard;
@property (nonatomic, strong) Card *card;

- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay angle:(float)angle Xvalue:(float)Xaxies Yvalue:(float)Yaxies;
- (void)animateTurningOverForPlayer:(Player *)player success:(CompletionBlock)callback;

- (void)animateTurningOverForAllPlayer:(Player *)player success:(CompletionBlock)callback;

-(void)animateFlopCardswithDelay:(NSTimeInterval)delay;
-(void)animateFlopCardsTurnOverWithsuccess:(CompletionBlock)callback;

-(void)animateRiverCardswithDelay:(NSTimeInterval)delay;
-(void)animateRiverCardsTurnOverWithsuccess:(CompletionBlock)callback;

-(void)animateTurnCardswithDelay:(NSTimeInterval)delay;
-(void)animateTurnCardsTurnOverWithsuccess:(CompletionBlock)callback;

- (void)animateRecycleForAllPlayers;

-(void)animateBestHandsCards;
-(void)animateBestHandsCardsWithDelay:(NSTimeInterval)delay;
-(void)animateBestHandCardsTurnOverWithsuccess:(CompletionBlock)callback;
- (void)animateBestHandCardsForAllPlayersWithValue:(int)value;


- (void)animateCloseAndMoveFromPlayer:(Player *)fromPlayer value:(int)value;  //toPlayer:(Player *)toPlayer withDelay:(NSTimeInterval)delay;
- (void)animateCloseAndRemoveFoldCardsFromPlayer:(Player *)fromPlayer value:(int)value;
- (void)animateTheCradsToMoveAsideForPlayer:(Player *)fromPlayer value:(int)value OnFirstTime :(BOOL)firstTime;

@end

