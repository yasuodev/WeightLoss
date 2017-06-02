//
//  SplashViewController.h
//  Pulse
//
//  Created by Kevin on 12/21/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblLogoTitle;


@property (weak, nonatomic) IBOutlet UIButton *btnExercises;
@property (weak, nonatomic) IBOutlet UIButton *btnBMI;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;


- (IBAction)onForgotPassword:(id)sender;


@end
