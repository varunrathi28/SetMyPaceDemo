//
//  AddWorkoutViewController.h
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 31/01/17.
//   Copyright © 2017 varunrathi28. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface AddWorkoutViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
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

@property (nonatomic,retain) IBOutlet AsyncImageView *imageViewWorkout;
@property (nonatomic,retain) IBOutlet UILabel *lblAddImage;

@property (nonatomic,retain) IBOutlet UITextField *txtWorkoutName;

@property (nonatomic,retain) IBOutlet UIView *txtViewWorkoutDescriptionContainerView;
@property (nonatomic,retain) IBOutlet UITextView *txtViewWorkoutDescription;
@property (nonatomic,retain) IBOutlet UIView *txtViewWorkoutDescriptionBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblPlaylistTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblPlaylistValue;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewPlaylistArrow;
@property (nonatomic,retain) IBOutlet UIView *playlistBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblCoachingFileTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblCoachingFileValue;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewCoachingFileArrow;
@property (nonatomic,retain) IBOutlet UIView *coachingFileBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblMetronome;
@property (nonatomic,retain) IBOutlet UIButton *btnMetronomeSwitch;

@property (nonatomic,retain) IBOutlet UILabel *lblTime;
@property (nonatomic,retain) IBOutlet UIView *txtTimeContainerView;
@property (nonatomic,retain) IBOutlet UITextField *txtTime;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewTimeDownArrow;
@property (nonatomic,retain) IBOutlet UIView *metronomeTimeBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UILabel *lblIntervalsTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblIntervalsValue;
@property (nonatomic,retain) IBOutlet UIImageView *imageViewIntervalsArrow;
@property (nonatomic,retain) IBOutlet UIView *intervalsBottomSeparatorView;

@property (nonatomic,retain) IBOutlet UITableView *mainTableView;

@property (nonatomic,retain) IBOutlet UIButton *btnSave;

//========== OTHER VARIABLES ==========//

@property (strong,nonatomic) UIToolbar* keyboardDoneButtonView;

@property (nonatomic,retain) UIImage *imageSelectedPhoto;
@property (nonatomic,retain) NSData *imageData;
@property (nonatomic,retain) NSString *strImageBase64Data;

@property (nonatomic,retain) NSMutableArray *arrayHours;
@property (nonatomic,retain) NSMutableArray *arrayMinutes;
@property (nonatomic,retain) NSMutableArray *arraySeconds;
@property (nonatomic,retain) UIPickerView *timePicker;

@property (nonatomic,retain) NSMutableArray *dataRows;

@end
