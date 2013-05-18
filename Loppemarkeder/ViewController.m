
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//
#import "ViewController.h"
#import "AFNetworking.h"
#import "ViewMarketMap.h"
#import "Utilities.h"
#import "MarketPlace.h"
#import "AppDataCache.h"
#import "DetailViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


@implementation ViewController

@synthesize tableView = _tableView, activityIndicatorView = _activityIndicatorView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Tilbage";
    
    
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	
//	UINavigationBar *bar = [self.navigationController navigationBar];
//    
//    NSString *blue = @"FFCD05";
//    int b =0;
//    sscanf([blue UTF8String],"%x",&b);
//    UIColor* btnColor = UIColorFromRGB(b);
//    
//	[bar setTintColor:btnColor];
//    
	self.title = @"Loppemarked liste";
    

    // Setting Up Table View
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.hidden = YES;
   
	
	
   
       [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
	
	_sortByAfstandButton.titleLabel.textColor = [UIColor blackColor];
	_sortByDatoButton.titleLabel.textColor = [UIColor darkGrayColor];
	_sortByNameButton.titleLabel.textColor = [UIColor darkGrayColor];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:NO];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

// Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([AppDataCache shared].marketList && [AppDataCache shared].marketList.count)
	{
        return [AppDataCache shared].marketList.count;
    }
	else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    MarketPlace *marketplace = [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
	NSLog(@"%@",marketplace);
    cell.textLabel.text =marketplace.name;
    cell.detailTextLabel.text = marketplace.markedInformation;
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	ViewMarketMap *marketMap = [[ViewMarketMap alloc]initWithNibName:@"MapViewController" bundle:nil];
//	
    MarketPlace *tmpMarket = [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
//	for(MarketPlace *tmp in [AppDataCache shared].marketList){
//		if (tmp.marketID == tmpMarket.marketID ) {
//			tmp.selectedInList = YES;
//		}
//	}	
//	marketMap.marketplace = tmpMarket;
//	//[self.navigationController pushViewController:marketMap animated:YES];
    
    self.detailViewController.marketplace = tmpMarket;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (IBAction)sortByDato:(id)sender
{
	_sortByAfstandButton.titleLabel.textColor = [UIColor darkGrayColor];
	_sortByDatoButton.titleLabel.textColor = [UIColor blackColor];
	_sortByNameButton.titleLabel.textColor = [UIColor darkGrayColor];
}

- (IBAction)sortByName:(id)sender
{
    [AppDataCache shared].marketList = [Utilities sortArrayByName:[AppDataCache shared].marketList];
	[self.tableView reloadData];
	
	_sortByAfstandButton.titleLabel.textColor = [UIColor darkGrayColor];
	_sortByDatoButton.titleLabel.textColor = [UIColor darkGrayColor];
	_sortByNameButton.titleLabel.textColor = [UIColor blackColor];
	
}

- (IBAction)sortByAfstand:(id)sender
{
	[AppDataCache shared].marketList = [Utilities sortArrayByDistance:[AppDataCache shared].marketList];
	[self.tableView reloadData];
	
	_sortByAfstandButton.titleLabel.textColor = [UIColor blackColor];
	_sortByDatoButton.titleLabel.textColor = [UIColor darkGrayColor];
	_sortByNameButton.titleLabel.textColor = [UIColor darkGrayColor];
}

@end