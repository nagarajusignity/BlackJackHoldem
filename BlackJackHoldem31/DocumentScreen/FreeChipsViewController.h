//
//  FreeChipsViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/26/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeChipsViewController : UIViewController
{
    UIButton          *checkBox;
    NSTimer           *timer;
}
@property (nonatomic, retain) UIAlertView *progressView;
-(void)updateCounter:(NSTimer *)theTimer;
-(void)countdownTimer;
@end
