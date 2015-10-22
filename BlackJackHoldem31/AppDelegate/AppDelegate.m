//
//  AppDelegate.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SelectViewController.h"
#import "StoreController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
 SKProductsRequest *productsRequest;
@synthesize navigationController;
@synthesize orientation;
@synthesize clients;
@synthesize temp;
@synthesize fileName;
@synthesize tableNumber;
@synthesize StaringPlayer;
@synthesize cummulativeCards;
@synthesize IAPFailedNotification =                 _IAPFailedNotification;
@synthesize IAPSuccessNotification =                _IAPSuccessNotification;
@synthesize IAPDownloadCompleteNotification =       _IAPDownloadCompleteNotification;
@synthesize LevelName;
@synthesize smallBlindValue,bigBlindValue;
@synthesize dealerId;
@synthesize gameStarted;
@synthesize buyInValue;
@synthesize firstBetValue,secondBetValue,thirdBetValue,fourthBetValue;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _IAPFailedNotification              = @"IAPFailedNotification";
    _IAPSuccessNotification             = @"IAPSuccessfulNotification";
    _IAPDownloadCompleteNotification    = @"IAPDownloadCompleteNotification";
    
    [self requestProductData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    clients =[[NSMutableArray alloc]init];
    temp=[[NSMutableDictionary alloc]init];
    cummulativeCards =[[NSMutableArray alloc]init];

    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"KeepLogin"]){
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"UserID"]){
     SelectViewController *wlcomeView =[[SelectViewController alloc]init];
     navigationController = [[UINavigationController alloc] initWithRootViewController:wlcomeView];
    }
    else{
     LoginViewController *loginView =[[LoginViewController alloc]init];
     navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
    }
    }
    else{
    LoginViewController *loginView =[[LoginViewController alloc]init];
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
    }
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    // pubNub Setup
     PNConfiguration *myConfig =[PNConfiguration configurationForOrigin:@"pubsub.pubnub.com" publishKey:@"demo" subscribeKey:@"demo" secretKey:@"mySecret"];
     myConfig.presenceHeartbeatTimeout=10;
    [PubNub setConfiguration:myConfig];
    [PubNub connect];

    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Music"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BHands"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Spotlight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}
- (void)addPubNubClientObservers{
    [[PNObservationCenter defaultCenter] addClientConnectionStateObserver:self withCallbackBlock:^(NSString *origin, BOOL connected,  PNError *error) {
        if (!connected && error) {
            NSLog(@"CONNECTION LOST");
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"You Lost Your Internet Connection PubNub" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
     [FBSession.activeSession close];
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if(orientation==YES)
    return UIInterfaceOrientationMaskPortrait;
    else
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - Products Request

- (void)requestProductData
{
    if(![SKPaymentQueue canMakePayments])
    {
        Log(@"In-app purchase is disabled for this app.");
        return;
    }
    NSArray *identifiers    = [NSArray arrayWithObjects:IAP_PRODUCT_ID_TYPEONE,IAP_PRODUCT_ID_TYPETWO,IAP_PRODUCT_ID_TYPETHREE,IAP_PRODUCT_ID_TYPEFOUR,nil];
    NSSet *productIdSet     = [[NSSet alloc] initWithArray:identifiers];
    
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers: productIdSet];
    productsRequest.delegate = self;
    
    Log(@"Check list of purchasable add-ons for this app.");
    
    // This will trigger the SKProductsRequestDelegate callbacks
    [productsRequest start];
}

#pragma mark - SKProductsRequestDelegate

// Sent immediately before -requestDidFinish:
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Valid products returned = %@", response.products);
    NSLog(@"Invalid products returned = %@", response.invalidProductIdentifiers);
    
}


- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"requestDidFinish");
    
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error=%@", error);
}


@end
AppDelegate *appDelegate(void)
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
NSInteger isiPhone5(void)
{
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    if (iOSDeviceScreenSize.width>=568)
        return 1;
    else
        return 0;
}

NSInteger isios7(void)
{
    float version=[[UIDevice currentDevice].systemVersion floatValue];
    if (version>=7.0)
        
        return 1;
    else
        return 0;
}
NSInteger isios6(void)
{
    float version=[[UIDevice currentDevice].systemVersion floatValue];
    if (version<8.0)
        
        return 1;
    else
        return 0;
}



