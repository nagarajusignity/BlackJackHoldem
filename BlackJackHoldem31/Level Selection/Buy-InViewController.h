//
//  Buy-InViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceInterface.h"

@interface Buy_InViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView    *scrollView;
    UIButton        *goButton;
    UILabel         * firstPlayerCountLbl;
    UILabel         * firstblindLbl;
    UILabel         * firstpriceLbl;
    UITableView     *_comboBoxTableView;
    UIImageView     *levelImageViewBG;
    NSMutableArray  *detailsArray;
    NSMutableArray  *eligibleLevels;
    NSMutableArray  *buyInDetails;
    UILabel         * scoreLbl;
    
}
@property (nonatomic, retain) UIAlertView *progressView;
@property (nonatomic, strong) UILabel         * levelLbl;
@property (nonatomic, assign) BOOL             isFromPlayNow;
@property (nonatomic, assign) BOOL             isFromDocument;
@property (nonatomic, strong) NSString         *slectedLevel;
@end
