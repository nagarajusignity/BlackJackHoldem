//
//  LoginViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 9/22/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    UIButton     *rememberButton;
}
@property (nonatomic, retain) UIAlertView *progressView;
@end
