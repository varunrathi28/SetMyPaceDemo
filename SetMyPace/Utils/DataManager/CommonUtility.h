//
//  CommonUtility.h
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

@interface CommonUtility : NSObject

-(BOOL) isValidEmailAddress:(NSString *)checkString;
-(NSString *)convertDateStringInFormatForToday:(NSString *)localDateStr;
-(NSString *)getShortWeekNames:(NSString *)localDateStr;
-(NSString *)getEncodedURLString:(NSString *)urlString;
-(NSLocale *)getCurrentLocale;

@end
