

#import "SplashViewController.h"


@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initViews
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float buttonHeight = screenSize.height * 53 / 667.0;
    
    self.btnExercises.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnExercises.layer.borderWidth = 1.0f;
    self.btnExercises.layer.cornerRadius = buttonHeight / 4.0f;
    
    self.btnBMI.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnBMI.layer.borderWidth = 1.0f;
    self.btnBMI.layer.cornerRadius = buttonHeight / 4.0f;
    
    
    self.btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnLogin.layer.borderWidth = 1.0f;
    self.btnLogin.layer.cornerRadius = buttonHeight / 2.0f;
    
    self.btnSignUp.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnSignUp.layer.borderWidth = 1.0f;
    self.btnSignUp.layer.cornerRadius = buttonHeight / 2.0f;
    
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
