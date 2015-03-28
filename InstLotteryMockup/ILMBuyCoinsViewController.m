//
//  ILMBuyCoinsViewController.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/25/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMBuyCoinsViewController.h"

@interface ILMBuyCoinsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numCoinsTextField;
@property (weak, nonatomic) IBOutlet UISlider *numCoinsSlider;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ILMBuyCoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addDoneButtonToNumericPad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addDoneButtonToNumericPad
{
    UIToolbar *numericPadDoneButtonView = [[UIToolbar alloc] init];
    [numericPadDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [numericPadDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace, doneButton, nil]];
    self.numCoinsTextField.inputAccessoryView = numericPadDoneButtonView;
}

- (void)doneClicked
{
    [self.view endEditing:YES];
}

- (IBAction)numberCoinsChangedFromText:(id)sender {
    int val = [self numCoinsTextFieldAsInt];
    [self.numCoinsSlider setValue:val animated:NO];
    [self.priceTextField setText:[NSString stringWithFormat:@"$%.2f", val * 0.99f]];
}

- (IBAction)numberCoinsChangedFromSlider:(id)sender {
    int val = round(self.numCoinsSlider.value);
    [self.numCoinsTextField setText:[NSString stringWithFormat:@"%d", val]];
    [self.priceTextField setText:[NSString stringWithFormat:@"$%.2f", val * 0.99f]];
}

- (int)numCoinsTextFieldAsInt
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *val = [formatter numberFromString:self.numCoinsTextField.text];
    int intVal = 1;
    if (val)
    {
        intVal = [val intValue];
        if (intVal < 1)
        {
            intVal = 1;
        } else if (intVal > 100)
        {
            intVal = 100;
        }
    }
    return intVal;
}

- (IBAction)purchaseTapped:(id)sender {
    [self.activityIndicator startAnimating];
    self.scrollView.userInteractionEnabled = NO;
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    self.scrollView.alpha = 0.3f;
    self.navigationController.navigationBar.alpha = 0.3f;
    ILMInstagram *instagram = [ILMInstagram sharedInstagram];
    instagram.purchaseCoinsDelegate = self;
    [instagram purchaseCoins:[self numCoinsTextFieldAsInt]];
}

- (void)purchaseCompleteWithSuccess:(BOOL)success
{
    if (success)
    {
        [self.activityIndicator stopAnimating];
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        self.navigationController.navigationBar.alpha = 1.0f;
        [self.delegate profileNeedsRefresh];
        [self.navigationController popToViewController:(UIViewController *)self.delegate animated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to Purchase" message:@"Unable to purchase coins. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
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
