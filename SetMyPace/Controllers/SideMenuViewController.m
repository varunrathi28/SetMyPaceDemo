//
//  SideMenuViewController.m
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 28/01/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import "SideMenuViewController.h"
#import "MySingleton.h"

#import "MyLogsViewController.h"
#import "ImportExportViewController.h"
#import "MyIntervalsViewController.h"

@interface SideMenuViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation SideMenuViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize mainImageViewBackground;

@synthesize imageViewProfilePicture;
@synthesize lblFullName;
@synthesize separatorView1;

@synthesize imageViewMyIntervals;
@synthesize lblMyIntervals;
@synthesize btnMyIntervals;
@synthesize separatorView2;

@synthesize imageViewMyRecordings;
@synthesize lblMyRecordings;
@synthesize btnMyRecordings;
@synthesize separatorView3;

@synthesize imageViewImportExport;
@synthesize lblImportExport;
@synthesize btnImportExport;
@synthesize separatorView4;

@synthesize imageViewMyLogs;
@synthesize lblMyLogs;
@synthesize btnMyLogs;
@synthesize separatorView5;

@synthesize imageViewSettings;
@synthesize lblSettings;
@synthesize btnSettings;
@synthesize separatorView6;

@synthesize imageViewMyAccount;
@synthesize lblMyAccount;
@synthesize btnMyAccount;
@synthesize separatorView7;

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
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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
    
    float floatImageViewProfilePictureCornerRadius;
    UIFont *lblFullNameFont, *lblMenuItemsFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        floatImageViewProfilePictureCornerRadius = 30.0f;
        
        lblFullNameFont = [MySingleton sharedManager].themeFontSixteenSizeMedium;
        lblMenuItemsFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        floatImageViewProfilePictureCornerRadius = 30.0f;
        
        lblFullNameFont = [MySingleton sharedManager].themeFontSixteenSizeMedium;
        lblMenuItemsFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        floatImageViewProfilePictureCornerRadius = 35.0f;
        
        lblFullNameFont = [MySingleton sharedManager].themeFontSeventeenSizeMedium;
        lblMenuItemsFont = [MySingleton sharedManager].themeFontFifteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 736)
    {
        floatImageViewProfilePictureCornerRadius = 39.0f;
        
        lblFullNameFont = [MySingleton sharedManager].themeFontEighteenSizeMedium;
        lblMenuItemsFont = [MySingleton sharedManager].themeFontSixteenSizeRegular;
    }
    
    float floatSeparatorViewAlpha = 0.2f;
    
    NSURL *url = [NSURL URLWithString:@"http://blog.hihostels.com/wp-content/uploads/2013/02/running.jpg"];
    imageViewProfilePicture.imageURL = url;
    imageViewProfilePicture.contentMode = UIViewContentModeScaleAspectFill;
    imageViewProfilePicture.layer.masksToBounds = YES;
    imageViewProfilePicture.layer.cornerRadius = floatImageViewProfilePictureCornerRadius;
    imageViewProfilePicture.layer.borderWidth = 2.0f;
    imageViewProfilePicture.layer.borderColor = [MySingleton sharedManager].themeGlobalLightBlueColor.CGColor;
    
    
    lblFullName.font = lblFullNameFont;
    lblFullName.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView1.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView1.alpha = floatSeparatorViewAlpha;
    
    
    lblMyIntervals.font = lblMenuItemsFont;
    lblMyIntervals.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView2.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView2.alpha = floatSeparatorViewAlpha;
    
    [btnMyIntervals addTarget:self action:@selector(btnMyIntervalsClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblMyRecordings.font = lblMenuItemsFont;
    lblMyRecordings.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView3.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView3.alpha = floatSeparatorViewAlpha;
    
    [btnMyRecordings addTarget:self action:@selector(btnMyRecordingsClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblImportExport.font = lblMenuItemsFont;
    lblImportExport.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView4.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView4.alpha = floatSeparatorViewAlpha;
    
    [btnImportExport addTarget:self action:@selector(btnImportExportClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblMyLogs.font = lblMenuItemsFont;
    lblMyLogs.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView5.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView5.alpha = floatSeparatorViewAlpha;
    
    [btnMyLogs addTarget:self action:@selector(btnMyLogsClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblSettings.font = lblMenuItemsFont;
    lblSettings.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView6.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView6.alpha = floatSeparatorViewAlpha;
    
    [btnSettings addTarget:self action:@selector(btnSettingsClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblMyAccount.font = lblMenuItemsFont;
    lblMyAccount.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    separatorView7.backgroundColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    separatorView7.alpha = floatSeparatorViewAlpha;
    
    [btnMyAccount addTarget:self action:@selector(btnMyAccountClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Other Method

- (void)btnMyIntervalsClicked
{
    MyIntervalsViewController *centerViewController = [[MyIntervalsViewController alloc] init];
    
    self.sidebarController.contentViewController = centerViewController;
    [self.sidebarController dismissSidebarViewController];
}

- (void)btnMyRecordingsClicked
{
    
}

- (void)btnImportExportClicked
{
    ImportExportViewController *centerViewController = [[ImportExportViewController alloc] init];
    
    self.sidebarController.contentViewController = centerViewController;
    [self.sidebarController dismissSidebarViewController];
}

- (void)btnMyLogsClicked
{
    MyLogsViewController *centerViewController = [[MyLogsViewController alloc] init];
    
    self.sidebarController.contentViewController = centerViewController;
    [self.sidebarController dismissSidebarViewController];
}

- (void)btnSettingsClicked
{
}

- (void)btnMyAccountClicked
{
    
}

@end
