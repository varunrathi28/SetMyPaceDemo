//
//  User.h
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
#import "CommonUtility.h"

@interface User : NSObject

@property(nonatomic,retain) NSString *strValidationMessage;

@property(nonatomic,retain) NSString *strUserType;
@property(nonatomic,retain) NSString *strUserID;
@property(nonatomic,retain) NSString *strEmail;
@property(nonatomic,retain) NSString *strPassword;
@property(nonatomic,retain) NSString *strUserFullname;
@property(nonatomic,retain) NSString *strPhoneNumber;
@property(nonatomic,retain) NSString *strGender;
@property(nonatomic,retain) NSString *strUserHeight;
@property(nonatomic,retain) NSString *strUserWeight;
@property(nonatomic,retain) NSString *strDeviceToken;
@property(nonatomic,retain) NSString *strUniqueDeviceId;

@property(nonatomic,retain) NSString *strFacebookId;
@property(nonatomic,retain) NSString *strFacebookAccessToken;

@property(nonatomic,retain) NSString *strGooglePlusId;
@property(nonatomic,retain) NSString *strGooglePlusAccessToken;

-(BOOL)isValidateUserForLogin;
-(BOOL)isValidateUserForRegistration;
-(BOOL)isValidateSocialMediaUserForRegistration;
-(BOOL)isValidateUserForUpdation;

@end
