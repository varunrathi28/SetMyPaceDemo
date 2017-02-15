//
//  LoginViewController.h
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 25/01/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TheSidebarController.h"
#import "SideMenuViewController.h"

@interface LoginViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, TheSidebarControllerDelegate>
{
    //TO ANIMATE VIEW UP ON KEYBOARD SHOW
    CGFloat animatedDistance;
    UITextField *activeTextField;
    BOOL keyboardShown;
    BOOL viewMoved;
}

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@property (strong, nonatomic) UITextField *activeTextField;
@property (nonatomic,assign) BOOL keyboardShown;
@property (nonatomic,assign) BOOL viewMoved;

//========== IBOUTLETS ==========//

@property (nonatomic,retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,retain) IBOutlet UIView *mainContainerView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewMainLogo;

@property (nonatomic,retain) IBOutlet UILabel *lblLoginWithYour;
@property (nonatomic,retain) IBOutlet UIView *lblLoginWithYourBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewEmail;
@property (nonatomic,retain) IBOutlet UITextField *txtEmail;
@property (nonatomic,retain) IBOutlet UIView *txtEmailBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewPassword;
@property (nonatomic,retain) IBOutlet UITextField *txtPassword;
@property (nonatomic,retain) IBOutlet UIView *txtPasswordBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UIButton *btnForgetPassword;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewTermsAndConditionsCheckbox;
@property (nonatomic,retain) IBOutlet UILabel *lblByLoggingIn;

@property (nonatomic,retain) IBOutlet UIButton *btnLogin;

@property (nonatomic,retain) IBOutlet UIView *btnSignInWithFacebookContainerView;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewSignInWithFacebook;
@property (nonatomic,retain) IBOutlet UILabel *lblSignInWithFacebook;
@property (nonatomic,retain) IBOutlet UIButton *btnSignInWithFacebook;

@property (nonatomic,retain) IBOutlet UIButton *btnJoinNow;

//========== OTHER VARIABLES ==========//

@end
