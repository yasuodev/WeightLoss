//
//  MainViewController.m
//  WeightLoss
//
//  Created by Dev on 6/3/17.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController
@synthesize ref;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lblName.text = @"";
    
    ref = [[FIRDatabase database] reference];
    
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSString *strName = snapshot.value[@"username"];
        self.lblName.text = strName;
    }];
    
    self.btnExercises.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnExercises.layer.borderWidth = 1;
    self.btnExercises.layer.cornerRadius = 10;
    
    self.btnProgress.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnProgress.layer.borderWidth = 1;
    self.btnProgress.layer.cornerRadius = 10;
    
    self.btnBMI.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnBMI.layer.borderWidth = 1;
    self.btnBMI.layer.cornerRadius = 10;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBack:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        
        [self showDefaultAlert:nil withMessage:@"Error Signing out"];
        NSLog(@"Error signing out: %@", signOutError);
        return;
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark - show default alert

-(void) showDefaultAlert:(NSString*)title withMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
