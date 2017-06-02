//
//  LoginViewController.h
//  Pulse
//
//  Created by Kevin on 11/29/16.
//  Copyright © 2016 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, strong) NSString *openUrlID;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewUserID;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtUserID;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)onBack:(id)sender;
- (IBAction)onLogin:(id)sender;

@end
