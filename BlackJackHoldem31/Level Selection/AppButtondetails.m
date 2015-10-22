//
//  AppButtondetails.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 12/4/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "AppButtondetails.h"
#import "AppDelegate.h"

@implementation AppButtondetails
static  AppButtondetails * sharedMyManager = nil;
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
       customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.cornerRadius = 5;
    customiseAlertView.layer.masksToBounds = NO;
    customiseAlertView.backgroundColor =[UIColor clearColor];
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 65,412+60*isiPhone5() , 230)];
    [scrollView setContentSize:CGSizeMake(412+60*isiPhone5() , 2850-450*isiPhone5())];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [scrollView flashScrollIndicators];
    [customiseAlertView addSubview:scrollView];
    
    UIImage *dot =[UIImage imageNamed:@"dot_icon"];
    
    
    UIImageView *dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(15+40*isiPhone5(), 30,390,38);
    dotBG.image=[UIImage imageNamed:@"Welcome-to-the"];
    [customiseAlertView addSubview:dotBG];
    
    UITextView *firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,15,350+80*isiPhone5(),600-50*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];//
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"After the destruction of Old Earth by the 'Great Asteroid Strike' of 2032, which caused the devastation of all farming crops and earth flora,and the unknown radiated particles released from the asteroid into the atmosphere caused a worldwide shutdown effect on all electronic devices similar to an EMP blast, the Earth was on the brink of extinction.\nTexLon Enterprises having the only fully functional Lunabase which was unaffected from the fallout from the asteroid strike, then joined with the remaining surviving Earth Governments to form 'TexLon Corporation'\nIn the 100 years since, TexLon Corporation has successfully re-established mankind's dominance throughout the Solar System with achievements like the floating cities above Old Earth, the expansion of the Lunabase, the colonization of Mars, the mining operations in the asteroid belt and the terra-forming on the moons of Titan and Ioa.\nThe FSC was formed to offer all drones, workers and citizens of TexLon relaxation and recreational centers throughout the solar system. The casinos offer all subjects the chance of life long glory and retirement by Championing the Gladiatorial Games, or just get lucky on the tables and buy your way to Titan.\nYour journey starts at the casinos of the Floating Cities above Old Earth.\nNote...to continue your travels you will require identification documents and 10,000 Lunabase credit";
    firstText.textColor = [UIColor whiteColor];
    [scrollView addSubview:firstText];
    
    
    dotBG=[[UIImageView alloc]initWithImage:dot];
    dotBG.frame=CGRectMake(35+40*isiPhone5(),615-40*isiPhone5(),330 , 15);
    dotBG.image=[UIImage imageNamed:@"your_travel"];
    [scrollView addSubview:dotBG];
    
    firstText = [[UITextView alloc]initWithFrame:CGRectMake(25,645-40*isiPhone5(),350+80*isiPhone5(),2200-400*isiPhone5())];
    firstText.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    firstText.backgroundColor = [UIColor clearColor];
    firstText.scrollEnabled = NO;
    firstText.editable = NO;
    firstText.text=@"Congratulations.You have relocated from old earth to the Gleaming Sky Cities circling above.You have either shown above average intelligence,been lucky in finding an old earth artefact with some historical value or have signed on to work for TexLon as a drone.\nWhile being a subject of TexLon you will have free access to the Federation of Solar Casinos ( FSC ) on all planets and moons. We look forward to providing for all your dreams and desires at all our Pleasure Domes, including your physical needs, and mental and visual stimulations.\nYour joining TexLon has earned you an advance at FSC of 100,000ec credits. We wish you the best of luck in our Cloud Casino or on your future travels to the planets and moons within the solar system, transfer of your funds will be awaiting you as you move to other casinos.\nGOOD LUCK \n\nMOON\n\nYour next destination is the Lunabase, on the far side of the moon and the gateway to the other colonies.At the Crater Casino we look forward to offering you all the opportunities to play big, win big and ensure your passage on an outgoing space liner will see you enjoying first-class accommodation, luxury amenities and be wined and dined by the captain and crew during your voyage. All players will be offered a free cryo-freeze transport to a colony of your choosing when playing at our casino.\n\nMARS\n\n Here at Red Dawn Casino we offer all subjects of TexLon and the citizens of Mars the friendliest staff,large game bonus's and exciting entertainment at the largest colosseum and biggest Gladiatorial games anywhere. Our complex has all the latest in sporting facilities, live shows nightly and the weekly games are the biggest and extravagance ever.Also for subjects down on their luck FSC can offer you extra work at our privately owned mining and industrial sites for very big credit returns. Signed wavers indemnifying FSC from personal injury or death required before commencing.\n\nCERES\n\nFor the fly-in, fly-out workers mining the asteroid belt, the FSC pleasure dome on Ceres has all varieties of activities to treat your tired aching body to the most intensive and pleasurable recovery procedures known.Our staff are the prettiest and extremely hands on,and will make your stay unbelievable. And at the end of the day join us at the Black as Night Casino were we offer you free drinks, all night parties or your own private sexy shows with one of our exotic lovely hostess's.\n\nIOA\n\n The latest in TexLon's terra-forming projects, we at FSC understand the difficult and dangerous day to day operation this is for all workers on the moon of Ioa.Therefore our orbiting Best Hope Casino gives you the chance to beat the odds and take lady luck by the hand and win your way to freedom from the deadly, dirty and dangerous work on Ioa.With the high, high rates payed to you and the high roller games in the casino giving you the hope to achieve the credits to buy your way to the moon of Titan, and retire to a life only the rich and famous will ever know.\n\nTITAN\n\n The jewel in the crown, the garden of eden, paradise forever, whatever you call it this is the dream and destination of all humans throughout the solar system.With its ever blue crystal oceans, endless white beaches,rolling plains and tall leafy forests, clear nights skies with the stars streaming down on you, this is what old earth was like in its halcyon days.\nWhile all government departments and corporations offices are located in Titans only city, a total ban on all industry will ensure that Titan never has the pollution and industrial waste that plagued Old Earth in its final days.\nAnd FSC's Gold Rings Casino offers all citizens of Titan a relaxing way to pass the time, magnificent theme restaurants, and daily or weekly holidays to the ice moon of Rhea, to experience the winter wonderland with skiing, snowboarding, climbing the icy peaks or just take the motorized tours to see the old and ancient animals from the dawn of time.\nAs a privileged citizen of Titan, Welcome";
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
