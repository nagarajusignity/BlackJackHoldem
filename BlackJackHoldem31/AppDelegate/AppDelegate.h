//
//  AppDelegate.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL  orientation;
@property (strong, nonatomic) UINavigationController   *navigationController;

@end
AppDelegate *appDelegate(void);
NSInteger isiPhone5(void);
NSInteger isios7(void);
