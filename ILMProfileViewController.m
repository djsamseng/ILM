//
//  ILMProfileViewController.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/22/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMProfileViewController.h"
#import "ILMWebService.h"
#import "ILMBuyCoinsViewController.h"
#import "ILMLotterySummaryTableViewController.h"
#import "ILMInstagram.h"

@interface ILMProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *coinsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *followersLikesSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *lotterySummaryView;
@property (strong, nonatomic) ILMLotterySummaryTableViewController *summaryViewController;


@end

@implementation ILMProfileViewController


- (IBAction)buyCoinsTapped:(id)sender {
    [self performSegueWithIdentifier:@"BuyCoinsTappedSegue" sender:self];
}
- (IBAction)followersLikesSegmentedControlChanged:(id)sender {
    if (self.followersLikesSegmentedControl.selectedSegmentIndex == 0)
    {
        self.summaryViewController.isFollowersMode = YES;
    }
    else
    {
        self.summaryViewController.isFollowersMode = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ILMInstagram *sharedInstagram = [ILMInstagram sharedInstagram];
    sharedInstagram.delegate = self;
    [sharedInstagram loginInstagramUser];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)profileNeedsRefresh
{
    ILMInstagram *instagram = [ILMInstagram sharedInstagram];
    [self.followersLabel setText:[NSString stringWithFormat:@"%@ Followers", instagram.followers]];
    [self.followingLabel setText:[NSString stringWithFormat:@"%@ Following", instagram.following]];
    
    [self.userNameLabel setText:instagram.userName];
    [self.coinsLabel setText:[NSString stringWithFormat:@"%@ coins", [instagram.coins description]]];
    self.summaryViewController = [[ILMLotterySummaryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.summaryViewController.view.frame = self.lotterySummaryView.frame;
    //self.summaryViewController.tableView.layer.cornerRadius = 10.0f;
    [self.view addSubview:self.summaryViewController.view];
    [self loadProfilePicture];
    
}

- (void)loadProfilePicture
{
    ILMInstagram *instagram = [ILMInstagram sharedInstagram];
    ILMWebService *webService = [[ILMWebService alloc] init];
    webService.delegate = self;
    [webService request:instagram.profilePicture];
}

- (void)didReceiveResponse:(NSData *)response
{
    self.profilePicture.image = [UIImage imageWithData:response];
}

- (void)didReceiveURLResponse:(NSURLResponse *)response
{
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ILMBuyCoinsViewController class]])
    {
        ((ILMBuyCoinsViewController *)segue.destinationViewController).delegate = self;
    }
}


@end
