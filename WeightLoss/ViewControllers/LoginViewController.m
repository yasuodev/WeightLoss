#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()
{
    UITextField *selectedTextField;
}
@end

@implementation LoginViewController
@synthesize openUrlID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initView];
    
    selectedTextField = self.txtUserID;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyShown:) name:UIKeyboardDidShowNotification object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.txtUserID.text = @"";
    self.txtPassword.text = @"";
    
    
}

-(void) initView {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [self.lblTitle setFont:[UIFont systemFontOfSize:24 * screenSize.height / 667.0f weight:0.2f]];
    
    // white placeholder
    NSDictionary * attributes = (NSMutableDictionary *)[ (NSAttributedString *)self.txtUserID.attributedPlaceholder attributesAtIndex:0 effectiveRange:NULL];

    NSMutableDictionary * newAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
    
    [newAttributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    // Set new text with extracted attributes
    self.txtUserID.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtUserID.attributedPlaceholder string] attributes:newAttributes];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.txtPassword.attributedPlaceholder string] attributes:newAttributes];
    
    self.viewUserID.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewUserID.layer.borderWidth = 1.0;
    self.viewUserID.layer.cornerRadius = 5.0f;
    
    self.viewPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    self.viewPassword.layer.borderWidth = 1.0;
    self.viewPassword.layer.cornerRadius = 5.0f;
    
    self.btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnLogin.layer.borderWidth = 1.0;
    self.btnLogin.layer.cornerRadius = 5.0f;
    
    
}

#pragma mark - button events

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onLogin:(id)sender {
    
    NSString *strUserID = self.txtUserID.text;
    NSString *strPassword = self.txtPassword.text;
    
    if ([strUserID isEqual:@""]) {
        [self showDefaultAlert:nil withMessage:@"Empty UserID"];
        return;
    }
    if ([strPassword isEqual:@""]) {
        [self showDefaultAlert:nil withMessage:@"Empty Password"];
        return;
    }
    
    [self login:strUserID password:strPassword];
}


#pragma mark - login with email and password
-(void) login:(NSString*)userid password:(NSString*)password
{
    NSString *savedUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
    NSString *savedPass = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    if ([userid isEqual:savedUserID] && [password isEqual:savedPass]) {
        MainViewController *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:mainVC animated:YES];
    } else {
        [self showDefaultAlert:nil withMessage:@"Login Failed"];
    }
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
        [self.txtPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self.scrollView setContentOffset:CGPointZero animated:YES];        
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
    float offset = keyboardHeight - (height - rect.origin.y - rect.size.height) + 100;
    
    [self.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
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
