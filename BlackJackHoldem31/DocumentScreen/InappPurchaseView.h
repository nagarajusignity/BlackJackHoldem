//
//  InappPurchaseView.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/10/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceInterface.h"

@interface InappPurchaseView : UIViewController<SKStoreProductViewControllerDelegate,SKProductsRequestDelegate,UIAlertViewDelegate>
{
    WebServiceInterface        *objAPI;
    int                        buttonTag;
}
@property (nonatomic, retain) UIAlertView *progressView;
@end
