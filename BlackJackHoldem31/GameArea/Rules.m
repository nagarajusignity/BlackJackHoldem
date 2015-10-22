//
//  Rules.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/8/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "Rules.h"
#import "AppDelegate.h"

@implementation Rules
static  Rules * sharedMyManager = nil;
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
-(void)ShowViewWithRules:(UIView*)view

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
    alert_width = 442+70*isiPhone5();
    alert_height = 304;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
    if(isiPhone5())
    customiseAlertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rules_bg"]];
    else
    customiseAlertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rules_bg4"]];
    
    customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.cornerRadius = 5;
    customiseAlertView.layer.masksToBounds = NO;
    //[customiseAlertView addSubview:mainbgView];
    
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 50,412+60*isiPhone5() , 230)];
    [scrollView setContentSize:CGSizeMake(412+60*isiPhone5() , 2000-200*isiPhone5())];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [scrollView flashScrollIndicators];
    [customiseAlertView addSubview:scrollView];
    
    UIImage *dot =[UIImage imageNamed:@"dot_icon"];

    
    UIImageView *dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 10,dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    /***
     * First Heading Label
     **/
    
    UILabel* fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,5,300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];//TimesNewRomanPSMT
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"CONTROL OF THE GAME";
    [scrollView addSubview:fisrtLbl];
    
    
    UITextView *firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,30,350+52*isiPhone5(),280-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"1.1 A dealer shall be responsible for the conduct of the game.He shall control all hands and cards,determine winners, and oversee the collection of winnings and the commission. With the exception of tournament 31, the dealer shall not be permitted to participate in the game. In tournament 31, provided the deal is rotated after each round ofplay so that all players take turns in dealing and provided no player is paid to deal the game, the dealer/s may be permitted to participate in the game.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 310-50*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,305-50*isiPhone5(),300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"DECK";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,330-50*isiPhone5(),350+52*isiPhone5(),280-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"2.1 The game is played with a full deck of 52 cards excluding the joker. All cards in a deck shall have backs which are identical in colour and markings.\n 2.2 Whenever a table is opened a new deck of cards shall be used. Upon request players shall be permitted to visually inspect the cards. A new deck of cards shall also be introduced if a majority of players request a change, or if a card or cards become mutilated. Before a new deck is introduced, the old deck shall be proven to be complete by the dealer. The new deck must be of a different colour to the deck previously used. The dealer shall invalidate the outcome of a game if it is established that the deck in use contains an incorrect number of cards.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 605-100*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,600-100*isiPhone5(),300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"WAGERS";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,625-100*isiPhone5(),350+52*isiPhone5(),85-10*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"3.1 The minimum and maximum wagers shall be prominently displayed on a sign at the table.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 710-110*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,705-110*isiPhone5(),300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"AGE LIMITS";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,730-110*isiPhone5(),350+52*isiPhone5(),100)];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"4.1 Persons under the age of 18 years shall not participate in the game, or be involved in the dealing or conduct of the game.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 830-110*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,825-110*isiPhone5(),300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"ORDER OF HANDS";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,850-110*isiPhone5(),350+52*isiPhone5(),490-20*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"5.1 The point value of the cards contained in the deck shall be as follows :-\n(a) any card from 2 to 10 shall have a point value the same as its face value ;\n(b) any Jack, Queen or King shall have a point value of 10 ; and\n(c) an Ace shall have a value of 11.\n5.2 The total point value of the cards of the players hand shall be the cumulative total of the point value of each card of the same suit.\n5.3 The order of hands in descending order in a game shall be :-\nThree cards, two cards, one card of the same suit,\nAce and two cards value 10   -   total 31\nAce and ten value and nine   -    total 30\nThree cards of value ten        -    total 30\nAce and ten value and eight  -    total 29\nTwo cards value ten and nine -   total 29\n.............................................................................................................................\netc";
    firstText.textColor = [UIColor whiteColor];
   [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 1340-130*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,1335-130*isiPhone5(),300 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"VARIATIONS OF 31";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,1360-130*isiPhone5(),350+52*isiPhone5(),490-70*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"6.1 31 Holdem - An ante, in the form of a small 'blind' and big 'blind' wager, is placed by the two players to the left of the dealer. The dealer deals two cards to each player face down and one at a time, after which a round of betting takes place. The dealer then burns one card and exposes two communal cards, known as the 'flop'. Another round of betting takes place following which the dealer burns another card and exposes another two communal cards known as the 'turn'. Another round of betting takes place before the dealer burns another card and exposes the fifth and final communal card known asthe 'river'. A final round of betting takes place. A player's completed hand shall consist of one or both of the players two hole cards and one or two cards of the 5 communal cards to a maximum of three cards. The combination of cards is required to be cards of the same suit, with the point value of said cards added together to create the highest possible total value.";
    firstText.textColor = [UIColor whiteColor];
   [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15, 1850-200*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(35,1845-200*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"TimesNewRomanPSMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"DETERMINATION OF A WINNING HAND";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(35,1870-200*isiPhone5(),300+52*isiPhone5(),120)];
    firstText.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:18];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"7.1 The winning hand shall be the hand with the highest total value.\n7.2 The pot shall be shared where there is more than one player with the same highest total value. Suits do not count when determining the winning hand.";
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
