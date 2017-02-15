 //
//  DataManager.m
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

#import "DataManager.h"
#import "MySingleton.h"

@implementation DataManager

-(id)init
{
    _dictSettings = [NSDictionary dictionaryWithContentsOfFile: [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent: @"Settings.plist"]];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    return self;
}

- (BOOL) isNetworkAvailable
{
    Reachability *reach = [Reachability reachabilityWithHostName:[_dictSettings objectForKey:@"AvailabilityHostToCheck"]];
    NetworkStatus status = [reach currentReachabilityStatus];
    isNetworkAvailable = [NSNumber numberWithBool:!(status == NotReachable)];
    reach = nil;
    return [isNetworkAvailable boolValue];
}

-(void)showInternetNotConnectedError
{
    NYAlertViewController *alertViewController = [[NYAlertViewController alloc] initWithNibName:nil bundle:nil];
    alertViewController.title = @"No Internet Connection";
    alertViewController.message = @"Please make sure that you are connected to the internet.";
    
    alertViewController.view.tintColor = [UIColor whiteColor];
    alertViewController.backgroundTapDismissalGestureEnabled = YES;
    alertViewController.swipeDismissalGestureEnabled = YES;
    alertViewController.transitionStyle = NYAlertViewControllerTransitionStyleFade;
    
    alertViewController.titleFont = [MySingleton sharedManager].alertViewTitleFont;
    alertViewController.messageFont = [MySingleton sharedManager].alertViewMessageFont;
    alertViewController.buttonTitleFont = [MySingleton sharedManager].alertViewButtonTitleFont;
    alertViewController.cancelButtonTitleFont = [MySingleton sharedManager].alertViewCancelButtonTitleFont;
    
    [alertViewController addAction:[NYAlertAction actionWithTitle:@"Go to Settings" style:UIAlertActionStyleDefault handler:^(NYAlertAction *action)
    {
        [alertViewController dismissViewControllerAnimated:YES completion:nil];
        
        if (&UIApplicationOpenSettingsURLString != NULL)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }]];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertViewController animated:YES completion:nil];
}

-(void)showErrorMessage:(NSString *)errorTitle withErrorContent:(NSString *)errorDescription
{
    if([errorTitle isEqualToString:@"Server Error"])
    {
        errorDescription = @"Server is not responding right now. Please try again after some time.";
    }
    else
    {
        errorDescription = errorDescription;
    }
    
    [appDelegate dismissGlobalHUD];
    
    [appDelegate showErrorAlertViewWithTitle:errorTitle withDetails:errorDescription];
}

- (void)connectionError
{
    [appDelegate dismissGlobalHUD];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionErrorEvent" object:nil];
    [self showInternetNotConnectedError];
}

#pragma mark - FUNCTION FOR USER LOGIN

-(void)userLogin:(User *)objUser
{
    if ([self isNetworkAvailable])
    {
        [appDelegate showGlobalProgressHUDWithTitle:@"Loading..."];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",[_dictSettings objectForKey:@"ServerIP"],[_dictSettings objectForKey:@"Login"]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:objUser.strEmail forKey:@"email"];
        [parameters setObject:objUser.strPassword forKey:@"password"];
        [parameters setObject:objUser.strUniqueDeviceId forKey:@"device_id"];
        [parameters setObject:objUser.strDeviceToken forKey:@"push_id"];
        [parameters setObject:@"1" forKey:@"device_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            [appDelegate dismissGlobalHUD];
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                NSArray *responseArray = responseObject;
                
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *jsonResult = responseObject;
                
                if([[jsonResult objectForKey:@"code"] integerValue] == 100)
                {
                    if(self.objLoggedInUser == nil)
                    {
                        self.objLoggedInUser = [[User alloc] init];
                    }
                    
                    self.objLoggedInUser.strUserID = [jsonResult objectForKey:@"user_id"];
                    self.objLoggedInUser.strPhoneNumber = [jsonResult objectForKey:@"phone"];
                    self.objLoggedInUser.strUserFullname = [jsonResult objectForKey:@"fullname"];
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setObject:self.objLoggedInUser.strUserID forKey:@"userId"];
                    [prefs synchronize];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userLoggedinEvent" object:nil];
                }
                else
                {
                    NSString *message = [jsonResult objectForKey:@"message"];
                    [self displayErrorForLogin:message];
                }
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            [appDelegate dismissGlobalHUD];
            [self showErrorMessage:@"Server Error" withErrorContent:@""];
            
        }];
    }
    else
    {
        [self showInternetNotConnectedError];
    }
}

-(void)displayErrorForLogin:(NSString *)strError
{
    if([strError isEqualToString:@"Invalid Username"])
    {
        strError = @"Invalid Username";
    }
    else if ([strError isEqualToString:@"Invalid password"])
    {
        strError = @"Invalid password";
    }
    else if ([strError isEqualToString:@"Login not exist"])
    {
        strError = @"Please enter a valid username or password";
    }
    
    [appDelegate dismissGlobalHUD];
    
    [appDelegate showErrorAlertViewWithTitle:@"Login Failed" withDetails:strError];
}

#pragma mark - FUNCTION FOR USER SIGNUP

-(void)userSignUp:(User *)objUser
{
    if ([self isNetworkAvailable])
    {
        [appDelegate showGlobalProgressHUDWithTitle:@"Loading..."];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",[_dictSettings objectForKey:@"ServerIP"],[_dictSettings objectForKey:@"Signup"]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:objUser.strUserType forKey:@"type"];
        [parameters setObject:objUser.strEmail forKey:@"email"];
        if([objUser.strUserType isEqualToString:@"0"])
        {
            [parameters setObject:objUser.strPassword forKey:@"password"];
        }
        [parameters setObject:objUser.strUserFullname forKey:@"fullname"];
        [parameters setObject:objUser.strPhoneNumber forKey:@"phone_bumber"];
        [parameters setObject:objUser.strUniqueDeviceId forKey:@"device_id"];
        [parameters setObject:objUser.strDeviceToken forKey:@"push_id"];
        [parameters setObject:@"1" forKey:@"device_type"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            [appDelegate dismissGlobalHUD];
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                
                NSArray *responseArray = responseObject;
                
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *jsonResult = responseObject;
                
                if([[jsonResult objectForKey:@"code"] integerValue] == 100)
                {
                    if(self.objLoggedInUser == nil)
                    {
                        self.objLoggedInUser = [[User alloc] init];
                    }
                    
                    self.objLoggedInUser.strUserID = [jsonResult objectForKey:@"user_id"];
                    self.objLoggedInUser.strPhoneNumber = [jsonResult objectForKey:@"phone"];
                    self.objLoggedInUser.strUserFullname = [jsonResult objectForKey:@"fullname"];
                    
                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    [prefs setObject:self.objLoggedInUser.strUserID forKey:@"userId"];
                    [prefs synchronize];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userSignedUpEvent" object:nil];
                }
                else
                {
                    NSString *message = [jsonResult objectForKey:@"message"];
                    [self displayErrorForSignup:message];
                }
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [appDelegate dismissGlobalHUD];
            [self showErrorMessage:@"Server Error" withErrorContent:@""];
            
        }];
    }
    else
    {
        [self showInternetNotConnectedError];
    }
}

-(void)displayErrorForSignup:(NSString *)strError
{
    [appDelegate dismissGlobalHUD];
    
    [appDelegate showErrorAlertViewWithTitle:@"Registration Failed" withDetails:strError];
}

#pragma mark - FUNCTION TO GET MOST ORDERED RESTAURANTS

-(void)getMostOrderedRestaurants
{
    if ([self isNetworkAvailable])
    {
        [appDelegate showGlobalProgressHUDWithTitle:@"Loading..."];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",[_dictSettings objectForKey:@"ServerIP"],[_dictSettings objectForKey:@"GetMostOrderedRestaurants"]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:@"value" forKey:@"key"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            [appDelegate dismissGlobalHUD];
                        
            if ([responseObject isKindOfClass:[NSArray class]]) {
               
                NSArray *responseArray = responseObject;
                
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
               
                NSDictionary *jsonResult = responseObject;
                
                NSArray *arrayMostOrderedRestaurantList = [jsonResult objectForKey:@"most_ordered"];
                [self bindMostOrderedRestautantListToObject:arrayMostOrderedRestaurantList];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"gotMostOrderedRestaurantsEvent" object:nil];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            [appDelegate dismissGlobalHUD];
            [self showErrorMessage:@"Server Error" withErrorContent:@""];
            
        }];
    }
    else
    {
        [self showInternetNotConnectedError];
    }
}

-(void)bindMostOrderedRestautantListToObject:(NSArray *)arrayMostOrderedRestaurantListLocal
{
    self.arrayMostOrderedRestaurantList = [[NSMutableArray alloc]init];
    
    @try
    {
        for(int i = 0; i<arrayMostOrderedRestaurantListLocal.count; i++)
        {
            NSDictionary *curDict = [arrayMostOrderedRestaurantListLocal objectAtIndex:i];
            
            [self.arrayMostOrderedRestaurantList insertObject:curDict atIndex:self.arrayMostOrderedRestaurantList.count];
        }
    }
    @catch (NSException *exception)
    {
        //DO NOTHING
    }
}

@end
