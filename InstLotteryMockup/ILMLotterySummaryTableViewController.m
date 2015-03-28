//
//  ILMLotterySummaryTableViewController.m
//  InstLotteryMockup
//
//  Created by Samuel Seng on 3/27/15.
//  Copyright (c) 2015 Samuel Seng. All rights reserved.
//

#import "ILMLotterySummaryTableViewController.h"
#import "ILMLotterySummaryTableViewCell.h"

@interface ILMLotterySummaryTableViewController ()

@end

@implementation ILMLotterySummaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFollowersMode = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"ILMLotterySummaryTableViewCell" bundle:nil] forCellReuseIdentifier:@"ILMLotterySummaryTableViewCell"];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.layer.cornerRadius = 10.0f;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setIsFollowersMode:(BOOL)isFollowersMode
{
    if (_isFollowersMode != isFollowersMode) {
        _isFollowersMode = isFollowersMode;
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILMLotterySummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ILMLotterySummaryTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.isFollowersMode) {
        [cell setCellTitle:@"100 Followers - Fashion" subTitle:@"1 Ticket" fraction:[NSNumber numberWithFloat:0.5]];
    } else {
        [cell setCellTitle:@"20 Likes - Profile Picture" subTitle:@"5 Tickets" fraction:[NSNumber numberWithFloat:0.2]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILMLotterySummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ILMLotterySummaryTableViewCell"];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ILMLotterySummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ILMLotterySummaryTableViewCell"];
    return cell.frame.size.height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
