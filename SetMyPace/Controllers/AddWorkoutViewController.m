//
//  AddWorkoutViewController.m
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

#import "AddWorkoutViewController.h"
#import "MySingleton.h"

#import "Interval.h"
#import "IntervalListTableViewCell.h"

#import "LogWorkoutViewController.h"

@interface AddWorkoutViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation AddWorkoutViewController

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

@synthesize imageViewWorkout;
@synthesize lblAddImage;

@synthesize txtWorkoutName;

@synthesize txtViewWorkoutDescriptionContainerView;
@synthesize txtViewWorkoutDescription;
@synthesize txtViewWorkoutDescriptionBottomSeparatorView;

@synthesize lblPlaylistTitle;
@synthesize lblPlaylistValue;
@synthesize imageViewPlaylistArrow;
@synthesize playlistBottomSeparatorView;

@synthesize lblCoachingFileTitle;
@synthesize lblCoachingFileValue;
@synthesize imageViewCoachingFileArrow;
@synthesize coachingFileBottomSeparatorView;

@synthesize lblMetronome;
@synthesize btnMetronomeSwitch;

@synthesize lblTime;
@synthesize txtTimeContainerView;
@synthesize txtTime;
@synthesize imageViewTimeDownArrow;
@synthesize metronomeTimeBottomSeparatorView;

@synthesize lblIntervalsTitle;
@synthesize lblIntervalsValue;
@synthesize imageViewIntervalsArrow;
@synthesize intervalsBottomSeparatorView;

@synthesize mainTableView;

@synthesize btnSave;

//========== OTHER VARIABLES ==========//

@synthesize keyboardDoneButtonView;

@synthesize timePicker;

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
    
    UIFont *lblAddImageFont, *txtFieldFont, *lblPlaylistTitleFont, *lblPlaylistValueFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblAddImageFont = [MySingleton sharedManager].themeFontTenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblPlaylistTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPlaylistValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblAddImageFont = [MySingleton sharedManager].themeFontTenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblPlaylistTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPlaylistValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblAddImageFont = [MySingleton sharedManager].themeFontTenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblPlaylistTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPlaylistValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
    }
    else
    {
        lblAddImageFont = [MySingleton sharedManager].themeFontTenSizeRegular;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblPlaylistTitleFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPlaylistValueFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
    }
    
    imageViewWorkout.userInteractionEnabled = true;
    UITapGestureRecognizer *imageViewWorkoutTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewWorkoutTapped:)];
    imageViewWorkoutTapRecognizer.delegate = self;
    [imageViewWorkout addGestureRecognizer:imageViewWorkoutTapRecognizer];
    
    lblAddImage.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblAddImage.font = lblAddImageFont;
    
    
    UIView *txtWorkoutNamePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, txtWorkoutName.frame.size.height)];
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
    
    
    txtViewWorkoutDescriptionContainerView.layer.masksToBounds = YES;
    txtViewWorkoutDescriptionContainerView.layer.cornerRadius = 5.0f;
    txtViewWorkoutDescriptionContainerView.layer.borderWidth = 1.0f;
    txtViewWorkoutDescriptionContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
    txtViewWorkoutDescription.text = @"Workout Description";
    txtViewWorkoutDescription.delegate = self;
    txtViewWorkoutDescription.font = txtFieldFont;
    txtViewWorkoutDescription.autocorrectionType = UITextAutocorrectionTypeNo;
    txtViewWorkoutDescription.backgroundColor = [UIColor clearColor];
    txtViewWorkoutDescription.inputAccessoryView = keyboardDoneButtonView;
    txtViewWorkoutDescription.textColor = [MySingleton sharedManager].textfieldPlaceholderColor;
    txtViewWorkoutDescription.tintColor = [MySingleton sharedManager].textfieldTextColor;
    
    txtViewWorkoutDescriptionBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblPlaylistTitle.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblPlaylistTitle.font = lblPlaylistTitleFont;
    
    lblPlaylistValue.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblPlaylistValue.font = lblPlaylistValueFont;
    
    playlistBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblCoachingFileTitle.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblCoachingFileTitle.font = lblPlaylistTitleFont;
    
    lblCoachingFileValue.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblCoachingFileValue.font = lblPlaylistValueFont;
    
    coachingFileBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblMetronome.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblMetronome.font = lblPlaylistTitleFont;
        
    [[btnMetronomeSwitch imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [btnMetronomeSwitch setImage:[UIImage imageNamed:@"switch_off.png"] forState:UIControlStateNormal];
    [btnMetronomeSwitch setImage:[UIImage imageNamed:@"switch_on.png"] forState:UIControlStateSelected];
    [btnMetronomeSwitch addTarget:self action:@selector(btnMetronomeSwitchClicked) forControlEvents:UIControlEventTouchUpInside];
    
    lblTime.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblTime.font = lblPlaylistTitleFont;
    
    txtTimeContainerView.layer.masksToBounds = YES;
    txtTimeContainerView.layer.cornerRadius = 5.0f;
    txtTimeContainerView.layer.borderWidth = 1.0f;
    txtTimeContainerView.layer.borderColor = [MySingleton sharedManager].textfieldBorderColor.CGColor;
    
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
    
    //TIME PICKER DATE TEXTFIELD
    timePicker = [[UIPickerView alloc] init];
    timePicker.delegate = self;
    timePicker.dataSource = self;
    timePicker.showsSelectionIndicator = YES;
    timePicker.tag = 1;
    timePicker.backgroundColor = [UIColor whiteColor];
    
    UIView *txtTimePaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, txtTime.frame.size.height)];
    txtTime.leftView = txtTimePaddingView;
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
    
    metronomeTimeBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    
    lblIntervalsTitle.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblIntervalsTitle.font = lblPlaylistTitleFont;
    
    lblIntervalsValue.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
    lblIntervalsValue.font = lblPlaylistValueFont;
    
    intervalsBottomSeparatorView.backgroundColor = [MySingleton sharedManager].textfieldNormalStateBottomSeparatorColor;
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.backgroundColor = [UIColor whiteColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"IntervalListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"IntervalListTableViewCell_iPhone6" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"IntervalListTableViewCell_iPhone6Plus" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self showTemporaryDataInTableview];
    
    
    btnSave.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnSave.layer.masksToBounds = true;
    btnSave.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnSave.titleLabel.font = btnFont;
    [btnSave setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(btnSaveClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showTemporaryDataInTableview
{
    self.dataRows = [[NSMutableArray alloc] init];
    
    mainTableView.hidden = false;
    
    Interval *objInterval1 = [[Interval alloc] init];
    objInterval1.strIntervalID = @"1";
    objInterval1.strIntervalName = @"Jumping Jackes";
    [self.dataRows addObject:objInterval1];
    
    Interval *objInterval2 = [[Interval alloc] init];
    objInterval2.strIntervalID = @"2";
    objInterval2.strIntervalName = @"Crunches";
    [self.dataRows addObject:objInterval2];
}

#pragma mark - UITextView Delegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView == txtViewWorkoutDescription)
    {
        if ([textView.text isEqualToString:@"Workout Description"]) {
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
    if(textView == txtViewWorkoutDescription)
    {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Workout Description";
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

#pragma mark - UITableViewController Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataRows.count > 0)
    {
        return self.dataRows.count;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataRows.count > 0)
    {
        return 51;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if(self.dataRows.count > 0)
    {
        Interval *objInterval = [self.dataRows objectAtIndex:indexPath.row];
        
        IntervalListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell != nil)
        {
            NSArray *nib;
            
            float floatImageViewWorkoutCornerRadius;
            
            if([MySingleton sharedManager].screenHeight == 480 || [MySingleton sharedManager].screenHeight == 568)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"IntervalListTableViewCell" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            else if([MySingleton sharedManager].screenHeight == 667)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"IntervalListTableViewCell_iPhone6" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            else if([MySingleton sharedManager].screenHeight == 736)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"IntervalListTableViewCell_iPhone6Plus" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            
            cell = [nib objectAtIndex:0];
        }
        
        cell.lblIntervalName.font = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        cell.lblIntervalName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
        cell.lblIntervalName.text = objInterval.strIntervalName;
        
        cell.separatorView.backgroundColor = [MySingleton sharedManager].themeGlobalSeperatorGreyColor;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    if(self.dataRows.count > 0)
    {
    }
}

#pragma mark - UIImagePickerController Delegate Method

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    @try
    {
        UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        CGSize newSize = CGSizeMake(320, 320);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0,0,320,320)];
        
        UIImage* smaller = UIGraphicsGetImageFromCurrentImageContext();
        
        self.imageSelectedPhoto = smaller;
        imageViewWorkout.image = self.imageSelectedPhoto;
        imageViewWorkout.layer.masksToBounds = YES;
        imageViewWorkout.layer.cornerRadius = imageViewWorkout.frame.size.width / 2;
        
        //SEND IMAGE DATA TO SERVER
        self.imageData = UIImagePNGRepresentation(smaller);
//        self.strImageBase64Data = [self.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.strImageBase64Data = [self.imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        UIGraphicsEndImageContext();
        
        [picker dismissViewControllerAnimated:NO completion:NULL];
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception in imagePickerController's didFinishPickingMediaWithInfo Method, %@",exception);
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerView Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag == 1)
    {
        return 3;
    }
    
     return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if(pickerView.tag == 1)
    {
        if (component == 0)
        {
            return [self.arrayHours count];
        }
        else if (component == 1)
        {
            return [self.arrayMinutes count];
        }
        else
        {
            return [self.arraySeconds count];
        }
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 1)
    {
        switch(component)
        {
            case 0:
                return [NSString stringWithFormat:@"%@", [self.arrayHours objectAtIndex:row]];
                break;
            case 1:
                return [NSString stringWithFormat:@"%@", [self.arrayMinutes objectAtIndex:row]];
                break;
            case 2:
                return [NSString stringWithFormat:@"%@", [self.arraySeconds objectAtIndex:row]];
                break;
        }
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == 1)
    {
        [self calculateTimeFromTimePicker];
    }
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

- (void)imageViewWorkoutTapped:(UITapGestureRecognizer*)sender
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take a Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Take a Photo
        [self dismissViewControllerAnimated:YES completion:nil];
        [self takeAPhoto];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose from Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Choose from Gallery
        [self dismissViewControllerAnimated:YES completion:nil];
        [self chooseFromGallery];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

-(void)takeAPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        }
        else
        {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable" message:@"Unable to find a camera on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

-(void)chooseFromGallery
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.allowsEditing = YES;
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        }
        else
        {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Photo library Unavailable" message:@"Unable to find photo library on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (void)btnMetronomeSwitchClicked
{
    [self.view endEditing:YES];
    
    if(btnMetronomeSwitch.selected)
    {
        btnMetronomeSwitch.selected = false;
    }
    else
    {
        btnMetronomeSwitch.selected = true;
    }
}

- (void)btnSaveClicked
{
    [self.view endEditing:YES];
    
    LogWorkoutViewController *viewController = [[LogWorkoutViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
