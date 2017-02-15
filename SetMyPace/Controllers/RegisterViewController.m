//
//  RegisterViewController.m
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

#import "RegisterViewController.h"

#import "MySingleton.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "LoginViewController.h"
#import "WorkoutListViewController.h"

@interface RegisterViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation RegisterViewController

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@synthesize activeTextField;
@synthesize keyboardShown;
@synthesize viewMoved;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize imageViewMainLogo;

@synthesize lblLoginWithYour;
@synthesize lblLoginWithYourBottomSeparatorView;

@synthesize imageViewEmail;
@synthesize txtEmail;
@synthesize txtEmailBottomSeparatorView;

@synthesize imageViewPassword;
@synthesize txtPassword;
@synthesize txtPasswordBottomSeparatorView;

@synthesize imageViewFullName;
@synthesize txtFullName;
@synthesize txtFullNameBottomSeparatorView;

@synthesize imageViewPhoneNumber;
@synthesize txtPhoneNumber;
@synthesize txtPhoneNumberBottomSeparatorView;

@synthesize imageViewTermsAndConditionsCheckbox;
@synthesize lblByCreatingAnAccount;

@synthesize btnSignUp;

@synthesize btnSignUpWithFacebookContainerView;
@synthesize imageViewSignUpWithFacebook;
@synthesize lblSignUpWithFacebook;
@synthesize btnSignUpWithFacebook;

@synthesize btnAlreadyAMember;

//========== OTHER VARIABLES ==========//

@synthesize keyboardDoneButtonView;

#pragma mark - View Controller Delegate Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupInitialView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNotificationEvent];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Facebook User is logged in");
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeNotificationEventObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Notification Methods

-(void)setupNotificationEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoggedinEvent) name:@"userLoggedinEvent" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userSignedUpEvent) name:@"userSignedUpEvent" object:nil];
}

-(void)userLoggedinEvent
{
    [self navigateToWorkoutListScreen];
}

-(void)userSignedUpEvent
{
    [self navigateToWorkoutListScreen];
}

-(void)removeNotificationEventObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UI Setup Method

- (void)setupInitialView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    keyboardDoneButtonView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *flex1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem* doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [doneButton1 setTitleTextAttributes:@{ NSFontAttributeName: [MySingleton sharedManager].themeFontTwentySizeRegular,NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flex1,doneButton1, nil]];
    
    mainScrollView.delegate = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIFont *lblLoginWithYourFont, *txtFieldFont, *btnForgetPasswordFont, *lblByLoggingInFont, *btnFont, *btnAlreadyAMemberFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnAlreadyAMemberFont = [MySingleton sharedManager].themeFontTwelveSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnAlreadyAMemberFont = [MySingleton sharedManager].themeFontTwelveSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSeventeenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
        btnAlreadyAMemberFont = [MySingleton sharedManager].themeFontThirteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 736)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontEighteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        btnAlreadyAMemberFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    
    lblLoginWithYour.font = lblLoginWithYourFont;
    lblLoginWithYour.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    
    lblLoginWithYourBottomSeparatorView.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    
    txtEmail.font = txtFieldFont;
    txtEmail.delegate = self;
    [txtEmail setValue:[MySingleton sharedManager].textfieldPlaceholderColor
            forKeyPath:@"_placeholderLabel.textColor"];
    txtEmail.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtEmail.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtEmail setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    
    txtEmailBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    txtPassword.font = txtFieldFont;
    txtPassword.delegate = self;
    [txtPassword setValue:[MySingleton sharedManager].textfieldPlaceholderColor
               forKeyPath:@"_placeholderLabel.textColor"];
    txtPassword.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtPassword.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtPassword setAutocorrectionType:UITextAutocorrectionTypeNo];
    txtPassword.secureTextEntry = true;
    
    txtPasswordBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    txtFullName.font = txtFieldFont;
    txtFullName.delegate = self;
    [txtFullName setValue:[MySingleton sharedManager].textfieldPlaceholderColor
               forKeyPath:@"_placeholderLabel.textColor"];
    txtFullName.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtFullName.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtFullName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    txtFullNameBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    txtPhoneNumber.font = txtFieldFont;
    txtPhoneNumber.delegate = self;
    [txtPhoneNumber setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                  forKeyPath:@"_placeholderLabel.textColor"];
    txtPhoneNumber.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtPhoneNumber.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtPhoneNumber setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtPhoneNumber setKeyboardType:UIKeyboardTypePhonePad];
    [txtPhoneNumber setInputAccessoryView:keyboardDoneButtonView];
    
    txtPhoneNumberBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblByCreatingAnAccount.font = lblByLoggingInFont;
    lblByCreatingAnAccount.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    
    btnSignUp.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnSignUp.layer.masksToBounds = true;
    btnSignUp.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnSignUp.titleLabel.font = btnFont;
    [btnSignUp setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnSignUp addTarget:self action:@selector(btnSignUpClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnSignUpWithFacebookContainerView.backgroundColor = [MySingleton sharedManager].themeGlobalDarkBlueColor;
    btnSignUpWithFacebookContainerView.layer.masksToBounds = true;
    btnSignUpWithFacebookContainerView.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    
    lblSignUpWithFacebook.font = btnFont;
    lblSignUpWithFacebook.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    [btnSignUpWithFacebook addTarget:self action:@selector(btnSignUpWithFacebookClicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *strBtnAlreadyAMemberTitle = [NSString stringWithFormat:@"Already a member? Login."];
    NSMutableAttributedString *strAttrBtnAlreadyAMemberTitle = [[NSMutableAttributedString alloc] initWithString:strBtnAlreadyAMemberTitle attributes: nil];
    NSRange rangeOfLogin = [strBtnAlreadyAMemberTitle rangeOfString:@"Login."];
    [strAttrBtnAlreadyAMemberTitle addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:rangeOfLogin];
    [strAttrBtnAlreadyAMemberTitle addAttribute:NSForegroundColorAttributeName value:[MySingleton sharedManager].themeGlobalDarkGreyColor range:NSMakeRange(0, strBtnAlreadyAMemberTitle.length)];
    [btnAlreadyAMember setAttributedTitle:strAttrBtnAlreadyAMemberTitle forState:UIControlStateNormal];
    btnAlreadyAMember.titleLabel.font = btnAlreadyAMemberFont;
    [btnAlreadyAMember addTarget:self action:@selector(btnAlreadyAMemberClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == txtEmail)
    {
        imageViewEmail.image = [UIImage imageNamed:@"textfield_email_selected"];
        txtEmailBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldActiveStateBottomSeparatorColor;
    }
    else if(textField == txtPassword)
    {
        imageViewPassword.image = [UIImage imageNamed:@"textfield_password_selected"];
        txtPasswordBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldActiveStateBottomSeparatorColor;
    }
    else if(textField == txtFullName)
    {
        imageViewFullName.image = [UIImage imageNamed:@"textfield_fullname_selected"];
        txtFullNameBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldActiveStateBottomSeparatorColor;
    }
    else if(textField == txtPhoneNumber)
    {
        imageViewPhoneNumber.image = [UIImage imageNamed:@"textfield_phonenumber_selected"];
        txtPhoneNumberBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldActiveStateBottomSeparatorColor;
    }
    
    self.activeTextField = textField;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 568)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 667)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(375, 190);
    }
    else if ([MySingleton sharedManager].screenHeight == 736)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(414, 195);
    }
    
    CGRect textFieldRect  = [self.view.window convertRect:self.activeTextField.bounds fromView:self.activeTextField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = 	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)	* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor([MySingleton sharedManager].keyboardSize.height * heightFraction+40);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    viewMoved = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == txtEmail)
    {
        imageViewEmail.image = [UIImage imageNamed:@"textfield_email_normal"];
        txtEmailBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    }
    else if(textField == txtPassword)
    {
        imageViewPassword.image = [UIImage imageNamed:@"textfield_password_normal"];
        txtPasswordBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    }
    else if(textField == txtFullName)
    {
        imageViewFullName.image = [UIImage imageNamed:@"textfield_fullname_normal"];
        txtFullNameBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    }
    else if(textField == txtPhoneNumber)
    {
        imageViewPhoneNumber.image = [UIImage imageNamed:@"textfield_phonenumber_normal"];
        txtPhoneNumberBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    }
    
    self.activeTextField = nil;
    
    if ( viewMoved ) {
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
        viewMoved = NO;
    }
}

#pragma mark - Other Method

-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (void)btnForgetPasswordClicked
{
    [self.view endEditing:YES];
    
    //    ForgetPasswordViewController *viewController = [[ForgetPasswordViewController alloc] init];
    //    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)bindDataToObject
{
    if([MySingleton sharedManager].dataManager.objLoggedInUser == nil)
    {
        [MySingleton sharedManager].dataManager.objLoggedInUser = [[User alloc]init];
    }
    
    [MySingleton sharedManager].dataManager.objLoggedInUser.strUserType = @"0";
    [MySingleton sharedManager].dataManager.objLoggedInUser.strEmail = txtEmail.text;
    [MySingleton sharedManager].dataManager.objLoggedInUser.strPassword = txtPassword.text;
    [MySingleton sharedManager].dataManager.objLoggedInUser.strUserFullname = txtFullName.text;
    [MySingleton sharedManager].dataManager.objLoggedInUser.strPhoneNumber = txtPhoneNumber.text;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [MySingleton sharedManager].dataManager.objLoggedInUser.strDeviceToken = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"deviceToken"]];
    [MySingleton sharedManager].dataManager.objLoggedInUser.strUniqueDeviceId = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"uniqueDeviceId"]];
}

- (void)btnSignUpClicked
{
    [self.view endEditing:YES];
    
    [self bindDataToObject];
    
    if([[MySingleton sharedManager].dataManager.objLoggedInUser isValidateUserForRegistration])
    {
        [[MySingleton sharedManager].dataManager userSignUp:[MySingleton sharedManager].dataManager.objLoggedInUser];
    }
    else
    {
        [appDelegate showErrorAlertViewWithTitle:@"" withDetails:[MySingleton sharedManager].dataManager.objLoggedInUser.strValidationMessage];
    }
}

- (void)btnSignUpWithFacebookClicked
{
    [self.view endEditing:YES];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result,NSError *error) {
        if (error)
        {
            // Process error
            NSLog(@"error %@",error);
        }
        else if (result.isCancelled)
        {
            // Handle cancellations
            NSLog(@"Cancelled");
            
            NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
            alertViewController.title = @"Login Cancelled";
            alertViewController.message = @"We were unable to connect to Facebook as you cancelled the request.";
            
            alertViewController.view.tintColor = [UIColor whiteColor];
            alertViewController.backgroundTapDismissalGestureEnabled = YES;
            alertViewController.swipeDismissalGestureEnabled = YES;
            alertViewController.transitionStyle = NYAlertViewControllerTransitionStyleFade;
            
            alertViewController.titleFont = [MySingleton sharedManager].alertViewTitleFont;
            alertViewController.messageFont = [MySingleton sharedManager].alertViewMessageFont;
            alertViewController.buttonTitleFont = [MySingleton sharedManager].alertViewButtonTitleFont;
            alertViewController.cancelButtonTitleFont = [MySingleton sharedManager].alertViewCancelButtonTitleFont;
            
            [alertViewController addAction:[NYAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(NYAlertAction *action)
                                            {
                                                [alertViewController dismissViewControllerAnimated:YES completion:nil];
                                            }]];
            
            [self presentViewController:alertViewController animated:YES completion:nil];
        }
        else
        {
            if ([result.grantedPermissions containsObject:@"email"])
            {
                // Do work
                NSLog(@"Logged in");
                [self gotFacebookData];
            }
        }
    }];
}

- (void)gotFacebookData
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
         {
             if (!error)
             {
                 NSLog(@"fetched user:%@", result);
                 
                 if (([[result allKeys] containsObject:@"id"]) && ([[result allKeys] containsObject:@"email"]))
                 {
                     [MySingleton sharedManager].dataManager.objLoggedInUser = [[User alloc] init];
                     
                     [MySingleton sharedManager].dataManager.objLoggedInUser.strUserType = @"1";
                     [MySingleton sharedManager].dataManager.objLoggedInUser.strFacebookId = [result objectForKey:@"id"];
                     [MySingleton sharedManager].dataManager.objLoggedInUser.strFacebookAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
                     [MySingleton sharedManager].dataManager.objLoggedInUser.strUserFullname = [NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]];
                     [MySingleton sharedManager].dataManager.objLoggedInUser.strEmail = [result objectForKey:@"email"];
                     //                     [MySingleton sharedManager].dataManager.objLoggedInUser.strUserProfilePictureUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"]];
                     
                     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                     [prefs setObject:[MySingleton sharedManager].dataManager.objLoggedInUser.strEmail forKey:@"userEmail"];
                     [prefs synchronize];
                     
                     if([[MySingleton sharedManager].dataManager.objLoggedInUser isValidateSocialMediaUserForRegistration])
                     {
                         //                         [[MySingleton sharedManager].dataManager userSignUp:[MySingleton sharedManager].dataManager.objLoggedInUser];
                     }
                     else
                     {
                         [appDelegate showErrorAlertViewWithTitle:@"" withDetails:[MySingleton sharedManager].dataManager.objLoggedInUser.strValidationMessage];
                     }
                 }
                 else
                 {
                     NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
                     alertViewController.title = @"Facebook Error";
                     alertViewController.message = @"Please make profile information public to login with facebook.";
                     
                     alertViewController.view.tintColor = [UIColor whiteColor];
                     alertViewController.backgroundTapDismissalGestureEnabled = YES;
                     alertViewController.swipeDismissalGestureEnabled = YES;
                     alertViewController.transitionStyle = NYAlertViewControllerTransitionStyleFade;
                     
                     alertViewController.titleFont = [MySingleton sharedManager].alertViewTitleFont;
                     alertViewController.messageFont = [MySingleton sharedManager].alertViewMessageFont;
                     alertViewController.buttonTitleFont = [MySingleton sharedManager].alertViewButtonTitleFont;
                     alertViewController.cancelButtonTitleFont = [MySingleton sharedManager].alertViewCancelButtonTitleFont;
                     
                     [alertViewController addAction:[NYAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(NYAlertAction *action)
                                                     {
                                                         [alertViewController dismissViewControllerAnimated:YES completion:nil];
                                                     }]];
                     
                     [self presentViewController:alertViewController animated:YES completion:nil];
                 }
             }
         }];
    }
}

- (void)btnAlreadyAMemberClicked
{
    [self.view endEditing:YES];
    
    LoginViewController *viewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)navigateToWorkoutListScreen
{
    WorkoutListViewController *viewController = [[WorkoutListViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
