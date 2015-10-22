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
    alert_width = 442+80*isiPhone5();
    alert_height = 304;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
    if(isiPhone5())
    customiseAlertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rules_bg"]];
    else
    customiseAlertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rules_bg4"]];
    
    customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.cornerRadius = 5;
    customiseAlertView.layer.masksToBounds = NO;
    
    /***
    * Close Button
    **/
    
    UIButton  *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(402+70*isiPhone5(),10, 30, 30);//135
    closeButton.backgroundColor=[UIColor clearColor];
    [customiseAlertView addSubview:closeButton];
    
    /***
     * Scroll
     **/
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50,422+60*isiPhone5() , 230)];
    [scrollView setContentSize:CGSizeMake(412+60*isiPhone5() , 1300-150*isiPhone5())];
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
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"THE AIM";
    [scrollView addSubview:fisrtLbl];
    
    
    UITextView *firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,30,380+52*isiPhone5(),160-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"The aim of each player is to choose three cards of the SAME SUIT, add the face value of the three cards together to reach a total value of 31 or as close to 31 as possible.The player with the highest total value will be deemed the winner.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 190+5*isiPhone5()-50,dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,185+5*isiPhone5()-50,400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"THE DEAL";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,205+10*isiPhone5()-50,380+52*isiPhone5(),130-20*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"The deal starts with two cards (hole) being dealt to each player face down and five cards being dealt face up on the table as community cards. The community cards are dealt in three sections, the first two cards (the flop), the next two cards (the turn) and the final card (the river).";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 330-50,dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,325-50,400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"RULES";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,350-50,400+62*isiPhone5(),330-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    if(isiPhone5())
    firstText.text=@"1. Each player MUST use cards of the SAME SUIT.\n\n2. Each players hand can consist of a MAXIMUM of 3 cards.\n\n3. Each player MUST use one ( or both ) of their hole cards.\n\n4. Each player is dealt 2 hole cards face down.\n\n5. A Community hand of 5 cards are dealt face up on the table.\n\n6. Each player may only use one or two of the community cards.\n\n7. The winner is the player with the highest total value at the end.";
    else
    firstText.text=@"1. Each player MUST use cards of the SAME SUIT.\n\n2. Each players hand can consist of a MAXIMUM of 3 ''''cards.\n\n3. Each player MUST use one ( or both ) of their hole ''''cards.\n\n4. Each player is dealt 2 hole cards face down.\n\n5. A Community hand of 5 cards are dealt face up on ''''the table.\n\n6. Each player may only use one or two of the ''''community cards.\n\n7. The winner is the player with the highest total value ''''at the end.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 630-50*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,625-50*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"THE BET";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,650-50*isiPhone5(),400+52*isiPhone5(),170-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"The betting occurs in four rounds, the first after the hole cards are dealt, the second after the flop,the third after the turn and the final round of betting after the river.\n\nA player will have five action choices when it is their turn to play.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,720+70-70*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:17];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"1. FOLD";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,740+70-70*isiPhone5(),400+52*isiPhone5(),25)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Withdraw from the game and forfeit all credits bet.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,770+70-70*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:17];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"2. CHECK";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,790+70-70*isiPhone5(),400+52*isiPhone5(),25)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Pass until another player makes a bet.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,820+70-70*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:17];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"3. CALL";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,840+70-70*isiPhone5(),400+52*isiPhone5(),25)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Match another players bet with an equal sized bet.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,870+70-70*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:17];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"4. BET";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,890+70-70*isiPhone5(),400+52*isiPhone5(),60-35*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Raise another players bet with an ammount of your choosing.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,920+90-90*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:17];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"5.ALLIN";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,940+90-90*isiPhone5(),400+52*isiPhone5(),25)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Bet all the credits you have.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(5, 980+100-100*isiPhone5(),dot.size.width , dot.size.height);
    [scrollView addSubview:dotBG];
    
    fisrtLbl = [[UILabel alloc] init];
    fisrtLbl.frame = CGRectMake(25,975+100-100*isiPhone5(),400 , 24);
    fisrtLbl.textAlignment = NSTextAlignmentLeft;
    fisrtLbl.textColor = [UIColor  colorWithRed:92.0/255.0f green:237.0/255.0f blue:255.0/255.0f alpha:1.0f];
    fisrtLbl.font =[UIFont fontWithName:@"Arial-BoldMT" size:20];
    fisrtLbl.backgroundColor = [UIColor clearColor];
    fisrtLbl.text=@"YOUR HAND";
    [scrollView addSubview:fisrtLbl];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,1000+100-100*isiPhone5(),400+52*isiPhone5(),130)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"If you use only one card from your hole cards, you can use two cards from the community cards.\n\nIf you use both hole cards, you can only use one card from the community cards.\n\nFor more details see the app/game/tips buttons on the Play Now page.";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,1100+100-100*isiPhone5(),400+52*isiPhone5(),75)];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"For more details see the app/game/tips buttons on the Play Now page.";
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
