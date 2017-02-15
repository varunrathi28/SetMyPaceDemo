//
//  AddIntervalViewController.h
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

@interface AddIntervalViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>
{
    //TO ANIMATE VIEW UP ON KEYBOARD SHOW
    CGFloat animatedDistance;
    UITextField *activeTextField;
    BOOL keyboardShown;
    BOOL viewMoved;
}

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@property (strong, nonatomic) UITextField *activeTextField;
@property (nonatomic,assign) BOOL keyboardShown;
@property (nonatomic,assign) BOOL viewMoved;

//========== IBOUTLETS ==========//

@property (nonatomic,retain) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic,retain) IBOutlet UIView *mainContainerView;

@property (nonatomic,retain) IBOutlet UIView *navigationBarView;
@property (nonatomic,retain) IBOutlet UIView *navigationStatusBarView;
@property (nonatomic,retain) IBOutlet UILabel *lblNavigationTitle;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewBack;
@property (nonatomic,retain) IBOutlet UIButton *btnBack;

@property (nonatomic,retain) IBOutlet UIView *mainInnerContainerView;

@property (nonatomic,retain) IBOutlet UILabel *lblInervalName;
@property (nonatomic,retain) IBOutlet UITextField *txtInervalName;

@property (nonatomic,retain) IBOutlet UILabel *lblIntervalTime;
@property (nonatomic,retain) IBOutlet UIView *txtIntervalTimeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtIntervalTime;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewIntervalTime;

@property (nonatomic,retain) IBOutlet UILabel *lblRestTime;
@property (nonatomic,retain) IBOutlet UIView *txtRestTimeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtRestTime;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewRestTime;
@property (nonatomic,retain) IBOutlet UIView *restTimeBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblPlaylistTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblPlaylistValue;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewPlaylistArrow;
@property (nonatomic,retain) IBOutlet UIView *playlistBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblCoachingFileTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblCoachingFileValue;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewCoachingFileArrow;
@property (nonatomic,retain) IBOutlet UIView *coachingFileBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblCoachingTime;
@property (nonatomic,retain) IBOutlet UIView *txtCoachingTimeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtCoachingTime;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewCoachingTime;

@property (nonatomic,retain) IBOutlet UIButton *btnAddInterval;

//========== OTHER VARIABLES ==========//

@property (strong,nonatomic) UIToolbar* keyboardDoneButtonView;

@property (nonatomic,retain) UIDatePicker *intervalTimePicker;
@property (nonatomic,retain) UIDatePicker *restTimePicker;
@property (nonatomic,retain) UIDatePicker *coachingTimePicker;

@end
