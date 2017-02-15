//
//  AddIntervalViewController.m
//  SetMyPace
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//

//

#import "AddIntervalViewController.h"
#import "MySingleton.h"

@interface AddIntervalViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation AddIntervalViewController

//TO ANIMATE VIEW UP ON KEYBOARD SHOW
@synthesize activeTextField;
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

@synthesize lblInervalName;
@synthesize txtInervalName;

@synthesize lblIntervalTime;
@synthesize txtIntervalTimeContainerView;
@synthesize txtIntervalTime;
@synthesize imageViewIntervalTime;

@synthesize lblRestTime;
@synthesize txtRestTimeContainerView;
@synthesize txtRestTime;
@synthesize imageViewRestTime;
@synthesize restTimeBottomSeparatorView;

@synthesize lblPlaylistTitle;
@synthesize lblPlaylistValue;
@synthesize imageViewPlaylistArrow;
@synthesize playlistBottomSeparatorView;

@synthesize lblCoachingFileTitle;
@synthesize lblCoachingFileValue;
@synthesize imageViewCoachingFileArrow;
@synthesize coachingFileBottomSeparatorView;

@synthesize lblCoachingTime;
@synthesize txtCoachingTimeContainerView;
@synthesize txtCoachingTime;
@synthesize imageViewCoachingTime;

@synthesize btnAddInterval;

//========== OTHER VARIABLES ==========//

@synthesize keyboardDoneButtonView;

@synthesize intervalTimePicker;
@synthesize restTimePicker;
@synthesize coachingTimePicker;

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
    
    UIFont *lblTitleFont, *lblValueFont, *txtFieldFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
    }
    else
    {
        lblTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
    }
    
    lblInervalName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblInervalName.font = lblTitleFont;
    
    UIView *txtInervalNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, txtInervalName.frame.size.height)];
    txtInervalName.leftView = txtInervalNamePaddingView;
    txtInervalName.leftViewMode = UITextFieldViewModeAlways;
    txtInervalName.layer.masksToBounds = YES;
    txtInervalName.layer.cornerRadius = 5.0f;
    txtInervalName.layer.borderWidth = 1.0f;
    txtInervalName.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    txtInervalName.font = txtFieldFont;
    txtInervalName.delegate = self;
    [txtInervalName setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                  forKeyPath:@"_placeholderLabel.textColor"];
    txtInervalName.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtInervalName.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtInervalName setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    
    lblIntervalTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblIntervalTime.font = lblTitleFont;
    
    txtIntervalTimeContainerView.layer.masksToBounds = YES;
    txtIntervalTimeContainerView.layer.cornerRadius = 5.0f;
    txtIntervalTimeContainerView.layer.borderWidth = 1.0f;
    txtIntervalTimeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    //INTERVAL TIME PICKER DATE TEXTFIELD
    intervalTimePicker = [[UIDatePicker alloc] init];
    intervalTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    intervalTimePicker.backgroundColor = [UIColor whiteColor];
    [intervalTimePicker addTarget:self action:@selector(intervalTimeSelected:) forControlEvents:UIControlEventValueChanged];
    
    UIView *txtIntervalTimePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtIntervalTime.frame.size.height)];
    txtIntervalTime.leftView = txtIntervalTimePaddingView;
    txtIntervalTime.leftViewMode = UITextFieldViewModeAlways;
    txtIntervalTime.layer.masksToBounds = YES;
    txtIntervalTime.font = txtFieldFont;
    txtIntervalTime.delegate = self;
    [txtIntervalTime setValue:[MySingleton sharedManager].textfieldPlaceholderColor
           forKeyPath:@"_placeholderLabel.textColor"];
    txtIntervalTime.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtIntervalTime.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtIntervalTime setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtIntervalTime setInputView:intervalTimePicker];
    txtIntervalTime.inputAccessoryView = keyboardDoneButtonView;
    
    
    
    lblRestTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblRestTime.font = lblTitleFont;
    
    txtRestTimeContainerView.layer.masksToBounds = YES;
    txtRestTimeContainerView.layer.cornerRadius = 5.0f;
    txtRestTimeContainerView.layer.borderWidth = 1.0f;
    txtRestTimeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    //Rest TIME PICKER DATE TEXTFIELD
    restTimePicker = [[UIDatePicker alloc] init];
    restTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    restTimePicker.backgroundColor = [UIColor whiteColor];
    [restTimePicker addTarget:self action:@selector(restTimeSelected:) forControlEvents:UIControlEventValueChanged];
    
    UIView *txtRestTimePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtRestTime.frame.size.height)];
    txtRestTime.leftView = txtRestTimePaddingView;
    txtRestTime.leftViewMode = UITextFieldViewModeAlways;
    txtRestTime.layer.masksToBounds = YES;
    txtRestTime.font = txtFieldFont;
    txtRestTime.delegate = self;
    [txtRestTime setValue:[MySingleton sharedManager].textfieldPlaceholderColor
               forKeyPath:@"_placeholderLabel.textColor"];
    txtRestTime.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtRestTime.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtRestTime setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtRestTime setInputView:restTimePicker];
    txtRestTime.inputAccessoryView = keyboardDoneButtonView;
    
    restTimeBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblPlaylistTitle.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblPlaylistTitle.font = lblTitleFont;
    
    lblPlaylistValue.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblPlaylistValue.font = lblValueFont;
    
    playlistBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblCoachingFileTitle.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblCoachingFileTitle.font = lblTitleFont;
    
    lblCoachingFileValue.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblCoachingFileValue.font = lblValueFont;
    
    coachingFileBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;

    
    lblCoachingTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblCoachingTime.font = lblTitleFont;
    
    txtCoachingTimeContainerView.layer.masksToBounds = YES;
    txtCoachingTimeContainerView.layer.cornerRadius = 5.0f;
    txtCoachingTimeContainerView.layer.borderWidth = 1.0f;
    txtCoachingTimeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    //Coaching TIME PICKER DATE TEXTFIELD
    coachingTimePicker = [[UIDatePicker alloc] init];
    coachingTimePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    coachingTimePicker.backgroundColor = [UIColor whiteColor];
    [coachingTimePicker addTarget:self action:@selector(coachingTimeSelected:) forControlEvents:UIControlEventValueChanged];
    
    UIView *txtCoachingTimePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtCoachingTime.frame.size.height)];
    txtCoachingTime.leftView = txtCoachingTimePaddingView;
    txtCoachingTime.leftViewMode = UITextFieldViewModeAlways;
    txtCoachingTime.layer.masksToBounds = YES;
    txtCoachingTime.font = txtFieldFont;
    txtCoachingTime.delegate = self;
    [txtCoachingTime setValue:[MySingleton sharedManager].textfieldPlaceholderColor
                   forKeyPath:@"_placeholderLabel.textColor"];
    txtCoachingTime.textColor = [MySingleton sharedManager].textfieldTextColor;
    txtCoachingTime.tintColor = [MySingleton sharedManager].textfieldTextColor;
    [txtCoachingTime setAutocorrectionType:UITextAutocorrectionTypeNo];
    [txtCoachingTime setInputView:coachingTimePicker];
    txtCoachingTime.inputAccessoryView = keyboardDoneButtonView;
    
    
    btnAddInterval.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnAddInterval.layer.masksToBounds = true;
    btnAddInterval.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnAddInterval.titleLabel.font = btnFont;
    [btnAddInterval setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnAddInterval addTarget:self action:@selector(btnAddIntervalClicked) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - Other Methods

-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
}



-(void)intervalTimeSelected:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    if([appDelegate isClock24Hour])
    {
        [dateFormat setDateFormat:@"HH:mm"];
    }
    else
    {
        [dateFormat setDateFormat:@"hh:mm a"];
    }
    NSString *strSelectedStartDate = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:intervalTimePicker.date]];
    txtIntervalTime.text = strSelectedStartDate;
}

-(void)restTimeSelected:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    if([appDelegate isClock24Hour])
    {
        [dateFormat setDateFormat:@"HH:mm"];
    }
    else
    {
        [dateFormat setDateFormat:@"hh:mm a"];
    }
    NSString *strSelectedStartDate = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:restTimePicker.date]];
    txtRestTime.text = strSelectedStartDate;
}

-(void)coachingTimeSelected:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    if([appDelegate isClock24Hour])
    {
        [dateFormat setDateFormat:@"HH:mm"];
    }
    else
    {
        [dateFormat setDateFormat:@"hh:mm a"];
    }
    NSString *strSelectedStartDate = [NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:coachingTimePicker.date]];
    txtCoachingTime.text = strSelectedStartDate;
}

- (void)btnAddIntervalClicked
{
    [self.view endEditing:YES];
}

@end
