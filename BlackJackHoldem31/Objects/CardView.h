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
    
}
typedef void (^CompletionBlock)();

@property (strong,nonatomic) CompletionBlock successCallback;
@property(nonatomic,assign)BOOL isFirst;
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

- (void)animateCloseAndMoveFromPlayer:(Player *)fromPlayer value:(int)value;  //toPlayer:(Player *)toPlayer withDelay:(NSTimeInterval)delay;

@end

