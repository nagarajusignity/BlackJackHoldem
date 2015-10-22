//
//  GameButtonDetails.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 4/27/15.
//  Copyright (c) 2015 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameButtonDetails : NSObject
{
    UIView                      * view_Background;
    UIView                      *customiseAlertView;
    UIView                      *bgView;
    int                         alert_width;
    int                         alert_height;
}
+ (id)sharedManager;
-(void)ShowViewWithGameDetails:(UIView*)view;
@end
