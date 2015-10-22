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
#import "Game.h"
#import "UICountingLabel.h"

@interface GameAreaViewController : UIViewController<CircularProgressViewDelegate,UIAlertViewDelegate,GameDelegate>{
    UICountingLabel        *totalScoreLabel;
    long long  int          potValue;
    NSArray                *cumulativeCards;
    BOOL                   firstTime;
    BOOL                   isfirst;
    BOOL                   Received;
    
    BOOL                   ActiveAtPositionLTop;
    BOOL                   ActiveAtPositionLMiddle;
    BOOL                   ActiveAtPositionLBottom;
    BOOL                   ActiveAtPositionMiddle;
    BOOL                   ActiveAtPositionRBottom; 
    BOOL                   ActiveAtPositionRMiddle;
    BOOL                   ActiveAtPositionRTop;
    
    BOOL                   isFirstBestCard;
    BOOL                   isSecondBestCard;
    BOOL                   isThirdBestCard;
    BOOL                   gameStarted;
    
    UILabel               *DealerLabel;
    UILabel               *smallBlindLabel;
    UILabel               *bigBlindLabel;
    UILabel               *statusLabel;
    
    UIImageView           *firstbedirBG;
    UILabel               *firstPlayerName;
    UILabel               *firstPlayerScore;
    UILabel               *firstScoreLabel;
    UIImage               *firstEmptyChair;
    UIImageView           *firstProfileImageBG;
    UILabel               *firtPlayerstatusLabel;
    UIImage               *bedirimage;
    
    UIImageView           *secondbedirBG;
    UILabel               *secondPlayerName;
    UILabel               *secondPlayerScore;
    UILabel               *secondScoreLabel;
    UIImageView           *secondProfileImageBG;
    UILabel               *secondPlayerstatusLabel;
    UIImage               *secondEmptyChair;

    UIImageView           *thirdbedirBG;
    UIImage               *thirdbedirimage;
    UILabel               *thirdPlayerName;
    UICountingLabel       *thirdScoreLabel;
    UIImageView           *thirdProfileImageBG;
    UILabel               *thirdPlayerstatusLabel;
    UIImage               *thirdEmptyChair;
    
    UIImageView           *fouthbedirBG;
    UILabel               *fourthPlayerName;
    UICountingLabel       *fourthScoreLabel;
    UIImage               *fourthbedirimage;
    UIImageView           *fourthProfileImageBG;
    UILabel               *fourthPlayerstatusLabel;
    UIImage               *fourthEmptyChair;
    
    UIImageView           *fifthbedirBG;
    UILabel               *fifthPlayerName;
    UICountingLabel       *fifthScoreLabel;
    UIImageView           *fifthProfileImageBG;
    UILabel               *fifthPlayerstatusLabel;
    UIImage               *fifthEmptyChair;
    
    UIImageView           *sixthbedirBG;
    UILabel               *sixthPlayerName;
    UILabel               *sixthPlayerScore;
    UICountingLabel       *sixthScoreLabel;
    UIImageView           *sixthProfileImageBG;
    UILabel               *sixthPlayerstatusLabel;
    UIImage               *sixthEmptyChair;
    
    UIImageView           *seventhbedirBG;
    UILabel               *seventhPlayerName;
    UILabel               *seventhPlayerScore;
    UIImageView           *seventhProfileImageBG;
    UILabel               *seventhScoreLabel;
    UILabel               *seventhPlayerstatusLabel;
    UIImage               *seventhEmptyChair;
    
    NSMutableDictionary   *scoreDict;
    NSMutableArray        *scoreArray;
    
    NSMutableArray        *myOpencards;
    
    int                    firsttotal;
    int                    secondtotal;
    NSString               *callAmount;
    
    UIButton               *checkButton;
    UIButton               *callButton;
    UIButton               *foldButton;
    UIButton               *allinButton;
    UIButton               *betButton;
    UIButton               *sitOutButton;
    UIButton               *rulesButton;
    UIButton               *leaveButton;
    
    Rules                  *rulesView;
    UIView                 *sliderView;
    
    
    UILabel                *amountLbl;
    UISlider               *slider;
    
    Game                   *game;
    
    UIView                 *bestHandsView;
    
    UILabel                *bestHandsScoreLbl;
    NSMutableArray         *bestHandsArray;
    NSString               *firstSuitString;
    NSString               *secondSuitString;
    
    NSTimer                *internetTimer;
    UILabel                * firstTotalScore;
    UILabel                * secondTotalScore;
    UILabel                * thirdTotalScore;
    UILabel                * fourthTotalScore;
    UILabel                * fifthTotalScore;
    UILabel                * sixthTotalScore;
    UILabel                * seventhTotalScore;
    
    UIImageView            * shineImage;
}
@property (nonatomic, copy) NSString              *allInAmount;
@property (nonatomic, strong)  UIView             *communityView;
@property (nonatomic, strong)  UIView             *cardContainerView;
@property (nonatomic,strong)UIImageView           *fouthbedirBG;
@property (nonatomic, retain) UIAlertView         *progressView;
//@property  (nonatomic,strong)NSString                *betValue;
@end
