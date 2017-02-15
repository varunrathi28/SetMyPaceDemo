//
//  MyLogsViewController.m
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

#import "MyLogsViewController.h"
#import "MySingleton.h"

#import "Interval.h"
#import "MyLogsIntervalTableViewCell.h"

@interface MyLogsViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation MyLogsViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize navigationBarView;
@synthesize navigationStatusBarView;
@synthesize lblNavigationTitle;
@synthesize imageViewMenu;
@synthesize btnMenu;
@synthesize mainInnerContainerView;

@synthesize mainSegmentControl;

@synthesize lblAllWorkout;
@synthesize mainTableView;
@synthesize lblNoWorkoutFound;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

#pragma mark - UI Setup Method

- (void)setupInitialView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIFont *lblAllWorkoutFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
    }
    else
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
    }
    
    mainSegmentControl.sectionTitles = [[NSArray alloc] initWithObjects:@"TODAY", @"WEEK", @"MONTH", @"YEAR", nil];
    mainSegmentControl.selectionIndicatorHeight = 2.0f;
    mainSegmentControl.backgroundColor = [MySingleton sharedManager].themeGlobalLightestGreyColor;
    mainSegmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    mainSegmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    [mainSegmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    lblAllWorkout.textColor = [MySingleton sharedManager].themeGlobalDarkGreyColor;
    lblAllWorkout.font = lblAllWorkoutFont;
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.backgroundColor = [UIColor whiteColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"MyLogsIntervalTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"MyLogsIntervalTableViewCell_iPhone6" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"MyLogsIntervalTableViewCell_iPhone6Plus" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    lblNoWorkoutFound.textColor = [MySingleton sharedManager].themeGlobalLightGreyColor;
    lblNoWorkoutFound.font = lblAllWorkoutFont;
    
    [self showTemporaryDataInTableview];
}

-(void)showTemporaryDataInTableview
{
    [MySingleton sharedManager].dataManager.arrayMyLogsTodayList = [[NSMutableArray alloc] init];
    
    mainTableView.hidden = false;
    lblNoWorkoutFound.hidden = true;
    
    Interval *objInterval1 = [[Interval alloc] init];
    objInterval1.strIntervalID = @"1";
    objInterval1.strIntervalName = @"Barbell Squat";
    objInterval1.strIntervalTime = @"20 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval1];
    
    Interval *objInterval2 = [[Interval alloc] init];
    objInterval2.strIntervalID = @"2";
    objInterval2.strIntervalName = @"Dumbell Lunges";
    objInterval2.strIntervalTime = @"30 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval2];
    
    Interval *objInterval3 = [[Interval alloc] init];
    objInterval3.strIntervalID = @"3";
    objInterval3.strIntervalName = @"Leg Extension";
    objInterval3.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval3];
    
    Interval *objInterval4 = [[Interval alloc] init];
    objInterval4.strIntervalID = @"3";
    objInterval4.strIntervalName = @"Leg Extension";
    objInterval4.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval4];
    
    Interval *objInterval5 = [[Interval alloc] init];
    objInterval5.strIntervalID = @"3";
    objInterval5.strIntervalName = @"Leg Extension";
    objInterval5.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval5];
    
    Interval *objInterval6 = [[Interval alloc] init];
    objInterval6.strIntervalID = @"3";
    objInterval6.strIntervalName = @"Leg Extension";
    objInterval6.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval6];
    
    Interval *objInterval7 = [[Interval alloc] init];
    objInterval7.strIntervalID = @"3";
    objInterval7.strIntervalName = @"Leg Extension";
    objInterval7.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval7];
    
    Interval *objInterval8 = [[Interval alloc] init];
    objInterval8.strIntervalID = @"3";
    objInterval8.strIntervalName = @"Leg Extension";
    objInterval8.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval8];
    
    Interval *objInterval9 = [[Interval alloc] init];
    objInterval9.strIntervalID = @"3";
    objInterval9.strIntervalName = @"Leg Extension";
    objInterval9.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval9];
    
    Interval *objInterval10 = [[Interval alloc] init];
    objInterval10.strIntervalID = @"3";
    objInterval10.strIntervalName = @"Leg Extension";
    objInterval10.strIntervalTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayMyLogsTodayList addObject:objInterval10];
    
    self.dataRows = [MySingleton sharedManager].dataManager.arrayMyLogsTodayList;
}

#pragma mark - HMSegmentedControl Delegate Methods

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    if(segmentedControl.selectedSegmentIndex == 0)
    {
        NSLog(@"selectedSegmentIndex : 0");
        
        self.dataRows = [MySingleton sharedManager].dataManager.arrayMyLogsTodayList;
        
        if(self.dataRows.count <= 0)
        {
            mainTableView.hidden = true;
            lblNoWorkoutFound.hidden = false;
        }
        else
        {
            mainTableView.hidden = false;
            [mainTableView reloadData];
            
            lblNoWorkoutFound.hidden = true;
        }
    }
    else if(segmentedControl.selectedSegmentIndex == 1)
    {
        NSLog(@"selectedSegmentIndex : 1");
        
        self.dataRows = [MySingleton sharedManager].dataManager.arrayMyLogsWeekList;
        
        if(self.dataRows.count <= 0)
        {
            mainTableView.hidden = true;
            lblNoWorkoutFound.hidden = false;
        }
        else
        {
            mainTableView.hidden = false;
            [mainTableView reloadData];
            
            lblNoWorkoutFound.hidden = true;
        }
    }
    else if(segmentedControl.selectedSegmentIndex == 2)
    {
        NSLog(@"selectedSegmentIndex : 2");
        
        self.dataRows = [MySingleton sharedManager].dataManager.arrayMyLogsMonthList;
        
        if(self.dataRows.count <= 0)
        {
            mainTableView.hidden = true;
            lblNoWorkoutFound.hidden = false;
        }
        else
        {
            mainTableView.hidden = false;
            [mainTableView reloadData];
            
            lblNoWorkoutFound.hidden = true;
        }
    }
    else if(segmentedControl.selectedSegmentIndex == 3)
    {
        NSLog(@"selectedSegmentIndex : 3");
        
        self.dataRows = [MySingleton sharedManager].dataManager.arrayMyLogsYearList;
        
        if(self.dataRows.count <= 0)
        {
            mainTableView.hidden = true;
            lblNoWorkoutFound.hidden = false;
        }
        else
        {
            mainTableView.hidden = false;
            [mainTableView reloadData];
            
            lblNoWorkoutFound.hidden = true;
        }
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
        
        MyLogsIntervalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell != nil)
        {
            NSArray *nib;
            
            if([MySingleton sharedManager].screenHeight == 480 || [MySingleton sharedManager].screenHeight == 568)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"MyLogsIntervalTableViewCell" owner:self options:nil];
            }
            else if([MySingleton sharedManager].screenHeight == 667)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"MyLogsIntervalTableViewCell_iPhone6" owner:self options:nil];
            }
            else if([MySingleton sharedManager].screenHeight == 736)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"MyLogsIntervalTableViewCell_iPhone6Plus" owner:self options:nil];
            }
            
            cell = [nib objectAtIndex:0];
        }
        
        cell.lblIntervalName.font = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        cell.lblIntervalName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
        cell.lblIntervalName.text = objInterval.strIntervalName;
        
        cell.lblIntervalTime.font = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        cell.lblIntervalTime.textColor = [MySingleton sharedManager].themeGlobalDarkGreyColor;
        cell.lblIntervalTime.text = objInterval.strIntervalTime;
        
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

#pragma mark - Other Methods

@end
