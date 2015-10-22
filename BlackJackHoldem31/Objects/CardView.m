//
//  CardView.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/29/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "Card.h"
#import "Player.h"
#import "AppDelegate.h"

const CGFloat CardWidth =24;  //37.0f;   // this includes drop shadows
const CGFloat CardHeight =36;   //59.0f;


@implementation CardView
{
    UIImageView *_backImageView;
    UIImageView *_frontImageView;
    CGFloat _angle;
}

@synthesize card = _card;
@synthesize successCallback;
@synthesize isFirst;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        [self loadBack];
        
    }
    return self;
}

- (void)loadBack
{
    if (_backImageView == nil)
    {
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.image = [UIImage imageNamed:@"Back"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_backImageView];
    }
}

- (CGPoint)centerForPlayer:(Player *)player Xvalue:(float)Xaxies  Yvalue:(float)Yaxies
{
    CGRect rect = self.superview.bounds;
    CGFloat midX = CGRectGetMidX(rect);
    //CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat x  =10+Xaxies;
    CGFloat y  =10+Yaxies;
    
    if (self.card.isTurnedOver)
    {
        if (player.position == PlayerPositionMiddle)
        {
            if(isFirst==NO)
            {
                isFirst =YES;
                if(isiPhone5())
                {
                x += midX-32;
                y += maxY - CardHeight-60 ;
                }
                else
                {
                x += midX-33;
                y += maxY - CardHeight-60 ;
                }
            }
            else if(isFirst==YES)
            {
                if(isiPhone5())
                {
                x += midX-5;
                y += maxY - CardHeight-60 ;
                isFirst=NO;
                }
                else
                {
                    x += midX-6;
                    y += maxY - CardHeight-60 ;
                    isFirst=NO;
                }
            }
            
            
        }
        else if (player.position == PlayerPositionLBottom)
        {
            x += 31.0f;
            y += maxY - CardHeight ;   //midY - CardWidth - 45.0f;
        }
        else if (player.position == PlayerPositionRBottom)
        {
            x += midX + 170.0f;
            y += 29.0f;
        }
        else
        {
            x += maxX - CardHeight + 1.0f;
            y += maxY - CardHeight ;  //midY - 30.0f;
        }
    }
    else
    {
        if (player.position == PlayerPositionLTop)
        {
            x += 365+70*isiPhone5();//435
            y += 45 ;
           
            
        }
        else if (player.position == PlayerPositionLMiddle)
        {
            x += 380+90*isiPhone5();
            y += 110;   //midY - CardWidth - 45.0f;
        }
        else if (player.position == PlayerPositionLBottom)
        {
            x += 380+75*isiPhone5();
            y += 232;
        }
        
        else if (player.position == PlayerPositionMiddle)
        {
            x += 230+40*isiPhone5();
            y += 225;
        }
        
        else if (player.position == PlayerPositionRBottom)
        {
            x += 80+16*isiPhone5();
            y += 230;
        }
        else if (player.position == PlayerPositionRMiddle)
        {
            x += 80;
            y += 105;
        }
        else
        {
            x += 90+25*isiPhone5();
            y += 45;
        }
        
    }
    return CGPointMake(x, y);
}

- (void)unloadBack
{
    [_backImageView removeFromSuperview];
    _backImageView = nil;
}

- (void)loadFront
{
    if (_frontImageView == nil)
    {
        _frontImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _frontImageView.contentMode = UIViewContentModeScaleToFill;
        _frontImageView.hidden = YES;
        [self addSubview:_frontImageView];
        
        NSString *suitString;
        switch (self.card.suit)
        {
            case SuitClubs:    suitString = @"Clubs"; break;
            case SuitDiamonds: suitString = @"Diamonds"; break;
            case SuitHearts:   suitString = @"Hearts"; break;
            case SuitSpades:   suitString = @"Spades"; break;
        }
        
        NSString *valueString;
        switch (self.card.value)
        {
            case CardAce:   valueString = @"Ace"; break;
            case CardJack:  valueString = @"Jack"; break;
            case CardQueen: valueString = @"Queen"; break;
            case CardKing:  valueString = @"King"; break;
            default:        valueString = [NSString stringWithFormat:@"%d", self.card.value];
        }
        
        NSString *filename = [NSString stringWithFormat:@"%@ %@", suitString, valueString];
        _frontImageView.image = [UIImage imageNamed:filename];
    }
}

- (CGFloat)angleForPlayer:(Player *)player
{
    float theAngle = (-0.5f + RANDOM_FLOAT()) / 8.0f;
    
    if (player.position == PlayerPositionLTop)
        theAngle += M_PI / 2.0f;
    else if (player.position == PlayerPositionLBottom)
        theAngle += M_PI;
    else if (player.position == PlayerPositionRBottom)
        theAngle -= M_PI / 2.0f;
    
    return theAngle;
}

#pragma mark Animate Player Cards


- (void)animateDealingToPlayer:(Player *)player withDelay:(NSTimeInterval)delay angle:(float)angle Xvalue:(float)Xaxies Yvalue:(float)Yaxies;
{
    self.frame = CGRectMake(230.0f+45*isiPhone5(), 105.0f, CardWidth, CardHeight);
    self.transform = CGAffineTransformMakeRotation(M_PI);
    
    CGPoint point = [self centerForPlayer:player Xvalue:Xaxies Yvalue:Yaxies];
    //_angle = [self angleForPlayer:player];
    _angle =angle;
    [UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.center = point;
         self.transform = CGAffineTransformMakeRotation(_angle);
     }
                     completion:nil];
}


- (void)animateTurningOverForPlayer:(Player *)player success:(CompletionBlock)callback
{
    
    [self loadFront];
    [self.superview bringSubviewToFront:self];
    
    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
    darkenView.backgroundColor = [UIColor clearColor];
    darkenView.image = [UIImage imageNamed:@"Darken"];
    darkenView.alpha = 0.0f;
    [self addSubview:darkenView];
    
    CGPoint startPoint = self.center;
    CGPoint endPoint = [self centerForPlayer:player Xvalue:10 Yvalue:10];
    CGFloat afterAngle = 0; //[self angleForPlayer:player];
    
    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
    successCallback= callback;
    successCallback();
    
}

- (void)animateTurningOverForAllPlayer:(Player *)player success:(CompletionBlock)callback
{
    [self loadFront];
    [self.superview bringSubviewToFront:self];
    
    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
    darkenView.backgroundColor = [UIColor clearColor];
    darkenView.image = [UIImage imageNamed:@"Darken"];
    darkenView.alpha = 0.0f;
    [self addSubview:darkenView];
    
    CGPoint startPoint = self.center;
    CGPoint endPoint = [self centerForAllPlayers:player Xvalue:10 Yvalue:10];
    CGFloat afterAngle;
    if(isFirst==YES)
    {
        afterAngle =0;  //[self angleForPlayer:player];
    }
    else
    {
        afterAngle =0;//35
    }
    
    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
    successCallback= callback;
    successCallback();
}

- (CGPoint)centerForAllPlayers:(Player *)player Xvalue:(float)Xaxies  Yvalue:(float)Yaxies
{
    CGRect rect = self.superview.bounds;
    CGFloat midX = CGRectGetMidX(rect);
    //CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat x  =10+Xaxies;
    CGFloat y  =10+Yaxies;
    
    if (self.card.isTurnedOver)
    {
        
        if (player.position == PlayerPositionLTop)
        {
            if(isFirst==NO)
            {
               if(isiPhone5())
               {
                x += 453;
                y += 35 ;//35
               }
                else
                {
                    x += 380;
                    y += 35 ;//35
                }
            }
            else
            {
                if(isiPhone5())
                {
                x += 450-CardWidth;
                y += 35 ;//35
                }
                else
                {
                x += 377-CardWidth;
                y += 35 ;//35
                }
            }
            
        }
        else if (player.position == PlayerPositionLMiddle)
        {
            if(isFirst==NO)
            {
                if(isiPhone5())
                {
                x += 470;
                y += 100 ;
                }
                else
                {
                    x += 380;
                    y += 100 ;
                }
            }
            else
            {
                if(isiPhone5())
                {
                    x += 467-CardWidth;
                    y += 100 ;
                }
                else
                {
                x += 377-CardWidth;
                y += 100 ;
                }
            }
        }
        else if (player.position == PlayerPositionLBottom)
        {
            if(isFirst==NO)
            {
                if(isiPhone5())
                {
                x += 473;
                y += 220;
                }
                else
                {
                    x += 380;
                    y += 220;
                }
            }
            else
            {
                if(isiPhone5())
                {
                x += 470-CardWidth;
                y += 220;
                }
                else
                {
                    x += 377-CardWidth;
                    y += 220;
                }
            }
        }
        else if (player.position == PlayerPositionRBottom)
        {
            if(isFirst==NO)
        {
            if(isiPhone5())
            {
            x += 85;
            y += 220;
            }
            else
            {
                x += 88;
                y += 220;
            }
        }
        else
        {
            if(isiPhone5())
            {
            x += 82-CardWidth;
            y += 220;
            }
            else
            {
                x += 85-CardWidth;
                y += 220;
            }
        }
            
        }
        else if (player.position == PlayerPositionRMiddle)
        {
            
            if(isFirst==NO)
            {
                x += 88;
                y += 100;
            }
            else
            {
                x += 85-CardWidth;
                y += 100;
            }
        }
        else if (player.position == PlayerPositionRTop)
        {
            
            if(isFirst==NO)
            {
                if(isiPhone5())
                {
                x += 98;
                y += 35;
                }
                else
                {
                    x += 88;
                    y += 35;
                }
                isFirst =YES;
            }
            else
            {
                if(isiPhone5())
                {
                x += 95-CardWidth;
                y += 35;
                }
                else
                {
                    x += 85-CardWidth;
                    y += 35;
                }
                isFirst =NO;
            }
        }
    }
    else
    {
        if (player.position == PlayerPositionLTop)
        {
            x += midX;  //- CardWidth - 7.0f;
            y += maxY - CardHeight ;
            
        }
        else if (player.position == PlayerPositionLBottom)
        {
            x += 31.0f;
            y += maxY - CardHeight ;   //midY - CardWidth - 45.0f;
        }
        else if (player.position == PlayerPositionRBottom)
        {
            x += midX + 170.0f;
            y += 29.0f;
        }
        else
        {
            x += maxX - CardHeight + 1.0f;
            y += maxY - CardHeight ;  //midY - 30.0f;
        }
    }
    return CGPointMake(x, y);
}



#pragma mark Flop Cards

-(void)animateFlopCardsTurnOverWithsuccess:(CompletionBlock)callback
{
    [self loadFront];
    [self.superview bringSubviewToFront:self];
    
    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
    darkenView.backgroundColor = [UIColor clearColor];
    darkenView.image = [UIImage imageNamed:@"Darken"];
    darkenView.alpha = 0.0f;
    [self addSubview:darkenView];
    
    CGPoint startPoint = self.center;
    CGPoint endPoint = [self centeronBoard];
    CGFloat afterAngle =0;   //= [self angleForPlayer:player];
    
    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
    successCallback= callback;
    successCallback();
}

-(void)animateFlopCardswithDelay:(NSTimeInterval)delay
{
    self.frame = CGRectMake(50+10*isiPhone5(), -40.0f, CardWidth, CardHeight);
    self.transform = CGAffineTransformMakeRotation(M_PI);
    
    CGPoint point = [self centeronBoard];
    _angle =0;
    [UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.center = point;
         self.transform = CGAffineTransformMakeRotation(_angle);
     }
                     completion:nil];
}
-(CGPoint)centeronBoard
{
    CGRect rect = self.superview.bounds;
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat x  =10;
    CGFloat y  =10;
    
    if (self.card.isTurnedOver)
    {
        if(isFirst==YES)
        {
            isFirst =YES;
            x += 0;
            y += 10 ;
        }
        else if(isFirst==NO)
        {
            x += 29;
            y += 10 ;
            isFirst=NO;
        }
    }
    else
    {
        if(isFirst==NO)
        {
            isFirst =YES;
            x += 0;
            y += 10 ;
        }
        else if(isFirst==YES)
        {
            x += 29;
            y += 10 ;
            isFirst=NO;
        }
    }
    
    
    return CGPointMake(x, y);
}

#pragma mark Turn Cards

-(void)animateTurnCardswithDelay:(NSTimeInterval)delay
{
    self.frame = CGRectMake(50+10*isiPhone5(), -40.0f, CardWidth, CardHeight);
    self.transform = CGAffineTransformMakeRotation(M_PI);
    
    CGPoint point = [self turnCardsPositiononBoard];
    _angle =0;
    [UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.center = point;
         self.transform = CGAffineTransformMakeRotation(_angle);
     }
                     completion:nil];
}

-(void)animateTurnCardsTurnOverWithsuccess:(CompletionBlock)callback
{
    [self loadFront];
    [self.superview bringSubviewToFront:self];
    
    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
    darkenView.backgroundColor = [UIColor clearColor];
    darkenView.image = [UIImage imageNamed:@"Darken"];
    darkenView.alpha = 0.0f;
    [self addSubview:darkenView];
    
    CGPoint startPoint = self.center;
    CGPoint endPoint = [self turnCardsPositiononBoard];
    CGFloat afterAngle =0;   //= [self angleForPlayer:player];
    
    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
    successCallback= callback;
    successCallback();
}

-(CGPoint)turnCardsPositiononBoard
{
    CGRect rect = self.superview.bounds;
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat x  =10;
    CGFloat y  =10;
    
    if (self.card.isTurnedOver)
    {
        if(isFirst==YES)
        {
            isFirst =YES;
            x += 58;
            y += 10 ;
        }
        else if(isFirst==NO)
        {
            x += 87;
            y += 10 ;
            isFirst=NO;
        }
    }
    else
    {
        if(isFirst==NO)
        {
            isFirst =YES;
            x += 58;
            y += 10 ;
        }
        else if(isFirst==YES)
        {
            x += 87;
            y += 10 ;
            isFirst=NO;
        }
    }
    
    
    return CGPointMake(x, y);
}

#pragma mark River Cards

-(void)animateRiverCardswithDelay:(NSTimeInterval)delay
{
    self.frame = CGRectMake(50+10*isiPhone5(), -40.0f, CardWidth, CardHeight);
    self.transform = CGAffineTransformMakeRotation(M_PI);
    
    CGPoint point = [self riverCardsPositiononBoard];
    _angle =0;
    [UIView animateWithDuration:0.2f
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         self.center = point;
         self.transform = CGAffineTransformMakeRotation(_angle);
     }
                     completion:nil];
}
-(void)animateRiverCardsTurnOverWithsuccess:(CompletionBlock)callback
{
    [self loadFront];
    [self.superview bringSubviewToFront:self];
    
    UIImageView *darkenView = [[UIImageView alloc] initWithFrame:self.bounds];
    darkenView.backgroundColor = [UIColor clearColor];
    darkenView.image = [UIImage imageNamed:@"Darken"];
    darkenView.alpha = 0.0f;
    [self addSubview:darkenView];
    
    CGPoint startPoint = self.center;
    CGPoint endPoint = [self riverCardsPositiononBoard];
    CGFloat afterAngle =0;   //= [self angleForPlayer:player];
    
    CGPoint halfwayPoint = CGPointMake((startPoint.x + endPoint.x)/2.0f, (startPoint.y + endPoint.y)/2.0f);
    CGFloat halfwayAngle = (_angle + afterAngle)/2.0f;
    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         CGRect rect = _backImageView.bounds;
         rect.size.width = 1.0f;
         _backImageView.bounds = rect;
         
         darkenView.bounds = rect;
         darkenView.alpha = 0.5f;
         
         self.center = halfwayPoint;
         self.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(halfwayAngle), 1.2f, 1.2f);
     }
                     completion:^(BOOL finished)
     {
         _frontImageView.bounds = _backImageView.bounds;
         _frontImageView.hidden = NO;
         
         [UIView animateWithDuration:0.15f
                               delay:0
                             options:UIViewAnimationOptionCurveEaseOut
                          animations:^
          {
              CGRect rect = _frontImageView.bounds;
              rect.size.width = CardWidth;
              _frontImageView.bounds = rect;
              
              darkenView.bounds = rect;
              darkenView.alpha = 0.0f;
              
              self.center = endPoint;
              self.transform = CGAffineTransformMakeRotation(afterAngle);
          }
                          completion:^(BOOL finished)
          {
              [darkenView removeFromSuperview];
              [self unloadBack];
          }];
     }];
    successCallback= callback;
    successCallback();
}
-(CGPoint)riverCardsPositiononBoard
{
    CGFloat x  =10;
    CGFloat y  =10;
    if (self.card.isTurnedOver)
    {
        x += 116;
        y += 10 ;
    }
    else
    {
        x += 116;
        y += 10 ;
    }
    return CGPointMake(x, y);
}



- (void)animateRecycleForAllPlayers;
{
        self.alpha=0.5;
}

- (void)unloadFront
{
    [_frontImageView removeFromSuperview];
    _frontImageView = nil;
}

- (void)animateCloseAndMoveFromPlayer:(Player *)fromPlayer value:(int)value
{

    
    if(fromPlayer == PlayerPositionLTop)
    {
        if(value==self.card.value)
    {
        self.alpha=0.5;
    }
    }
}

@end

