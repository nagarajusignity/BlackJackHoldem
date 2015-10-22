//
//  AvatarImages.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 11/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDPageControl.h"

@interface AvatarImages : NSObject<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UIScrollViewDelegate>
{
    UIView                      * view_Background;
    UIView                      *customiseAlertView;
    UIView                      *bgView;
    int                         alert_width;
    int                         alert_height;
    UICollectionView            *_collectionView;
    NSMutableArray              *imagesArray;
    DDPageControl               *pageControl;
}
+ (id)sharedManager;
-(void)ShowViewWithImages:(UIView*)view;
@property(nonatomic,strong)NSString                    *imageName;
@property (nonatomic, retain) UIAlertView *progressView;

@property(nonatomic,strong)void (^callBack)(NSString*);
@end
