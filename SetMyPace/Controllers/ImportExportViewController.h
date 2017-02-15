//
//  ImportExportViewController.h
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

#import "TheSidebarController.h"
#import "SideMenuViewController.h"

@interface ImportExportViewController : UIViewController<UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, TheSidebarControllerDelegate>

@property (nonatomic,retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,retain) IBOutlet UIView *mainContainerView;

@property (nonatomic,retain) IBOutlet UIView *navigationBarView;
@property (nonatomic,retain) IBOutlet UIView *navigationStatusBarView;
@property (nonatomic,retain) IBOutlet UILabel *lblNavigationTitle;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewMenu;
@property (nonatomic,retain) IBOutlet UIButton *btnMenu;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewShare;
@property (nonatomic,retain) IBOutlet UIButton *btnShare;

@property (nonatomic,retain) IBOutlet UIView *mainInnerContainerView;

@property (nonatomic,retain) IBOutlet UILabel *lblAllWorkout;
@property (nonatomic,retain) IBOutlet UITableView *mainTableView;
@property (nonatomic,retain) IBOutlet UILabel *lblNoWorkoutFound;

@property (nonatomic,retain) IBOutlet UIButton *btnExport;
@property (nonatomic,retain) IBOutlet UIButton *btnImportWorkout;

//========== OTHER VARIABLES ==========//

@property (nonatomic,retain) NSMutableArray *dataRows;
@property (nonatomic,retain) NSMutableArray *arraySelectedWorkoutFlags;

@end
