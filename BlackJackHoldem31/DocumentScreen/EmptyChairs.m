//
//  EmptyChairs.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "EmptyChairs.h"
#import "AppDelegate.h"

@implementation EmptyChairs
static  EmptyChairs * sharedMyManager = nil;
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

-(void)ShowViewWithEmptyChairsImage:(UIView*)view

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
    alert_width = 410;
    alert_height = 230;//270
    
    customiseAlertView.frame = CGRectMake(((bgView.frame.size.width-alert_width)/2.0), ((bgView.frame.size.height-alert_height)/2.0), alert_width, alert_height);
        customiseAlertView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"big_image"]];
    customiseAlertView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customiseAlertView.layer.cornerRadius = 5;
    customiseAlertView.layer.borderWidth=1;
    customiseAlertView.layer.borderColor=[[UIColor whiteColor] CGColor];
    customiseAlertView.layer.masksToBounds = NO;
    
    /***
     * Close Button
     **/
    
    UIButton  *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setImage:[UIImage imageNamed:@"cross_icon"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    closeButton.frame = CGRectMake(375,5, 30, 30);//135
    closeButton.backgroundColor=[UIColor clearColor];
    [customiseAlertView addSubview:closeButton];
    
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
