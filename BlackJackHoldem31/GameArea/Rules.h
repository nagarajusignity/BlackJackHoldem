//
//  Rules.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/8/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rules : NSObject
{
    UIView                      * view_Background;
    UIView                      *customiseAlertView;
    UIView                      *bgView;
    int                         alert_width;
    int                         alert_height;
}
+ (id)sharedManager;
-(void)ShowViewWithRules:(UIView*)view;
@end