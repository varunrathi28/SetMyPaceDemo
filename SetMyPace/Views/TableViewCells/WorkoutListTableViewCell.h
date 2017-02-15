//
//  WorkoutListTableViewCell.h
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

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface WorkoutListTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *mainContainerView;

@property (nonatomic, retain) IBOutlet AsyncImageView *imageViewWorkout;
@property (nonatomic, retain) IBOutlet UILabel *lblWorkoutName;
@property (nonatomic, retain) IBOutlet UILabel *lblWorkoutDetails;

@property (nonatomic, retain) IBOutlet AsyncImageView *imageViewClock;
@property (nonatomic, retain) IBOutlet UILabel *lblWorkoutTime;

@property (nonatomic, retain) IBOutlet UIView *separatorView;

@end
