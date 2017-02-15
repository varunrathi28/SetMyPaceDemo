//
//  LoginRegisterOptionsViewController.h
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

#import <UIKit/UIKit.h>

@interface LoginRegisterOptionsViewController : UIViewController<UIScrollViewDelegate>

//========== IBOUTLETS ==========//

@property (nonatomic,retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,retain) IBOutlet UIView *mainContainerView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewMainLogo;

@property (nonatomic,retain) IBOutlet UIScrollView *AdvertisementScrollView;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewAdvertisement1;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementTitle1;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementDetails1;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewAdvertisement2;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementTitle2;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementDetails2;

@property (nonatomic,retain) IBOutlet UIImageView *imageViewAdvertisement3;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementTitle3;
@property (nonatomic,retain) IBOutlet UILabel *lblAdvertisementDetails3;

@property (nonatomic,retain) IBOutlet UIPageControl *mainPageControl;

@property (nonatomic,retain) IBOutlet UIButton *btnLogin;
@property (nonatomic,retain) IBOutlet UIButton *btnJoinNow;

//========== OTHER VARIABLES ==========//

@end
