//
//  WorkoutListViewController.m
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

#import "WorkoutListViewController.h"
#import "MySingleton.h"

#import "Workout.h"
#import "WorkoutListTableViewCell.h"

#import "AddWorkoutViewController.h"
#import "LogWorkoutViewController.h"

@interface WorkoutListViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation WorkoutListViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize navigationBarView;
@synthesize navigationStatusBarView;
@synthesize lblNavigationTitle;
@synthesize imageViewMenu;
@synthesize btnMenu;
@synthesize imageViewAdd;
@synthesize btnAdd;

@synthesize mainInnerContainerView;
@synthesize mainTableView;
@synthesize lblNoWorkoutsAdded;

//========== OTHER VARIABLES ==========//

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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self removeNotificationEventObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Notification Methods

-(void)setupNotificationEvent
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotAllWorkoutsEvent) name:@"gotAllWorkoutsEvent" object:nil];
}

-(void)gotAllWorkoutsEvent
{
    self.dataRows = [MySingleton sharedManager].dataManager.arrayWorkoutList;
    
    if(self.dataRows.count <= 0)
    {
        mainTableView.hidden = true;
        
        lblNoWorkoutsAdded.hidden = false;
    }
    else
    {
        mainTableView.hidden = false;
        [mainTableView reloadData];
        
        lblNoWorkoutsAdded.hidden = true;
    }
}

-(void)removeNotificationEventObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Navigation Bar Methods

-(void)setNavigationBar
{
    navigationBarView.backgroundColor = [MySingleton sharedManager].navigationBarBackgroundColor;
    navigationStatusBarView.backgroundColor = [MySingleton sharedManager].navigationStatusBarBackgroundColor;
    
    lblNavigationTitle.font = [MySingleton sharedManager].navigationBarTitleFont;
    lblNavigationTitle.textColor = [MySingleton sharedManager].navigationBarTitleColor;
    
    imageViewMenu.layer.masksToBounds = YES;
    [btnMenu addTarget:self action:@selector(btnMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    imageViewAdd.layer.masksToBounds = YES;
    [btnAdd addTarget:self action:@selector(btnAddClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)btnMenuClicked:(id)sender
{
    if(self.sidebarController.sidebarIsPresenting)
    {
        [self.sidebarController dismissSidebarViewController];
    }
    else
    {
        [self.sidebarController presentLeftSidebarViewControllerWithStyle:[MySingleton sharedManager].intSideMenuStyle];
    }
}

-(IBAction)btnAddClicked:(id)sender
{
    AddWorkoutViewController *viewController = [[AddWorkoutViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
//    LogWorkoutViewController *viewController = [[LogWorkoutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UI Setup Method

- (void)setupInitialView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIFont *lblLocationDisabledInstructionFont, *lblLocationDisabledInstructionBoldFont, *lblPleaseSelectAtleastOneCategoryFont, *txtFieldFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblLocationDisabledInstructionFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblLocationDisabledInstructionBoldFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPleaseSelectAtleastOneCategoryFont = [MySingleton sharedManager].themeFontThirteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblLocationDisabledInstructionFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        lblLocationDisabledInstructionBoldFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
        lblPleaseSelectAtleastOneCategoryFont = [MySingleton sharedManager].themeFontThirteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblLocationDisabledInstructionFont = [MySingleton sharedManager].themeFontFifteenSizeRegular;
        lblLocationDisabledInstructionBoldFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
        lblPleaseSelectAtleastOneCategoryFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontSixteenSizeRegular;
    }
    else
    {
        lblLocationDisabledInstructionFont = [MySingleton sharedManager].themeFontSixteenSizeRegular;
        lblLocationDisabledInstructionBoldFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        lblPleaseSelectAtleastOneCategoryFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
        txtFieldFont = [MySingleton sharedManager].themeFontEighteenSizeRegular;
    }
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.backgroundColor = [UIColor whiteColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"WorkoutListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WorkoutListTableViewCell_iPhone6" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"WorkoutListTableViewCell_iPhone6Plus" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    [self showTemporaryDataInTableview];
}

-(void)showTemporaryDataInTableview
{
    self.dataRows = [[NSMutableArray alloc] init];
    
    mainTableView.hidden = false;
    lblNoWorkoutsAdded.hidden = true;
    
    Workout *objWorkout1 = [[Workout alloc] init];
    objWorkout1.strWorkoutID = @"1";
    objWorkout1.strWorkoutImageUrl = @"http://blog.hihostels.com/wp-content/uploads/2013/02/running.jpg";
    objWorkout1.strWorkoutName = @"RUNNING";
    objWorkout1.strWorkoutDetails = @"Ran for 5 miles in the treadmill";
    objWorkout1.strWorkoutTime = @"20 mins";
    [self.dataRows addObject:objWorkout1];
    
    Workout *objWorkout2 = [[Workout alloc] init];
    objWorkout2.strWorkoutID = @"2";
    objWorkout2.strWorkoutImageUrl = @"http://blog.hihostels.com/wp-content/uploads/2013/02/running.jpg";
    objWorkout2.strWorkoutName = @"SQUATS";
    objWorkout2.strWorkoutDetails = @"4 Sets, 6-8 reps";
    objWorkout2.strWorkoutTime = @"20 mins";
    [self.dataRows addObject:objWorkout2];
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
        return 101;
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
        Workout *objWorkout = [self.dataRows objectAtIndex:indexPath.row];
        
        WorkoutListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell != nil)
        {
            NSArray *nib;
            
            float floatImageViewWorkoutCornerRadius;
            
            if([MySingleton sharedManager].screenHeight == 480 || [MySingleton sharedManager].screenHeight == 568)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"WorkoutListTableViewCell" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            else if([MySingleton sharedManager].screenHeight == 667)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"WorkoutListTableViewCell_iPhone6" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            else if([MySingleton sharedManager].screenHeight == 736)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"WorkoutListTableViewCell_iPhone6Plus" owner:self options:nil];
                
                floatImageViewWorkoutCornerRadius = 35.0f;
            }
            
            cell = [nib objectAtIndex:0];
            
            cell.imageViewWorkout.layer.masksToBounds = YES;
            cell.imageViewWorkout.layer.cornerRadius = floatImageViewWorkoutCornerRadius;
        }
        
        NSURL *url = [NSURL URLWithString:objWorkout.strWorkoutImageUrl];
        cell.imageViewWorkout.imageURL = url;
        cell.imageViewWorkout.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.lblWorkoutName.font = [MySingleton sharedManager].themeFontFourteenSizeBold;
        cell.lblWorkoutName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
        cell.lblWorkoutName.text = objWorkout.strWorkoutName;
        
        cell.lblWorkoutDetails.font = [MySingleton sharedManager].themeFontTwelveSizeMedium;
        cell.lblWorkoutDetails.textColor = [MySingleton sharedManager].themeGlobalDarkGreyColor;
        cell.lblWorkoutDetails.text = objWorkout.strWorkoutDetails;
        
        cell.lblWorkoutTime.font = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        cell.lblWorkoutTime.textColor = [MySingleton sharedManager].themeGlobalDarkGreyColor;
        cell.lblWorkoutTime.text = objWorkout.strWorkoutTime;
        
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
        Workout *objWorkout = [self.dataRows objectAtIndex:indexPath.row];
    }
}

#pragma mark - Other Methods

@end
