//
//  LogWorkoutViewController.h
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 01/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

#import <HealthKit/HealthKit.h>

@interface LogWorkoutViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    //TO ANIMATE VIEW UP ON KEYBOARD SHOW
    CGFloat animatedDistance;
    UITextField *activeTextField;
    UITextView *activeTextView;
    BOOL keyboardShown;
    BOOL viewMoved;
}

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@property (strong, nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) UITextView *activeTextView;
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

@property (nonatomic,retain) IBOutlet UILabel *lblWorkoutName;
@property (nonatomic,retain) IBOutlet UITextField *txtWorkoutName;

@property (nonatomic,retain) IBOutlet UILabel *lblWorkoutType;
@property (nonatomic,retain) IBOutlet UIView *txtWorkoutTypeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtWorkoutType;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewWorkoutTypeDownArrow;

@property (nonatomic,retain) IBOutlet UILabel *lblElapsedTime;
@property (nonatomic,retain) IBOutlet UITextField *txtElapsedTime;

@property (nonatomic,retain) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UIView *txtDateContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtDate;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewDate;

@property (nonatomic,retain) IBOutlet UILabel *lblTime;
@property (nonatomic,retain) IBOutlet UIView *txtTimeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtTime;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewTime;

@property (nonatomic,retain) IBOutlet UIView *txtViewNoteCommentContainerView;
@property (nonatomic,retain) IBOutlet UITextView *txtViewNoteComment;

@property (nonatomic,retain) IBOutlet UIButton *btnAddToCalendar;
@property (nonatomic,retain) IBOutlet UIButton *btnAddToHealthApp;

@property (nonatomic,retain) IBOutlet UIView *btnPostToFacebookContainerView;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewPostToFacebook;
@property (nonatomic,retain) IBOutlet UILabel *lblPostToFacebook;
@property (nonatomic,retain) IBOutlet UIButton *btnPostToFacebook;

//========== OTHER VARIABLES ==========//

@property (strong,nonatomic) UIToolbar* keyboardDoneButtonView;

@property (nonatomic,retain) UIDatePicker *datePicker;

@property (nonatomic,retain) NSMutableArray *arrayHours;
@property (nonatomic,retain) NSMutableArray *arrayMinutes;
@property (nonatomic,retain) NSMutableArray *arraySeconds;
@property (nonatomic,retain) UIPickerView *elapsedTimePicker;
@property (nonatomic,retain) UIPickerView *timePicker;

@property (nonatomic,retain) NSMutableArray *arrayWorkoutType;
@property (nonatomic,retain) UIPickerView *workoutTypePickerView;

@end
