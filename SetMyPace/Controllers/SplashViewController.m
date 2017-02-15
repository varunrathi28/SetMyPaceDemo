//
//  SplashViewController.m
//  INNOVATIVE ITERATION PROJECT
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 00/00/00.
//  Copyright © 2016 INNOVATIVE ITERATION SOFTWARE SOLUTIONS. All rights reserved.
//

#import "SplashViewController.h"
#import "MySingleton.h"
#import "LoginRegisterOptionsViewController.h"

@interface SplashViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation SplashViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize mainSplashImageViewBackground;
@synthesize mainSplashImageView;

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
    
    [self performSelector:@selector(navigateToLoginRegisterOptionsScreen) withObject:self afterDelay:3.0];
}

#pragma mark - Other Method

- (void)navigateToLoginRegisterOptionsScreen
{
    LoginRegisterOptionsViewController *viewController = [[LoginRegisterOptionsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
