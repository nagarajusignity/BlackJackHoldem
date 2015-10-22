//
//  RegistrationViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "WebServiceInterface.h"


@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UIScrollView   *scrollView;
    UITextField    *userName;
    UITextField    *password;
    UITextField    *countryName;
    UITextField    *email;
    UITextField    *NickName;
    UIButton       *profileImageButton;
     UIButton      *avatarImageButton;
    UIImageView    *upload_ImageView;
    NSString       *fileName;
    UIImageView    *chooseImageViewBG;
    WebServiceInterface  *objAPI;
    NSString       *avtarName;;
    NSMutableArray *detailsArray;
}
@property (nonatomic, retain) UIAlertView *progressView;
@property (nonatomic, assign) BOOL isFromEdit;
@end
