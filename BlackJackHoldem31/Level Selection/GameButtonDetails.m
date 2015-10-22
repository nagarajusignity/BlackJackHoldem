//
//  GameButtonDetails.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 4/27/15.
//  Copyright (c) 2015 signity solutions. All rights reserved.
//

#import "GameButtonDetails.h"
#import "AppDelegate.h"

@implementation GameButtonDetails
static  GameButtonDetails * sharedMyManager = nil;
+ (id)sharedManager
{
    @synchronized(self)
    {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}
-(void)ShowViewWithGameDetails:(UIView*)view

{
    view_Background = [[UIView alloc] init];
    view_Background.frame = view.bounds;
    [view addSubview:view_Background];
    [view bringSubviewToFront:view_Background];
    view_Background.backgroundColor = [UIColor blackColor];
    view_Background.alpha = 0.60;
    
    bgView = [[UIView alloc] init];
    bgView.frame = view.bounds;
    [view addSubview:bgView];
    [view bringSubviewToFront:bgView];
    
    
    customiseAlertView = [[UIView alloc] init];
    alert_width = 442+80*isiPhone5();
    alert_height = 304;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
        customiseAlertView.backgroundColor = [UIColor clearColor];
    customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.cornerRadius = 5;
    customiseAlertView.layer.masksToBounds = NO;
    //[customiseAlertView addSubview:mainbgView];
    
    /***
     * Background Image
     **/
    
    UIImage *backgroundImage =[UIImage imageNamed:@"pop-back.png"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithImage:backgroundImage];
    backgroundImageView.frame=CGRectMake(0,0,alert_width , alert_height);
    [customiseAlertView addSubview:backgroundImageView];
    
    /***
     * Close Button
     **/
    
    UIButton  *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
    //[CancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(402+70*isiPhone5(),10, 30, 30);//135
    closeButton.backgroundColor=[UIColor clearColor];
    [customiseAlertView addSubview:closeButton];
    
    /***
     * Scroll
     **/
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50,422+60*isiPhone5() , 230)];
    [scrollView setContentSize:CGSizeMake(412+60*isiPhone5() , 1670-150*isiPhone5())];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [scrollView flashScrollIndicators];
    [customiseAlertView addSubview:scrollView];
    
    UIImage *dot =[UIImage imageNamed:@"dot_icon"];
    
    
    UIImageView *dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 10,dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    /***
     * First Heading Label
     **/
    
    UILabel* fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,5,300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];//Arial-BoldMT
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"WELCOME";
    [scrollView addSubview:fisrtLbl];
    
    
    UITextView *firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,30,380+52*isiPhone5(),860-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];//
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"In a normal game of Blackjack 21, a player is aiming to score 21 or as close to 21 as they can.\n\nIn Blackjack Holdem the player is aiming to score 31 or as close to 31 as possible.\n\nThe game is a player vs player style as in holdem games and the betting structure is the same with small blind, big blind and three rounds of betting, and the winner taking the pot.\n\nIn Blackjack 21 a player can use cards of different suits and as many cards as they chose. In Blackjack Holdem the player must use cards of the same suit and a maximum of three cards from the seven cards available ( two hole cards and five communal cards ).\n\nAlso each player must use one ( or both ) of their hole cards in the three cards they chose.\n\nIn Blackjack 21 a player can bust ( scoring more than 21 ) and lose their bet.\n\nIn Blackjack Holdem it is impossible to bust ( score more than 31 ) as a player can only use three cards which cannot score above 31. However as in holdem games players can fold and forfeit their bets.\n\nSo to summarize\n\n1. The players hand consists of a maximum of 3 cards.\n2. The cards of the players hand must be of the same suit.\n3. The player must use one ( or both ) ofhis hole cards.\n4. The highest score possible is thirty one( an Ace and two Picture cards of the same suit ).\n5. Each player is dealt 2 hole cards face down.\n6. The flop is 2 cards, 2 cards and 1 card.\n7. Two or more players with the same highest score will be deemed a tie.\n8. The game is player vs player, the winner taking the pot.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 920-120*isiPhone5()-50,dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,915-120*isiPhone5()-50,400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];//Arial-BoldMT
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"HOW TO PLAY";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,975-105*isiPhone5()-50,380+52*isiPhone5(),730-20*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"1.The two players to the left of the dealer place blind bets. The player directly to the dealer’s left places the small blind while the player two seats to the dealer’s left places the big blind.\n\n2. Every player is dealt two cards, face down. These are called hole cards.\n\n3. The action, or the first move, falls on the player to the left of the big blind. This player can either call the big blind bet, raise it, or fold. Betting continues around the table, clockwise.\n\n4. After the betting is completed, two cards are ealt face up in the centre of the table. These first two cards in Blackjack Holdem are called the flop. All cards dealt face up on the table are “community cards”, meaning everyone can use them in combination with one or both of their hole cards to make their best hand.\n\n5. From the flop on, betting begins with the player to the dealer’s left, who can check or bet, with all other players either checking, calling, raising or folding.\n\n6. A third and fourth cards are dealt face up onto the table. This is called the turn.\n\n7. Another round of betting occurs, starting with the player to the dealer's left.\n\n8. The final card is dealt face up onto the table. This card is called the river.\n\n9. A final round of betting occurs starting with the player to the dealer's left.\n\n10. After all betting has been completed, the remaining players show their cards and the person who can make the best two or three card total by combining one or both of their hole cards with one or two of the community cards on the table, wins. Each players hand has to be of cards of the same suit. ";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    [bgView addSubview:customiseAlertView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    animation.fillMode = kCAFillModeRemoved;
    animation.removedOnCompletion = NO;
    animation.duration = 0.5;
    [bgView.layer addAnimation:animation forKey:@"show"];
    
}
-(void)closeButtonPressed
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1);
    CATransform3D scale2 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.0, 0.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.2;
    [bgView.layer addAnimation:animation forKey:@"hide"];
    
    [self performSelector:@selector(removeFromSuperview:) withObject:bgView afterDelay:0.105];
}
-(void)removeFromSuperview:(UIView*)bg_View
{
    [bg_View removeFromSuperview];
    [view_Background removeFromSuperview];
}


@end
