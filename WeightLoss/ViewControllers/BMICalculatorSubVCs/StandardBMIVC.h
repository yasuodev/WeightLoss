//
//  StandardBMIVC.h
//  WeightLoss
//
//  Created by Dev on 6/3/17.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandardBMIVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFeet;
@property (weak, nonatomic) IBOutlet UITextField *txtInches;
@property (weak, nonatomic) IBOutlet UITextField *txtWeight;

@property (weak, nonatomic) IBOutlet UITextField *txtBMI;

@property (weak, nonatomic) IBOutlet UILabel *lblBMI;

@end
