//
//  MetricBMIVC.m
//  WeightLoss
//
//  Created by Dev on 6/3/17.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "MetricBMIVC.h"

@interface MetricBMIVC ()

@end

@implementation MetricBMIVC
@synthesize txtHeight;
@synthesize txtWeight;
@synthesize txtBMI;
@synthesize lblBMI;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lblBMI.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) calculate
{
    float height =0, weight = 0;
    
    if ([self isNumeric:txtHeight.text]) {
        height = [txtHeight.text floatValue] * 0.01f;
    }
    
    if ([self isNumeric:txtWeight.text]) {
        weight = [txtWeight.text floatValue];
    }
    
    if (height == 0) {
        txtBMI.text = @"Height?";
    } else {
        float bmi = weight / (height * height);
        txtBMI.text = [NSString stringWithFormat:@"%.4f", bmi];
        
        if (bmi >= 30) {
            lblBMI.text = @"Obesity";
            lblBMI.textColor = [UIColor redColor];
        } else if(bmi >= 25) {
            lblBMI.text = @"Overweight";
            lblBMI.textColor = [UIColor blueColor];
        } else if (bmi >= 18.5) {
            lblBMI.text = @"Normal weight";
            lblBMI.textColor = [UIColor whiteColor];
        } else {
            lblBMI.text = @"Underweight";
            lblBMI.textColor = [UIColor greenColor];
        }
    }
    
}

-(BOOL) isNumeric:(NSString*)checkText
{
    NSScanner *sc = [NSScanner scannerWithString:checkText];
    if ([sc scanFloat:nil]) {
        return [sc isAtEnd];
    }
    return NO;
}

#pragma mark - textfield delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    textField.text = result;
    [self calculate];
    
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self calculate];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [txtHeight resignFirstResponder];
    [txtWeight resignFirstResponder];
    
    [self calculate];
}

@end
