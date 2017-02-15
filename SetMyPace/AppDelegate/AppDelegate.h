//
//  AppDelegate.h
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

#import <UIKit/UIKit.h>
#import "SplashViewController.h"
#import "MBProgressHUD.h"
#import "NYAlertViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SplashViewController *splashVC;
@property (strong, nonatomic) UINavigationController *navC;

-(void)showErrorAlertViewWithTitle:(NSString *)title withDetails:(NSString *)detail;

-(MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
-(void)dismissGlobalHUD;

-(BOOL)isClock24Hour;


@end

