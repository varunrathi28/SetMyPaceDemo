//
//  LoginRegisterOptionsViewController.m
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

#import "LoginRegisterOptionsViewController.h"
#import "MySingleton.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "AsyncImageView.h"

@interface LoginRegisterOptionsViewController ()
{
    AppDelegate *appDelegate;
    
    int pageNumber;
    int numberOfPages;
}

@end

@implementation LoginRegisterOptionsViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize imageViewMainLogo;

@synthesize AdvertisementScrollView;

@synthesize imageViewAdvertisement1;
@synthesize lblAdvertisementTitle1;
@synthesize lblAdvertisementDetails1;

@synthesize imageViewAdvertisement2;
@synthesize lblAdvertisementTitle2;
@synthesize lblAdvertisementDetails2;

@synthesize imageViewAdvertisement3;
@synthesize lblAdvertisementTitle3;
@synthesize lblAdvertisementDetails3;

@synthesize mainPageControl;

@synthesize btnLogin;
@synthesize btnJoinNow;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    AdvertisementScrollView.contentSize = CGSizeMake(AdvertisementScrollView.frame.size.width * 3, AdvertisementScrollView.frame.size.height);
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
    
    UIFont *lblInspiringFeatureFont, *lblDetailsFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblInspiringFeatureFont = [MySingleton sharedManager].themeFontEighteenSizeBold;
        lblDetailsFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontEighteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblInspiringFeatureFont = [MySingleton sharedManager].themeFontEighteenSizeBold;
        lblDetailsFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontEighteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblInspiringFeatureFont = [MySingleton sharedManager].themeFontNineteenSizeBold;
        lblDetailsFont = [MySingleton sharedManager].themeFontFifteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontNineteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 736)
    {
        lblInspiringFeatureFont = [MySingleton sharedManager].themeFontTwentySizeBold;
        lblDetailsFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontTwentySizeRegular;
    }
    
    lblAdvertisementTitle1.font = lblInspiringFeatureFont;
    lblAdvertisementTitle1.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    lblAdvertisementDetails1.font = lblDetailsFont;
    lblAdvertisementDetails1.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    lblAdvertisementTitle2.font = lblInspiringFeatureFont;
    lblAdvertisementTitle2.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    lblAdvertisementDetails2.font = lblDetailsFont;
    lblAdvertisementDetails2.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    lblAdvertisementTitle3.font = lblInspiringFeatureFont;
    lblAdvertisementTitle3.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    lblAdvertisementDetails3.font = lblDetailsFont;
    lblAdvertisementDetails3.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    btnLogin.titleLabel.font = btnFont;
    [btnLogin setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(btnLoginClicked) forControlEvents:UIControlEventTouchUpInside];
    
    btnJoinNow.titleLabel.font = btnFont;
    [btnJoinNow setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnJoinNow addTarget:self action:@selector(btnJoinNowClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpSlider];
}

-(void)setUpSlider
{
    numberOfPages = 3;
    pageNumber = 0;
    
    mainPageControl.userInteractionEnabled = FALSE;
    mainPageControl.numberOfPages = numberOfPages;
    mainPageControl.currentPageIndicatorTintColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    [AdvertisementScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
//    AdvertisementScrollView.contentSize = CGSizeMake(AdvertisementScrollView.frame.size.width * 3, AdvertisementScrollView.frame.size.height);
    AdvertisementScrollView.delegate = self;
}

#pragma mark - UIScrollView Delegate Methods

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == AdvertisementScrollView)
    {
        int scrollEndPoint;
        
        if([MySingleton sharedManager].screenHeight == 480 || [MySingleton sharedManager].screenHeight == 568)
        {
            scrollEndPoint = [MySingleton sharedManager].screenWidth * (numberOfPages - 1);
        }
        else if([MySingleton sharedManager].screenHeight == 667)
        {
            scrollEndPoint = [MySingleton sharedManager].screenWidth * (numberOfPages - 1);
        }
        else if([MySingleton sharedManager].screenHeight == 736)
        {
            scrollEndPoint = [MySingleton sharedManager].screenWidth * (numberOfPages - 1);
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == AdvertisementScrollView)
    {
        CGFloat pageWidth = AdvertisementScrollView.frame.size.width;
        
        float fractionalPage = AdvertisementScrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        mainPageControl.currentPage = page;
        pageNumber = page;
        [mainPageControl reloadInputViews];
    }
}

#pragma mark - Other Method

- (void)btnLoginClicked
{
    [self.view endEditing:YES];
    
    LoginViewController *viewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)btnJoinNowClicked
{
    [self.view endEditing:YES];
    
    RegisterViewController *viewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
