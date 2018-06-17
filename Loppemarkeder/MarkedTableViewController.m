//
//  MarkedTableViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 10/06/2018.
//

#import "MarkedTableViewController.h"
#import "AppDataCache.h"
#import "MarketPlace.h"
#import "Detail.h"

@interface MarkedTableViewController ()

@end

@implementation MarkedTableViewController

@synthesize currentSort;
@synthesize vcMarketList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([@"sortByAfstand" isEqualToString:currentSort] && vcMarketList.count) {
        return vcMarketList.count;
        
    } else if ([AppDataCache shared].marketList && [AppDataCache shared].marketList.count)
    {
        return [AppDataCache shared].marketList.count;
    }
    else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    MarketPlace *marketplace = nil;
    if ([@"sortByAfstand" isEqualToString:currentSort]) {
        marketplace = [vcMarketList objectAtIndex:indexPath.row];
    } else {
        marketplace = [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
    }
    NSLog(@"%@",marketplace);
    
    cell.textLabel.text =marketplace.name;
    cell.detailTextLabel.text = marketplace.getFormattedDate;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",@"canEditRowAtIndexPath");
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",@"didSelectRowAtIndexPath");
    [self performSegueWithIdentifier:@"showRemedy" sender:tableView];
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showRemedy"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"prepareForSegue  %@ indexPath: %ld section; %ld", segue.identifier, (long)indexPath.row, (long)indexPath.section);
    
 
    UINavigationController *navigationController = segue.destinationViewController;
    Detail *dest = (Detail * )navigationController;
    MarketPlace *marketplace =  [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
    dest.marketplace = marketplace;
   // RemedyItem *remedyItem;
    /*
    if(sender == self.searchDisplayController.searchResultsTableView) {
        remedyItem = [filteredRemedyList objectAtIndex:indexPath.row];
    } else {
        remedyItem = [remedyList objectAtIndex:indexPath.row];
    }
    dest.remedyItem = remedyItem;
  */
    }
}


@end
