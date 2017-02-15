//
//  RegisterViewController.h
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 27/01/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>
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

@property (nonatomic,retain) IBOutlet UIImageView *imageViewFullName;
@property (nonatomic,retain) IBOutlet UITextField *txtFullName;
@property (nonatomic,retain) IBOutlet UIView *txtFullNameBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewPhoneNumber;
@property (nonatomic,retain) IBOutlet UITextField *txtPhoneNumber;
@property (nonatomic,retain) IBOutlet UIView *txtPhoneNumberBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewTermsAndConditionsCheckbox;
@property (nonatomic,retain) IBOutlet UILabel *lblByCreatingAnAccount;

@property (nonatomic,retain) IBOutlet UIButton *btnSignUp;

@property (nonatomic,retain) IBOutlet UIView *btnSignUpWithFacebookContainerView;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewSignUpWithFacebook;
@property (nonatomic,retain) IBOutlet UILabel *lblSignUpWithFacebook;
@property (nonatomic,retain) IBOutlet UIButton *btnSignUpWithFacebook;

@property (nonatomic,retain) IBOutlet UIButton *btnAlreadyAMember;

//========== OTHER VARIABLES ==========//

@property (strong,nonatomic) UIToolbar* keyboardDoneButtonView;

@end
