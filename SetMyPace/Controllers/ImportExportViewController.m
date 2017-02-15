//
//  ImportExportViewController.m
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

#import "ImportExportViewController.h"
#import "MySingleton.h"

#import "Workout.h"
#import "ImportExportTableViewCell.h"

@interface ImportExportViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation ImportExportViewController

//========== IBOUTLETS ==========//

@synthesize mainScrollView;
@synthesize mainContainerView;

@synthesize navigationBarView;
@synthesize navigationStatusBarView;
@synthesize lblNavigationTitle;
@synthesize imageViewMenu;
@synthesize btnMenu;
@synthesize imageViewShare;
@synthesize btnShare;

@synthesize mainInnerContainerView;

@synthesize lblAllWorkout;
@synthesize mainTableView;
@synthesize lblNoWorkoutFound;

@synthesize btnExport;
@synthesize btnImportWorkout;

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
    
    imageViewShare.layer.masksToBounds = YES;
    [btnShare addTarget:self action:@selector(btnShareClicked:) forControlEvents:UIControlEventTouchUpInside];
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

-(IBAction)btnShareClicked:(id)sender
{
}

#pragma mark - UI Setup Method

- (void)setupInitialView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIFont *lblAllWorkoutFont, *btnFont;
    
    if([MySingleton sharedManager].screenHeight == 480)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 568)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontTwelveSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFourteenSizeBold;
    }
    else if([MySingleton sharedManager].screenHeight == 667)
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontThirteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontFifteenSizeBold;
    }
    else
    {
        lblAllWorkoutFont = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        btnFont = [MySingleton sharedManager].themeFontSixteenSizeBold;
    }
    
    lblAllWorkout.textColor = [MySingleton sharedManager].themeGlobalDarkGreyColor;
    lblAllWorkout.font = lblAllWorkoutFont;
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.backgroundColor = [UIColor whiteColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"ImportExportTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"ImportExportTableViewCell_iPhone6" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [mainTableView registerNib:[UINib nibWithNibName:@"ImportExportTableViewCell_iPhone6Plus" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    lblNoWorkoutFound.textColor = [MySingleton sharedManager].themeGlobalLightGreyColor;
    lblNoWorkoutFound.font = lblAllWorkoutFont;
    
    btnExport.backgroundColor = [MySingleton sharedManager].themeGlobalLightBlueColor;
    btnExport.layer.masksToBounds = true;
    btnExport.layer.cornerRadius = [MySingleton sharedManager].floatButtonCornerRadius;
    btnExport.titleLabel.font = btnFont;
    [btnExport setTitleColor:[MySingleton sharedManager].themeGlobalWhiteColor forState:UIControlStateNormal];
    [btnExport addTarget:self action:@selector(btnExportClicked) forControlEvents:UIControlEventTouchUpInside];
    
    btnImportWorkout.backgroundColor = [MySingleton sharedManager].themeGlobalLightestGreyColor;
    btnImportWorkout.titleLabel.font = btnFont;
    [btnImportWorkout setTitleColor:[MySingleton sharedManager].themeGlobalDarkGreyColor forState:UIControlStateNormal];
    [btnImportWorkout addTarget:self action:@selector(btnImportWorkoutClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self showTemporaryDataInTableview];
}

-(void)showTemporaryDataInTableview
{
    [MySingleton sharedManager].dataManager.arrayImportExportWorkoutList = [[NSMutableArray alloc] init];
    
    mainTableView.hidden = false;
    lblNoWorkoutFound.hidden = true;
    
    Workout *objWorkout1 = [[Workout alloc] init];
    objWorkout1.strWorkoutID = @"1";
    objWorkout1.strWorkoutName = @"Barbell Squat";
    objWorkout1.strWorkoutTime = @"20 mins";
    [[MySingleton sharedManager].dataManager.arrayImportExportWorkoutList addObject:objWorkout1];
    
    Workout *objWorkout2 = [[Workout alloc] init];
    objWorkout2.strWorkoutID = @"2";
    objWorkout2.strWorkoutName = @"Dumbell Lunges";
    objWorkout2.strWorkoutTime = @"30 mins";
    [[MySingleton sharedManager].dataManager.arrayImportExportWorkoutList addObject:objWorkout2];
    
    Workout *objWorkout3 = [[Workout alloc] init];
    objWorkout3.strWorkoutID = @"3";
    objWorkout3.strWorkoutName = @"Leg Extension";
    objWorkout3.strWorkoutTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayImportExportWorkoutList addObject:objWorkout3];
    
    Workout *objWorkout4 = [[Workout alloc] init];
    objWorkout4.strWorkoutID = @"3";
    objWorkout4.strWorkoutName = @"Leg Extension";
    objWorkout4.strWorkoutTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayImportExportWorkoutList addObject:objWorkout4];
    
    Workout *objWorkout5 = [[Workout alloc] init];
    objWorkout5.strWorkoutID = @"3";
    objWorkout5.strWorkoutName = @"Leg Extension";
    objWorkout5.strWorkoutTime = @"10 mins";
    [[MySingleton sharedManager].dataManager.arrayImportExportWorkoutList addObject:objWorkout5];
    
    self.dataRows = [MySingleton sharedManager].dataManager.arrayImportExportWorkoutList;
    
    self.arraySelectedWorkoutFlags = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < self.dataRows.count; i++)
    {
        [self.arraySelectedWorkoutFlags addObject:@"0"];
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
        Workout *objWorkout = [self.dataRows objectAtIndex:indexPath.row];
        
        ImportExportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell != nil)
        {
            NSArray *nib;
            
            if([MySingleton sharedManager].screenHeight == 480 || [MySingleton sharedManager].screenHeight == 568)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"ImportExportTableViewCell" owner:self options:nil];
            }
            else if([MySingleton sharedManager].screenHeight == 667)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"ImportExportTableViewCell_iPhone6" owner:self options:nil];
            }
            else if([MySingleton sharedManager].screenHeight == 736)
            {
                nib = [[NSBundle mainBundle]loadNibNamed:@"ImportExportTableViewCell_iPhone6Plus" owner:self options:nil];
            }
            
            cell = [nib objectAtIndex:0];
        }
        
        cell.lblWorkoutName.font = [MySingleton sharedManager].themeFontFourteenSizeRegular;
        cell.lblWorkoutName.textColor = [MySingleton sharedManager].themeGlobalBlackColor;
        cell.lblWorkoutName.text = objWorkout.strWorkoutName;
        
        cell.btnCheckbox.tag = indexPath.row;
        [cell.btnCheckbox addTarget:self action:@selector(btnCheckboxClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if([[self.arraySelectedWorkoutFlags objectAtIndex:indexPath.row] isEqualToString:@"1"])
        {
            cell.btnCheckbox.selected = true;
        }
        else
        {
            cell.btnCheckbox.selected = false;
        }
        
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
        if([[self.arraySelectedWorkoutFlags objectAtIndex:indexPath.row] isEqualToString:@"1"])
        {
            [self.arraySelectedWorkoutFlags replaceObjectAtIndex:indexPath.row withObject:@"0"];
        }
        else
        {
            [self.arraySelectedWorkoutFlags replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        
        [mainTableView reloadData];
    }
}

#pragma mark - Other Methods

-(IBAction)btnCheckboxClicked:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    
    if([[self.arraySelectedWorkoutFlags objectAtIndex:btnSender.tag] isEqualToString:@"1"])
    {
        [self.arraySelectedWorkoutFlags replaceObjectAtIndex:btnSender.tag withObject:@"0"];
    }
    else
    {
        [self.arraySelectedWorkoutFlags replaceObjectAtIndex:btnSender.tag withObject:@"1"];
    }
    
    [mainTableView reloadData];
}

- (void)btnExportClicked
{
    [self.view endEditing:YES];
}

- (void)btnImportWorkoutClicked
{
    [self.view endEditing:YES];
}

@end
