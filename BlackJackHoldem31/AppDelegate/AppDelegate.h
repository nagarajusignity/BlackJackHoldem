//
//  AppDelegate.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<FacebookSDK/FacebookSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,PNDelegate,SKStoreProductViewControllerDelegate,SKProductsRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL  orientation;
@property (strong, nonatomic) UINavigationController   *navigationController;
@property(nonatomic,strong)NSMutableArray               *clients;
@property(nonatomic,strong)NSMutableArray               *cummulativeCards;
@property(nonatomic,strong)NSMutableDictionary          *temp;
@property (strong, nonatomic) NSString                  *fileName;
@property (strong, nonatomic) NSString                  *tableNumber;
@property (strong, nonatomic) NSString                  *LevelName;
@property (strong, nonatomic) NSString                  *dealerId;
@property (strong, nonatomic) NSString                  *gameStarted;
@property (assign, nonatomic) int                       StaringPlayer;
@property (assign, nonatomic) NSString                  *smallBlindValue;
@property (assign, nonatomic) NSString                  *bigBlindValue;
@property (assign, nonatomic) NSString                  *buyInValue;
@property (strong, nonatomic) NSString                  *firstBetValue;
@property (strong, nonatomic) NSString                  *secondBetValue;
@property (strong, nonatomic) NSString                  *thirdBetValue;
@property (strong, nonatomic) NSString                  *fourthBetValue;
@property (retain,nonatomic)NSString * IAPFailedNotification;
@property (retain,nonatomic)NSString * IAPSuccessNotification;
@property (retain,nonatomic)NSString * IAPDownloadCompleteNotification;
@end
AppDelegate *appDelegate(void);
NSInteger isiPhone5(void);
NSInteger isios7(void);
NSInteger isios6(void);

