//
//  LoginViewController.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMLoginViewController.h"
#import "ILMLoginWebViewController.h"

@interface ILMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation ILMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginPressed:(id)sender {
    //if ([self validateLogin]) {
        ILMLoginWebViewController *lvc = [[ILMLoginWebViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    //}
}

- (BOOL)validateLogin {
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        return YES;
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
