//
//  BMIViewController.h
//  WeightLoss
//
//  Created by Dev on 6/3/17.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIViewController : UIViewController

- (IBAction)onBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnStandard;
@property (weak, nonatomic) IBOutlet UIButton *btnMetric;


@property (weak, nonatomic) IBOutlet UIView *underlineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *underlineCenterConstraint;

- (IBAction)onStandard:(id)sender;
- (IBAction)onMetric:(id)sender;


@end
