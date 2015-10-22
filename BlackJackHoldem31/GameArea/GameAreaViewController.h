//
//  GameAreaViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
#import "Rules.h"

@interface GameAreaViewController : UIViewController<CircularProgressViewDelegate,UIAlertViewDelegate>
{
     NSArray *cumulativeCards;
     BOOL  firstTime;
     BOOL isfirst;
    
    UIImageView           *firstbedirBG;
    UIImageView           *secondbedirBG;
    UIImageView           *thirdbedirBG;
    UIImageView           *fouthbedirBG;
    UIImageView           *fifthbedirBG;
    UIImageView           *sixthbedirBG;
    UIImageView           *seventhbedirBG;
    NSMutableDictionary   *scoreDict;
    NSMutableArray        *scoreArray;
    
    BOOL             ActiveAtPositionLTop;
    BOOL             ActiveAtPositionLMiddle;
    BOOL             ActiveAtPositionLBottom;
    BOOL             ActiveAtPositionMiddle;
    BOOL             ActiveAtPositionRBottom;  // the user
    BOOL             ActiveAtPositionRMiddle;
    BOOL             ActiveAtPositionRTop;
    
    NSMutableArray      *myOpencards;
    
    
    int   firsttotal;
    int   secondtotal;
    
    UIButton     *checkButton;
    UIButton     *callButton;
    UIButton     *foldButton;
    UIButton     *allinButton;
    UIButton     *betButton;
    UIButton     *sitOutButton;
    
    Rules        *rulesView;
    UIView       *sliderView;
    
    
    UILabel        * amountLbl;
    UISlider       *slider;
    
}
@property (nonatomic, strong)  UIView *communityView;
@property (nonatomic, strong)  UIView *cardContainerView;
@property (nonatomic,strong)UIImageView           *fouthbedirBG;
@end
