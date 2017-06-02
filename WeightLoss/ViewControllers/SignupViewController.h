//
//  SignupViewController.h
//  Pulse
//
//  Created by Kevin on 11/29/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *viewUserID;
@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIView *viewConfirmPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtUserID;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnSignup;


- (IBAction)onSignup:(id)sender;
- (IBAction)onBack:(id)sender;
@end
