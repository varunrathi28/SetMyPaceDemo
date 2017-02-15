//
//  LogWorkoutViewController.m
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

#import "LogWorkoutViewController.h"
#import "MySingleton.h"
#import <EventKit/EventKit.h>

@interface LogWorkoutViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation LogWorkoutViewController

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@synthesize activeTextField;
@synthesize activeTextView;
@synthesize keyboardShown;
@synthesize viewMoved;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize navigationBarView;
@synthesize navigationStatusBarView;
@synthesize lblNavigationTitle;
@synthesize imageViewBack;
@synthesize btnBack;

@synthesize mainInnerContainerView;

@synthesize lblWorkoutName;
@synthesize txtWorkoutName;

@synthesize lblWorkoutType;
@synthesize txtWorkoutTypeContainerView;
@synthesize txtWorkoutType;
@synthesize imageViewWorkoutTypeDownArrow;

@synthesize lblElapsedTime;
@synthesize txtElapsedTime;

@synthesize lblDate;
@synthesize txtDateContainerView;
@synthesize txtDate;
@synthesize imageViewDate;

@synthesize lblTime;
@synthesize txtTimeContainerView;
@synthesize txtTime;
@synthesize imageViewTime;

@synthesize txtViewNoteCommentContainerView;
@synthesize txtViewNoteComment;

@synthesize btnAddToCalendar;
@synthesize btnAddToHealthApp;

@synthesize btnPostToFacebookContainerView;
@synthesize imageViewPostToFacebook;
@synthesize lblPostToFacebook;
@synthesize btnPostToFacebook;

//========== OTHER VARIABLES ==========//

@synthesize keyboardDoneButtonView;

@synthesize datePicker;

@synthesize elapsedTimePicker;
@synthesize timePicker;

@synthesize workoutTypePickerView;

#pragma mark - View Controller Delegate Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationBar];
    [self setupInitialView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNotificationEvent];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    CGRect mainContainerViewFrame = mainContainerView.frame;
//    mainContainerViewFrame.size.height = btnSave.frame.origin.y + btnSave.frame.size.height + 20;
//    mainContainerView.frame = mainContainerViewFrame;
    
    mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, mainContainerView.frame.size.height);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeNotificationEventObserver];
}

#pragma mark - Setup Notification Methods

-(void)setupNotificationEvent
{
}

-(void)removeNotificationEventObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Bar Methods

-(void)setNavigationBar
{
    navigationBarView.backgroundColor = [MySingleton sharedManager].navigationBarBackgroundColor;
    navigationStatusBarView.backgroundColor = [MySingleton sharedManager].navigationStatusBarBackgroundColor;
    
    lblNavigationTitle.font = [MySingleton sharedManager].navigationBarTitleFont;
    lblNavigationTitle.textColor = [MySingleton sharedManager].navigationBarTitleColor;
    
    imageViewBack.layer.masksToBounds = YES;
    [btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI Setup Method

- (void)setupInitialView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    keyboardDoneButtonView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *flex1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem* doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    [doneButton1 setTitleTextAttributes:@{ NSFontAttributeName: [MySingleton sharedManager].themeFontTwentySizeRegular,NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flex1,doneButton1, nil]];
    
    UIFont *txtFieldFont, *lblWorkoutTitleFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblWorkoutTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblWorkoutTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblWorkoutTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
    }
    else
    {
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblWorkoutTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
    }
    
    
    self.arrayWorkoutType = [[NSMutableArray alloc]initWithObjects:@"Cardio",@"Chest",@"Legs",nil];
    
    lblWorkoutName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblWorkoutName.font = lblWorkoutTitleFont;
    
    UIView *txtWorkoutNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtWorkoutName.frame.size.height)];
    txtWorkoutName.leftView = txtWorkoutNamePaddingView;
    txtWorkoutName.leftViewMode = UITextFieldViewModeAlways;
    txtWorkoutName.layer.masksToBounds = YES;
    txtWorkoutName.layer.cornerRadius = 5.0f;
    txtWorkoutName.layer.borderWidth = 1.0f;
    txtWorkoutName.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    txtWorkoutName.font = txtFieldFont;
    txtWorkoutName.delegate = self;
    [txtWorkoutName setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                  forKeyPath:@"_placeholderLabel.textColor"];
    txtWorkoutName.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtWorkoutName.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtWorkoutName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    
    lblWorkoutType.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblWorkoutType.font = lblWorkoutTitleFont;
    
    workoutTypePickerView = [[UIPickerView alloc] init];
    workoutTypePickerView.delegate = self;
    workoutTypePickerView.dataSource = self;
    workoutTypePickerView.showsSelectionIndicator = YES;
    workoutTypePickerView.tag = 1;
    workoutTypePickerView.backgroundColor = [UIColor whiteColor];
    
    txtWorkoutTypeContainerView.layer.masksToBounds = YES;
    txtWorkoutTypeContainerView.layer.cornerRadius = 5.0f;
    txtWorkoutTypeContainerView.layer.borderWidth = 1.0f;
    txtWorkoutTypeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    txtWorkoutType.leftViewMode = UITextFieldViewModeAlways;
    txtWorkoutType.layer.masksToBounds = YES;
    txtWorkoutType.font = txtFieldFont;
    txtWorkoutType.delegate = self;
    [txtWorkoutType setValue:[MySingleton sharedManager].textfieldPlaceholderColor
           forKeyPath:@"_placeholderLabel.textColor"];
    txtWorkoutType.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtWorkoutType.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtWorkoutType setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtWorkoutType setInputView:workoutTypePickerView];
    txtWorkoutType.inputAccessoryView = keyboardDoneButtonView;
    
    
    lblElapsedTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblElapsedTime.font = lblWorkoutTitleFont;
    
    //initialize arrays
    self.arrayHours = [[NSMutableArray alloc] init];
    self.arrayMinutes = [[NSMutableArray alloc] init];
    self.arraySeconds = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
    
    for(int i = 0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%02d", i];
        
        //Create array with 0-12 hours
        if (i < 13)
        {
            [self.arrayHours addObject:strVal];
        }
        
        //create arrays with 0-60 secs/mins
        [self.arrayMinutes addObject:strVal];
        [self.arraySeconds addObject:strVal];
    }
    
    //ELPASED TIME PICKER DATE TEXTFIELD
    elapsedTimePicker = [[UIPickerView alloc] init];
    elapsedTimePicker.delegate = self;
    elapsedTimePicker.dataSource = self;
    elapsedTimePicker.showsSelectionIndicator = YES;
    elapsedTimePicker.tag = 2;
    elapsedTimePicker.backgroundColor = [UIColor whiteColor];
    
    UIView *txtElapsedTimePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txtElapsedTime.frame.size.height)];
    txtElapsedTime.leftView = txtElapsedTimePaddingView;
    txtElapsedTime.leftViewMode = UITextFieldViewModeAlways;
    txtElapsedTime.layer.masksToBounds = YES;
    txtElapsedTime.layer.cornerRadius = 5.0f;
    txtElapsedTime.layer.borderWidth = 1.0f;
    txtElapsedTime.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    txtElapsedTime.font = txtFieldFont;
    txtElapsedTime.delegate = self;
    [txtElapsedTime setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                  forKeyPath:@"_placeholderLabel.textColor"];
    txtElapsedTime.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtElapsedTime.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtElapsedTime setInputView:elapsedTimePicker];
    [txtElapsedTime setAutocorrectionType:UITextAutocorrectionTypeNo];
    txtElapsedTime.inputAccessoryView = keyboardDoneButtonView;
    
    
    lblDate.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblDate.font = lblWorkoutTitleFont;
    
    txtDateContainerView.layer.masksToBounds = YES;
    txtDateContainerView.layer.cornerRadius = 5.0f;
    txtDateContainerView.layer.borderWidth = 1.0f;
    txtDateContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    //DATE PICKER DATE TEXTFIELD
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setMinimumDate: [NSDate date]];
    datePicker.tag = 1;
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
    
    txtDate.leftViewMode = UITextFieldViewModeAlways;
    txtDate.layer.masksToBounds = YES;
    txtDate.font = txtFieldFont;
    txtDate.delegate = self;
    [txtDate setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                  forKeyPath:@"_placeholderLabel.textColor"];
    txtDate.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtDate.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtDate setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtDate setInputView:datePicker];
    txtDate.inputAccessoryView = keyboardDoneButtonView;
    
    
    lblTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblTime.font = lblWorkoutTitleFont;
    
    txtTimeContainerView.layer.masksToBounds = YES;
    txtTimeContainerView.layer.cornerRadius = 5.0f;
    txtTimeContainerView.layer.borderWidth = 1.0f;
    txtTimeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    //TIME PICKER DATE TEXTFIELD
    timePicker = [[UIPickerView alloc] init];
    timePicker.delegate = self;
    timePicker.dataSource = self;
    timePicker.showsSelectionIndicator = YES;
    timePicker.tag = 3;
    timePicker.backgroundColor = [UIColor whiteColor];
    
    txtTime.leftViewMode = UITextFieldViewModeAlways;
    txtTime.layer.masksToBounds = YES;
    txtTime.font = txtFieldFont;
    txtTime.delegate = self;
    [txtTime setValue:[MySingleton sharedManager].textfieldPlaceholderColor
           forKeyPath:@"_placeholderLabel.textColor"];
    txtTime.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtTime.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtTime setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtTime setInputView:timePicker];
    txtTime.inputAccessoryView = keyboardDoneButtonView;
    
    
    txtViewNoteCommentContainerView.layer.masksToBounds = YES;
    txtViewNoteCommentContainerView.layer.cornerRadius = 5.0f;
    txtViewNoteCommentContainerView.layer.borderWidth = 1.0f;
    txtViewNoteCommentContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    txtViewNoteComment.text = @"Note/Comment";
    txtViewNoteComment.delegate = self;
    txtViewNoteComment.font = txtFieldFont;
    txtViewNoteComment.autocorrectionType = UITextAutocorrectionTypeNo;
    txtViewNoteComment.backgroundColor = [UIColor clearColor];
    txtViewNoteComment.inputAccessoryView = keyboardDoneButtonView;
    txtViewNoteComment.textColor = [MySingleton sharedManager].textfieldPlaceholderColor;
    txtViewNoteComment.tintColor = [MySingleton sharedManager].textfieldTextColor;
    
    
    btnAddToCalendar.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnAddToCalendar.layer.masksToBounds = true;
    btnAddToCalendar.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnAddToCalendar.titleLabel.font = btnFont;
    [btnAddToCalendar setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnAddToCalendar addTarget:self action:@selector(btnAddToCalendarClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnAddToHealthApp.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnAddToHealthApp.layer.masksToBounds = true;
    btnAddToHealthApp.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnAddToHealthApp.titleLabel.font = btnFont;
    [btnAddToHealthApp setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnAddToHealthApp addTarget:self action:@selector(btnAddToHealthAppClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnPostToFacebookContainerView.backgroundColor = [MySingleton sharedManager].themeGlobalDarkBlueColor;
    btnPostToFacebookContainerView.layer.masksToBounds = true;
    btnPostToFacebookContainerView.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    
    lblPostToFacebook.font = btnFont;
    lblPostToFacebook.textColor = [MySingleton sharedManager].themeGlobalWhiteColor;
    
    [btnPostToFacebook addTarget:self action:@selector(btnPostToFacebookClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITextView Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView == txtViewNoteComment)
    {
        if ([textView.text isEqualToString:@"Note/Comment"]) {
            textView.text = @"";
            textView.textColor = [MySingleton sharedManager].textfieldTextColor;
        }
    }
    
    self.activeTextView = textView;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 568)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 667)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(375, 190);
    }
    else if ([MySingleton sharedManager].screenHeight == 736)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(414, 195);
    }
    
    CGRect textViewRect  = [self.view.window convertRect:self.activeTextView.bounds fromView:self.activeTextView];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textViewRect.origin.y + 0.5 * textViewRect.size.height;
    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = 	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)	* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor([MySingleton sharedManager].keyboardSize.height * heightFraction+40);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    viewMoved = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView == txtViewNoteComment)
    {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Note/Comment";
            textView.textColor = [MySingleton sharedManager].textfieldPlaceholderColor;
        }
    }
    
    self.activeTextView = nil;
    
    if ( viewMoved ) {
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
        viewMoved = NO;
    }
}

#pragma mark - UITextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 568)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(320, 175);
    }
    else if ([MySingleton sharedManager].screenHeight == 667)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(375, 190);
    }
    else if ([MySingleton sharedManager].screenHeight == 736)
    {
        [MySingleton sharedManager].keyboardSize = CGSizeMake(414, 195);
    }
    
    CGRect textFieldRect  = [self.view.window convertRect:self.activeTextField.bounds fromView:self.activeTextField];
    CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =	midline - viewRect.origin.y	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = 	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)	* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor([MySingleton sharedManager].keyboardSize.height * heightFraction+40);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    viewMoved = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
    
    if ( viewMoved ) {
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
        viewMoved = NO;
    }
}

#pragma mark - UIPickerView Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag == 1)
    {
        return 1;
    }
    else if (pickerView.tag == 2)
    {
        return 3;
    }
    else if (pickerView.tag == 3)
    {
        return 3;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rowsInComponent;
    
    if(pickerView.tag == 1)
    {
        rowsInComponent = [self.arrayWorkoutType count];
    }
    else if(pickerView.tag == 2)
    {
        if (component == 0)
        {
            rowsInComponent = [self.arrayHours count];
        }
        else if (component == 1)
        {
            rowsInComponent = [self.arrayMinutes count];
        }
        else
        {
            rowsInComponent = [self.arraySeconds count];
        }
    }
    else if(pickerView.tag == 3)
    {
        if (component == 0)
        {
            rowsInComponent = [self.arrayHours count];
        }
        else if (component == 1)
        {
            rowsInComponent = [self.arrayMinutes count];
        }
        else
        {
            rowsInComponent = [self.arraySeconds count];
        }
    }
    
    return rowsInComponent;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *nameInRow;
    
    if(pickerView.tag == 1)
    {
        nameInRow=[self.arrayWorkoutType objectAtIndex:row];
    }
    else if(pickerView.tag == 2)
    {
        switch(component)
        {
            case 0:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arrayHours objectAtIndex:row]];
                break;
            case 1:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arrayMinutes objectAtIndex:row]];
                break;
            case 2:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arraySeconds objectAtIndex:row]];
                break;
        }
    }
    else if(pickerView.tag == 3)
    {
        switch(component)
        {
            case 0:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arrayHours objectAtIndex:row]];
                break;
            case 1:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arrayMinutes objectAtIndex:row]];
                break;
            case 2:
                nameInRow = [NSString stringWithFormat:@"%@", [self.arraySeconds objectAtIndex:row]];
                break;
        }
    }
    
    return nameInRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == 1)
    {
        txtWorkoutType.text = [self.arrayWorkoutType objectAtIndex:row];
    }
    else if(pickerView.tag == 2)
    {
        [self calculateTimeFromElapsedTimePicker];
    }
    else if(pickerView.tag == 3)
    {
        [self calculateTimeFromTimePicker];
    }
}

-(IBAction)calculateTimeFromElapsedTimePicker
{
    NSString *strHours = [NSString stringWithFormat:@"%@",[self.arrayHours objectAtIndex:[elapsedTimePicker selectedRowInComponent:0]]];
    
    NSString *strMinutes = [NSString stringWithFormat:@"%@",[self.arrayMinutes objectAtIndex:[elapsedTimePicker selectedRowInComponent:1]]];
    
    NSString *strSeconds = [NSString stringWithFormat:@"%@",[self.arraySeconds objectAtIndex:[elapsedTimePicker selectedRowInComponent:2]]];
    
    NSString *totalTimeStr = [NSString stringWithFormat:@"%@:%@:%@", strHours, strMinutes, strSeconds];
    txtElapsedTime.text = totalTimeStr;
}

-(IBAction)calculateTimeFromTimePicker
{
    NSString *strHours = [NSString stringWithFormat:@"%@",[self.arrayHours objectAtIndex:[timePicker selectedRowInComponent:0]]];
    
    NSString *strMinutes = [NSString stringWithFormat:@"%@",[self.arrayMinutes objectAtIndex:[timePicker selectedRowInComponent:1]]];
    
    NSString *strSeconds = [NSString stringWithFormat:@"%@",[self.arraySeconds objectAtIndex:[timePicker selectedRowInComponent:2]]];
    
    NSString *totalTimeStr = [NSString stringWithFormat:@"%@:%@:%@", strHours, strMinutes, strSeconds];
    txtTime.text = totalTimeStr;
}

#pragma mark - Other Methods

-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}

-(void)dateSelected:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *strSelectedStartDate = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    txtDate.text = strSelectedStartDate;
}

- (void)btnAddToCalendarClicked
{
    [self.view endEditing:YES];
    
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = txtWorkoutName.text;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *startDate = [dateFormat dateFromString:txtDate.text];
        event.startDate = startDate;
        event.endDate = startDate;
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
//        self.savedEventId = event.eventIdentifier;  //save the event id if you want to access this later
    }];
}

- (void)btnAddToHealthAppClicked
{
    [self.view endEditing:YES];
    
    if(NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable])
    {
        // Add your HealthKit code here
        
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        
        // Share body mass, height and body mass index
        NSSet *shareObjectTypes = [NSSet setWithObjects:
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
//                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime],
                                   nil];
        
        // Read date of birth, biological sex and step count
        NSSet *readObjectTypes  = [NSSet setWithObjects:
                                   [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth],
                                   [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex],
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                                   nil];
        
        // Request access
        [healthStore requestAuthorizationToShareTypes:shareObjectTypes
                                            readTypes:readObjectTypes
                                           completion:^(BOOL success, NSError *error) {
                                               
                                               if(success == YES)
                                               {
                                                   // ...
                                                   NSLog(@"Successfully gained access to heath app");
                                                   
                                                   HKUnit *meterUnit = [HKUnit meterUnit];
                                                   HKQuantity *runningQuantity = [HKQuantity quantityWithUnit:meterUnit doubleValue:500];
                                                   
//                                                   HKQuantityType *stepsType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
                                                   HKQuantityType *runningType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
                                                   
                                                   HKQuantitySample *runningSample = [HKQuantitySample quantitySampleWithType:runningType quantity:runningQuantity startDate:[NSDate date] endDate:[NSDate date]];
                                                   
                                                   [healthStore saveObject:runningSample withCompletion:^(BOOL success, NSError *error) {
                                                      
                                                       if (!success) {
                                                           NSLog(@"An error occured saving the sample %@. In your app. The error was: %@.", runningSample, error);
                                                           abort();
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Successfully added data to heath app");
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [appDelegate showErrorAlertViewWithTitle:@"" withDetails:@"Successfully added data to heath app"];
                                                           });
                                                       }
                                                   }];
                                               }
                                               else
                                               {
                                                   // Determine if it was an error or if the
                                                   // user just canceld the authorization request
                                                   NSLog(@"Falied to gain access to heath app");
                                               }
                                               
                                           }];
    }
}

- (void)btnPostToFacebookClicked
{
    [self.view endEditing:YES];
}


@end
