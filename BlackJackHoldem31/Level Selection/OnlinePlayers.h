//
//  OnlinePlayers.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlinePlayers : NSObject<UITableViewDataSource,UITableViewDelegate>
{
    UIView                      * view_Background;
    UIView                      *customiseAlertView;
    UIView                      *bgView;
    int                         alert_width;
    int                         alert_height;
    UITableView                 *levelsTableView;
    NSMutableArray              *levelsArray;
    NSMutableArray              *detailsArray;

}
+ (id)sharedManager;
@property (nonatomic, retain) UIAlertView *progressView;
-(void)ShowViewWithPlayersWhoAreOnline:(UIView*)view;
@end