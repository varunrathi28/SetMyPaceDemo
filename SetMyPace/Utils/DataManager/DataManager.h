//
//  DataManager.h
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

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "CommonUtility.h"

//IMPORTING MODELS
#import "User.h"

@interface DataManager : NSObject
{
    // The delegate - Will be notified of various changes of state via the DataManagerDelegate
    
    NSNumber  *isNetworkAvailable;
    AppDelegate *appDelegate;
}

@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) NSDictionary *dictSettings;

@property(nonatomic,retain) User *objLoggedInUser;

@property(strong,nonatomic) NSMutableArray *arrayWorkoutList;
@property(strong,nonatomic) NSMutableArray *arrayMyIntervalsList;

@property(strong,nonatomic) NSMutableArray *arrayMyLogsTodayList;
@property(strong,nonatomic) NSMutableArray *arrayMyLogsWeekList;
@property(strong,nonatomic) NSMutableArray *arrayMyLogsMonthList;
@property(strong,nonatomic) NSMutableArray *arrayMyLogsYearList;

@property(strong,nonatomic) NSMutableArray *arrayImportExportWorkoutList;

@property(strong,nonatomic) NSMutableArray *arrayMostOrderedRestaurantList;

#pragma mark - Server communication

//FUNCTION TO CHECK IF INTERNET CONNECTION IS AVAILABLE OR NOT
-(BOOL)isNetworkAvailable;

//FUNCTION TO SHOW ERROR ALERT
-(void)showErrorMessage:(NSString *)errorTitle withErrorContent:(NSString *)errorDescription;

//FUNCTION FOR USER LOGIN
-(void)userLogin:(User *)objUser;

//FUNCTION FOR USER SIGNUP
-(void)userSignUp:(User *)objUser;

//FUNCTION TO GET MOST ORDERED RESTAURANTS
-(void)getMostOrderedRestaurants;

@end
