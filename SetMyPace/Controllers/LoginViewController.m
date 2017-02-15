//
//  LoginViewController.m
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

#import "LoginViewController.h"
#import "MySingleton.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "RegisterViewController.h"
#import "WorkoutListViewController.h"

@interface LoginViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation LoginViewController

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

@synthesize btnForgetPassword;

@synthesize imageViewTermsAndConditionsCheckbox;
@synthesize lblByLoggingIn;

@synthesize btnLogin;

@synthesize btnSignInWithFacebookContainerView;
@synthesize imageViewSignInWithFacebook;
@synthesize lblSignInWithFacebook;
@synthesize btnSignInWithFacebook;

@synthesize btnJoinNow;

//========== OTHER VARIABLES ==========//

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
    
    mainScrollView.delegate = self;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIFont *lblLoginWithYourFont, *txtFieldFont, *btnForgetPasswordFont, *lblByLoggingInFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontSeventeenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 736)
    {
        lblLoginWithYourFont = [MySingleton sharedManager].themeFontEighteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnForgetPasswordFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblByLoggingInFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
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
    
    btnForgetPassword.titleLabel.font = btnForgetPasswordFont;
    [btnForgetPassword setTitleColor:[MySingleton sharedManager].themeGlobalDarkGreyColor forState:UIControlStateNormal];
    [btnForgetPassword addTarget:self action:@selector(btnForgetPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    
    lblByLoggingIn.font = lblByLoggingInFont;
    lblByLoggingIn.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    
    btnLogin.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnLogin.layer.masksToBounds = true;
    btnLogin.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnLogin.titleLabel.font = btnFont;
    [btnLogin setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnSignInWithFacebookContainerView.backgroundColor = [MySingleton sharedManager].themeGlobalDarkBlueColor;
    btnSignInWithFacebookContainerView.layer.masksToBounds = true;
    btnSignInWithFacebookContainerView.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    
    lblSignInWithFacebook.font = btnFont;
    lblSignInWithFacebook.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    [btnSignInWithFacebook addTarget:self action:@selector(btnSignInWithFacebookClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnJoinNow.backgroundColor = [MySingleton sharedManager].themeGlobalLightestGreyColor;
    btnJoinNow.titleLabel.font = btnFont;
    [btnJoinNow setTitleColor:[MySingleton sharedManager].themeGlobalDarkGreyColor forState:UIControlStateNormal];
    [btnJoinNow addTarget:self action:@selector(btnJoinNowClicked) forControlEvents:UIControlEventTouchUpInside];
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
    
    [MySingleton sharedManager].dataManager.objLoggedInUser.strEmail = txtEmail.text;
    [MySingleton sharedManager].dataManager.objLoggedInUser.strPassword = txtPassword.text;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [MySingleton sharedManager].dataManager.objLoggedInUser.strDeviceToken = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"deviceToken"]];
    [MySingleton sharedManager].dataManager.objLoggedInUser.strUniqueDeviceId = [NSString stringWithFormat:@"%@",[prefs objectForKey:@"uniqueDeviceId"]];
}

- (void)btnLoginClicked
{
    [self.view endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedinEvent" object:nil];
    
//    [self bindDataToObject];
//    
//    if([[MySingleton sharedManager].dataManager.objLoggedInUser isValidateUserForLogin])
//    {
//        [[MySingleton sharedManager].dataManager userLogin:[MySingleton sharedManager].dataManager.objLoggedInUser];
//    }
//    else
//    {
//        [appDelegate showErrorAlertViewWithTitle:@"" withDetails:[MySingleton sharedManager].dataManager.objLoggedInUser.strValidationMessage];
//    }
}

- (void)btnSignInWithFacebookClicked
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

- (void)btnJoinNowClicked
{
    [self.view endEditing:YES];
    
    RegisterViewController *viewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)navigateToWorkoutListScreen
{
    WorkoutListViewController *centerViewController = [[WorkoutListViewController alloc] init];
    
    UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    contentViewController.view.backgroundColor = [UIColor whiteColor];
    contentViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    contentViewController.view.layer.shadowOffset = (CGSize){0.0, 0.0};
    contentViewController.view.layer.shadowOpacity = 0.6;
    contentViewController.view.layer.shadowRadius = 20.0;
    
    SideMenuViewController *leftViewController;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        leftViewController = [[SideMenuViewController alloc] initWithNibName:@"SideMenuViewController_iPhone4" bundle:nil];
    }
    else if ([MySingleton sharedManager].screenHeight == 568)
    {
       leftViewController = [[SideMenuViewController alloc] init];
    }
    else if ([MySingleton sharedManager].screenHeight == 667)
    {
        leftViewController = [[SideMenuViewController alloc] initWithNibName:@"SideMenuViewController_iPhone6" bundle:nil];
    }
    else if ([MySingleton sharedManager].screenHeight == 736)
    {
        leftViewController = [[SideMenuViewController alloc] initWithNibName:@"SideMenuViewController_iPhone6Plus" bundle:nil];
    }
    
    TheSidebarController *sidebarController = [[TheSidebarController alloc] initWithContentViewController:contentViewController leftSidebarViewController:leftViewController rightSidebarViewController:nil];
    sidebarController.delegate = self;
    
    [self.navigationController pushViewController:sidebarController animated:YES];
}

@end
