//
//  RegistrationViewController.h
//  BlackJackHoldem31
//
//  Created by signity solutions on 10/6/14.
//  Copyright (c) 2014 signity solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView   *scrollView;
    UITextField    *userName;
    UITextField    *password;
    UITextField    *countryName;
    UITextField    *email;
    UITextField    *NickName;
    UIButton *profileImageButton;
}
@end
