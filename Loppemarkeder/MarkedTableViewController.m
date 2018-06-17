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
#import "Utilities.h"

@interface MarkedTableViewController ()

@end

@implementation MarkedTableViewController

@synthesize currentSort;
@synthesize vcMarketList;

- (void)viewDidLoad {
    [super viewDidLoad];
    currentSort = @"sortByDato";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self sorterBySelection];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([@"sortByAfstand" isEqualToString:currentSort] && vcMarketList.count) {
        return vcMarketList.count;
    } else if ([AppDataCache shared].marketList && [AppDataCache shared].marketList.count) {
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
        if ([@"sortByAfstand" isEqualToString:currentSort]) {
           dest.marketplace = [vcMarketList objectAtIndex:indexPath.row];
        } else {
            dest.marketplace = [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
        }
    }
}

- (IBAction)sortByDato:(id)sender {
    currentSort = @"sortByDato";
    [self sorterBySelection];
}
- (IBAction)sortByName:(id)sender {
    currentSort = @"sortByName";
    [self sorterBySelection];
}

- (IBAction)sortByAfstand:(id)sender {
    currentSort = @"sortByAfstand";
    [self sorterBySelection];
}


-(void)sorterBySelection {
    [_sortByNameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sortByDatoButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sortByAfstandButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    NSLog(@"currentSort: %@",currentSort);
    if ([@"sortByDato" isEqualToString:currentSort]) {
        [AppDataCache shared].marketList = [Utilities sortArrayByDate:[AppDataCache shared].marketList];
        [_sortByDatoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      
    } else if ([@"sortByName" isEqualToString:currentSort]) {
        [AppDataCache shared].marketList = [Utilities sortArrayByName:[AppDataCache shared].marketList];
        [_sortByNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else if ([@"sortByAfstand" isEqualToString:currentSort]) {
        NSArray *allMarketList = [AppDataCache shared].marketList;
        [AppDataCache shared].marketList = [self unikkeForekomsterArray];
       
        // sætter listen igen med alle markederne
        [AppDataCache shared].marketList = allMarketList;
        [_sortByAfstandButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
     [self.tableView reloadData];
}

// Hvis der er flere loppemarkeder med samme navn skal kun 1 vises og kun den som er den kommende (udfra fromDate)
// Endvidere skal der via et billed angives at der er flere forekomster på samme lokation
-(NSArray*)unikkeForekomsterArray
{
    //Sorter efter distance
    [AppDataCache shared].marketList = [Utilities sortArrayByDistance:[AppDataCache shared].marketList];
    
    NSMutableArray *array = [[AppDataCache shared].marketList mutableCopy];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    for(MarketPlace *tmp in [AppDataCache shared].marketList)
    {
        int antal = 0;
        for(int i=0;i<[array count];i++)
        {
            MarketPlace *tmp2 =[array objectAtIndex:i];
            if ([tmp.name isEqualToString:tmp2.name])
            {
                // NSLog(@"tmp with name %@ is equal to %@",tmp.name, tmp2.name);
                antal +=1;
                
                // build a new list
                if(antal == 1) {
                    if(![dict objectForKey:tmp.name]) {
                        [dict setValue:tmp forKey:tmp.name];
                        // NSLog(@"destinctDistanceArray adding %@ with distance %f",tmp.name, tmp.distance);
                    }
                }
                
            }
        }
    }
    
    // build a new list
    NSMutableArray *arrayOfVariables = [NSMutableArray arrayWithArray:[dict allValues]];
    
    vcMarketList = [Utilities sortArrayByDistance:[NSArray arrayWithArray:arrayOfVariables]];
    
    return vcMarketList;
    
}
@end
