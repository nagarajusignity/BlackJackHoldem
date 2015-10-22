//
//  DocumentViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/25/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<FacebookSDK/FacebookSDK.h>


@interface DocumentViewController : UIViewController

{
    NSMutableArray  *detailsArray;
    NSMutableArray  *eligibleLevels;
}
@property (nonatomic, retain) UIAlertView *progressView;
@end
