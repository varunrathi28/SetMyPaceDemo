//
//  SideMenuViewController.h
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

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

#import "TheSidebarController.h"

@interface SideMenuViewController : UIViewController<UIScrollViewDelegate, TheSidebarControllerDelegate>

//========== IBOUTLETS ==========//

@property (nonatomic,retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,retain) IBOutlet UIView *mainContainerView;

@property (nonatomic,retain) IBOutlet UIImageView *mainImageViewBackground;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewProfilePicture;
@property (nonatomic,retain) IBOutlet UILabel *lblFullName;
@property (nonatomic,retain) IBOutlet UIView *separatorView1;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewMyIntervals;
@property (nonatomic,retain) IBOutlet UILabel *lblMyIntervals;
@property (nonatomic,retain) IBOutlet UIButton *btnMyIntervals;
@property (nonatomic,retain) IBOutlet UIView *separatorView2;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewMyRecordings;
@property (nonatomic,retain) IBOutlet UILabel *lblMyRecordings;
@property (nonatomic,retain) IBOutlet UIButton *btnMyRecordings;
@property (nonatomic,retain) IBOutlet UIView *separatorView3;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewImportExport;
@property (nonatomic,retain) IBOutlet UILabel *lblImportExport;
@property (nonatomic,retain) IBOutlet UIButton *btnImportExport;
@property (nonatomic,retain) IBOutlet UIView *separatorView4;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewMyLogs;
@property (nonatomic,retain) IBOutlet UILabel *lblMyLogs;
@property (nonatomic,retain) IBOutlet UIButton *btnMyLogs;
@property (nonatomic,retain) IBOutlet UIView *separatorView5;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewSettings;
@property (nonatomic,retain) IBOutlet UILabel *lblSettings;
@property (nonatomic,retain) IBOutlet UIButton *btnSettings;
@property (nonatomic,retain) IBOutlet UIView *separatorView6;

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewMyAccount;
@property (nonatomic,retain) IBOutlet UILabel *lblMyAccount;
@property (nonatomic,retain) IBOutlet UIButton *btnMyAccount;
@property (nonatomic,retain) IBOutlet UIView *separatorView7;

//========== OTHER VARIABLES ==========//

@end
