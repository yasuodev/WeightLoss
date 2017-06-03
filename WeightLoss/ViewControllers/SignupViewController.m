

#import "SignupViewController.h"
#import "LoginViewController.h"
#import "SplashViewController.h"
#import "MainViewController.h"


@interface SignupViewController ()
{
    UITextField *selectedTextField;
    BOOL activateTouchID;
}
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    selectedTextField = self.txtUserID;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    activateTouchID = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) initView
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [self.lblTitle setFont:[UIFont systemFontOfSize:24 * screenSize.height / 667.0f weight:0.2f]];
    
    // textfield placeholder
    NSDictionary * attributes = (NSMutableDictionary *)[ (NSAttributedString *)self.self.txtUserID.attributedPlaceholder attributesAtIndex:0 effectiveRange:NULL];
    NSMutableDictionary * newAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
    [newAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    // Set new text with extracted attributes
    self.txtUserID.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtUserID.attributedPlaceholder string] attributes:newAttributes];
    self.txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtName.attributedPlaceholder string] attributes:newAttributes];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtPassword.attributedPlaceholder string] attributes:newAttributes];
    self.txtConfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtConfirmPassword.attributedPlaceholder string] attributes:newAttributes];
    
    self.viewUserID.layer.borderWidth = 1.0f;
    self.viewUserID.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewUserID.layer.cornerRadius = 5.0f;
    
    self.viewName.layer.borderWidth = 1.0f;
    self.viewName.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewName.layer.cornerRadius = 5.0f;
    
    self.viewPassword.layer.borderWidth = 1.0f;
    self.viewPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewPassword.layer.cornerRadius = 5.0f;
    
    self.viewConfirmPassword.layer.borderWidth = 1.0f;
    self.viewConfirmPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewConfirmPassword.layer.cornerRadius = 5.0f;
    
    self.btnSignup.layer.borderWidth = 1.0f;
    self.btnSignup.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnSignup.layer.cornerRadius = 5.0f;
    
}



- (IBAction)onSignup:(id)sender {
    [self signUp];
}


- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Sign Up
-(void)signUp
{
    NSString *strUserID = self.txtUserID.text;
    NSString *strName = self.txtName.text;
    NSString *strPassword = self.txtPassword.text;
    NSString *strConfirmPassword = self.txtConfirmPassword.text;
    
    if ([strUserID isEqual:@""] || [strName isEqual:@""] || [strPassword isEqual:@""]) {
        [self showDefaultAlert:@"" withMessage:@"Please input all fields."];
        return;
    }
    
    if (![strPassword isEqualToString:strConfirmPassword]) {
        [self showDefaultAlert:@"" withMessage:@"Confirm Password failed."];
        return;
    }
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:strUserID forKey:@"userid"];
    [userdefaults setObject:strName forKey:@"name"];
    [userdefaults setObject:strPassword forKey:@"password"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@ is registerd successfully!", strName] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        MainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:mainVC animated:YES];
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    selectedTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtUserID) {
        [self.txtName becomeFirstResponder];
    } else if (textField == self.txtName) {
        [self.txtPassword becomeFirstResponder];
    } else if (textField == self.txtPassword) {
        [self.txtConfirmPassword becomeFirstResponder];
    } else {
        [self.scrollView setContentOffset:CGPointZero animated:YES];
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(void)keyShown:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    float keyboardHeight = keyboardFrameBeginRect.size.height;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGRect rect = [selectedTextField superview].frame;
    float offset = keyboardHeight - (height - rect.origin.y - rect.size.height) + 50;
    
    [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
}



#pragma mark - validate email
- (BOOL) validateEmail: (NSString *) candidate {
    
    if([[candidate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] length] == 0)
        return YES;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
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
