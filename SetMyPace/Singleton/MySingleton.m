//
//  MySingleton.m
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

#import "MySingleton.h"

@implementation MySingleton

@synthesize dataManager;

+(MySingleton *)sharedManager
{
    static MySingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
    if (self = [super init])
    {
        self.dataManager = [[DataManager alloc]init];
        
        _screenRect = [[UIScreen mainScreen] bounds];
        _screenWidth = _screenRect.size.width;
        _screenHeight = _screenRect.size.height;
        
        //=========================SIDE MENU SETTINGS================//
        //0 = SidebarTransitionStyleFacebook
        //1 = SidebarTransitionStyleAirbnb
        //2 = SidebarTransitionStyleLuvocracy
        //3 = SidebarTransitionStyleFeedly
        //4 = SidebarTransitionStyleFlipboard
        //5 = SidebarTransitionStyleWunderlist
        _intSideMenuStyle = 5;
        
        //=========================NAVIGATION BAR SETTINGS================//
        _navigationBarBackgroundColor = UIColorFromRGB(0x2E3A43);
        _navigationStatusBarBackgroundColor = UIColorFromRGB(0x2E3A43);
        _navigationBarTitleColor = UIColorFromRGB(0xFFFFFF);
        if(_screenHeight == 480)
        {
            _navigationBarTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        }
        else if(_screenHeight == 568)
        {
            _navigationBarTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        }
        else if(_screenHeight == 667)
        {
            _navigationBarTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:17.0f];
        }
        else if(_screenHeight == 736)
        {
            _navigationBarTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:18.0f];
        }
        
        //=========================THEME GLOBAL COLORS SETTINGS================//
        _themeGlobalLightBlueColor = UIColorFromRGB(0x60AAEA);
        _themeGlobalDarkBlueColor = UIColorFromRGB(0x475A95);
        _themeGlobalWhiteColor = UIColorFromRGB(0xFFFFFF);
        _themeGlobalBlackColor = UIColorFromRGB(0x000000);
        _themeGlobalDarkGreyColor = UIColorFromRGB(0x6D6E6F);
        _themeGlobalLightGreyColor = UIColorFromRGB(0x9FA0A1);
        _themeGlobalLightestGreyColor = UIColorFromRGB(0xF0F1F2);
        _themeGlobalSeperatorGreyColor = UIColorFromRGB(0xE9E9E9);
        
        _textfieldPlaceholderColor = UIColorFromRGB(0x9FA0A1);
        _textfieldTextColor = UIColorFromRGB(0x60AAEA);
        _textfieldNormalStateBottomSeparatorColor = UIColorFromRGB(0xF0F1F2);
        _textfieldActiveStateBottomSeparatorColor = UIColorFromRGB(0x60AAEA);
        _textfieldBorderColor = UIColorFromRGB(0xF0F1F2);
        
        //=========================FLOAT VALUES SETTINGS================//
        if(_screenHeight == 480)
        {
            _floatButtonCornerRadius = 20.0f;
        }
        else if(_screenHeight == 568)
        {
            _floatButtonCornerRadius = 20.0f;
        }
        else if(_screenHeight == 667)
        {
            _floatButtonCornerRadius = 25.0f;
        }
        else if(_screenHeight == 736)
        {
            _floatButtonCornerRadius = 27.0f;
        }
        
        //=========================THEME REGULAR FONTS SETTING================//
        _themeFontFourSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:4.0f];
        _themeFontFiveSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:5.0f];
        _themeFontSixSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:6.0f];
        _themeFontSevenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:7.0f];
        _themeFontEightSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:8.0f];
        _themeFontNineSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:9.0f];
        _themeFontTenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:10.0f];
        _themeFontElevenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:11.0f];
        _themeFontTwelveSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:12.0f];
        _themeFontThirteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:13.0f];
        _themeFontFourteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
        _themeFontFifteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0f];
        _themeFontSixteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        _themeFontSeventeenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:17.0f];
        _themeFontEighteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:18.0f];
        _themeFontNineteenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:19.0f];
        _themeFontTwentySizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:20.0f];
        _themeFontTwentyOneSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:21.0f];
        _themeFontTwentyTwoSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0f];
        _themeFontTwentyThreeSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:23.0f];
        _themeFontTwentyFourSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:24.0f];
        _themeFontTwentyFiveSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:25.0f];
        _themeFontTwentySixSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:26.0f];
        _themeFontTwentySevenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:27.0f];
        _themeFontTwentyEightSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:28.0f];
        _themeFontTwentyNineSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:29.0f];
        _themeFontThirtySizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:30.0f];
        _themeFontThirtyOneSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:31.0f];
        _themeFontThirtyTwoSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:32.0f];
        _themeFontThirtyThreeSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:33.0f];
        _themeFontThirtyFourSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:34.0f];
        _themeFontThirtyFiveSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:35.0f];
        _themeFontThirtySixSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:36.0f];
        _themeFontThirtySevenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:37.0f];
        _themeFontThirtyEightSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:38.0f];
        _themeFontThirtyNineSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:39.0f];
        _themeFontFourtySizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:40.0f];
        _themeFontFourtyOneSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:41.0f];
        _themeFontFourtyTwoSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:42.0f];
        _themeFontFourtyThreeSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:43.0f];
        _themeFontFourtyFourSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:44.0f];
        _themeFontFourtyFiveSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:45.0f];
        _themeFontFourtySixSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:46.0f];
        _themeFontFourtySevenSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:47.0f];
        _themeFontFourtyEightSizeRegular = [UIFont fontWithName:@"AvenirNext-Regular" size:48.0f];
        
        //=========================THEME LIGHT FONTS SETTINGS================//
        _themeFontFourSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:4.0f];
        _themeFontFiveSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:5.0f];
        _themeFontSixSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:6.0f];
        _themeFontSevenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:7.0f];
        _themeFontEightSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:8.0f];
        _themeFontNineSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:9.0f];
        _themeFontTenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:10.0f];
        _themeFontElevenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:11.0f];
        _themeFontTwelveSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:12.0f];
        _themeFontThirteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:13.0f];
        _themeFontFourteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:14.0f];
        _themeFontFifteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:15.0f];
        _themeFontSixteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:16.0f];
        _themeFontSeventeenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:17.0f];
        _themeFontEighteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:18.0f];
        _themeFontNineteenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:19.0f];
        _themeFontTwentySizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:20.0f];
        _themeFontTwentyOneSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:21.0f];
        _themeFontTwentyTwoSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:22.0f];
        _themeFontTwentyThreeSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:23.0f];
        _themeFontTwentyFourSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:24.0f];
        _themeFontTwentyFiveSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:25.0f];
        _themeFontTwentySixSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:26.0f];
        _themeFontTwentySevenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:27.0f];
        _themeFontTwentyEightSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:28.0f];
        _themeFontTwentyNineSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:29.0f];
        _themeFontThirtySizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:30.0f];
        _themeFontThirtyOneSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:31.0f];
        _themeFontThirtyTwoSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:32.0f];
        _themeFontThirtyThreeSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:33.0f];
        _themeFontThirtyFourSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:34.0f];
        _themeFontThirtyFiveSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:35.0f];
        _themeFontThirtySixSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:36.0f];
        _themeFontThirtySevenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:37.0f];
        _themeFontThirtyEightSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:38.0f];
        _themeFontThirtyNineSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:39.0f];
        _themeFontFourtySizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:40.0f];
        _themeFontFourtyOneSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:41.0f];
        _themeFontFourtyTwoSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:42.0f];
        _themeFontFourtyThreeSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:43.0f];
        _themeFontFourtyFourSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:44.0f];
        _themeFontFourtyFiveSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:45.0f];
        _themeFontFourtySixSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:46.0f];
        _themeFontFourtySevenSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:47.0f];
        _themeFontFourtyEightSizeLight = [UIFont fontWithName:@"AvenirNext-UltraLight" size:48.0f];
        
        //=========================THEME MEDIUM FONTS SETTING================//
        _themeFontFourSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:4.0f];
        _themeFontFiveSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:5.0f];
        _themeFontSixSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:6.0f];
        _themeFontSevenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:7.0f];
        _themeFontEightSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:8.0f];
        _themeFontNineSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:9.0f];
        _themeFontTenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:10.0f];
        _themeFontElevenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:11.0f];
        _themeFontTwelveSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:12.0f];
        _themeFontThirteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:13.0f];
        _themeFontFourteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:14.0f];
        _themeFontFifteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
        _themeFontSixteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0f];
        _themeFontSeventeenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:17.0f];
        _themeFontEighteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:18.0f];
        _themeFontNineteenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:19.0f];
        _themeFontTwentySizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:20.0f];
        _themeFontTwentyOneSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:21.0f];
        _themeFontTwentyTwoSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:22.0f];
        _themeFontTwentyThreeSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:23.0f];
        _themeFontTwentyFourSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:24.0f];
        _themeFontTwentyFiveSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:25.0f];
        _themeFontTwentySixSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:26.0f];
        _themeFontTwentySevenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:27.0f];
        _themeFontTwentyEightSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:28.0f];
        _themeFontTwentyNineSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:29.0f];
        _themeFontThirtySizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:30.0f];
        _themeFontThirtyOneSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:31.0f];
        _themeFontThirtyTwoSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:32.0f];
        _themeFontThirtyThreeSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:33.0f];
        _themeFontThirtyFourSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:34.0f];
        _themeFontThirtyFiveSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:35.0f];
        _themeFontThirtySixSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:36.0f];
        _themeFontThirtySevenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:37.0f];
        _themeFontThirtyEightSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:38.0f];
        _themeFontThirtyNineSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:39.0f];
        _themeFontFourtySizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:40.0f];
        _themeFontFourtyOneSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:41.0f];
        _themeFontFourtyTwoSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:42.0f];
        _themeFontFourtyThreeSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:43.0f];
        _themeFontFourtyFourSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:44.0f];
        _themeFontFourtyFiveSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:45.0f];
        _themeFontFourtySixSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:46.0f];
        _themeFontFourtySevenSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:47.0f];
        _themeFontFourtyEightSizeMedium = [UIFont fontWithName:@"AvenirNext-Medium" size:48.0f];
        
        //=========================THEME BOLD FONTS SETTINGS================//
        _themeFontFourSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:4.0f];
        _themeFontFiveSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:5.0f];
        _themeFontSixSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:6.0f];
        _themeFontSevenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:7.0f];
        _themeFontEightSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:8.0f];
        _themeFontNineSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:9.0f];
        _themeFontTenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:10.0f];
        _themeFontElevenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:11.0f];
        _themeFontTwelveSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:12.0f];
        _themeFontThirteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:13.0f];
        _themeFontFourteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:14.0f];
        _themeFontFifteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:15.0f];
        _themeFontSixteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:16.0f];
        _themeFontSeventeenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:17.0f];
        _themeFontEighteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0f];
        _themeFontNineteenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:19.0f];
        _themeFontTwentySizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:20.0f];
        _themeFontTwentyOneSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:21.0f];
        _themeFontTwentyTwoSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:22.0f];
        _themeFontTwentyThreeSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:23.0f];
        _themeFontTwentyFourSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:24.0f];
        _themeFontTwentyFiveSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:25.0f];
        _themeFontTwentySixSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:26.0f];
        _themeFontTwentySevenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:27.0f];
        _themeFontTwentyEightSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:28.0f];
        _themeFontTwentyNineSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:29.0f];
        _themeFontThirtySizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:30.0f];
        _themeFontThirtyOneSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:31.0f];
        _themeFontThirtyTwoSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:32.0f];
        _themeFontThirtyThreeSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:33.0f];
        _themeFontThirtyFourSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:34.0f];
        _themeFontThirtyFiveSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:35.0f];
        _themeFontThirtySixSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:36.0f];
        _themeFontThirtySevenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:37.0f];
        _themeFontThirtyEightSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:38.0f];
        _themeFontThirtyNineSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:39.0f];
        _themeFontFourtySizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:40.0f];
        _themeFontFourtyOneSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:41.0f];
        _themeFontFourtyTwoSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:42.0f];
        _themeFontFourtyThreeSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:43.0f];
        _themeFontFourtyFourSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:44.0f];
        _themeFontFourtyFiveSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:45.0f];
        _themeFontFourtySixSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:46.0f];
        _themeFontFourtySevenSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:47.0f];
        _themeFontFourtyEightSizeBold = [UIFont fontWithName:@"AvenirNext-Bold" size:48.0f];
        
        //=========================ALERT VIEW SETTING================//
        _alertViewTitleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0];
        _alertViewMessageFont = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
        _alertViewButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0];
        _alertViewCancelButtonTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.0];
        _alertViewTitleColor = UIColorFromRGB(0x0092DD);
        _alertViewContentColor = UIColorFromRGB(0x000000);
        _alertViewLeftButtonFontColor = UIColorFromRGB(0xFFFFFF);
        _alertViewBackGroundColor = UIColorFromRGB(0xFFFFFF);
        _alertViewLeftButtonBackgroundColor = UIColorFromRGB(0x005A9C);
        _alertViewRightButtonBackgroundColor = UIColorFromRGB(0x0092DD);
        
    }
    
    return self;
}

@end
