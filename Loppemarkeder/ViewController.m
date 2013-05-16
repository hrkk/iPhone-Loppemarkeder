
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

@implementation ViewController

@synthesize tableView = _tableView, activityIndicatorView = _activityIndicatorView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Tilbage";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	
	UINavigationBar *bar = [self.navigationController navigationBar];
	[bar setTintColor:[UIColor orangeColor]];
	self.title = @"Loppemarked liste";

    // Setting Up Table View
   
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.hidden = YES;
   
	
	[self.view addSubview:_buttonSubView];
	
	
   
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.roninit.dk/LoppemarkederAdminApp/markedItem/listJSONiPhone"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		NSLog(@"%@",JSON);
		[AppDataCache shared].marketList = [Utilities loadFromJson:[JSON objectForKey:@"markedItemInstanceList"]];
		NSLog(@"%@",[AppDataCache shared].marketList);
        [self.activityIndicatorView stopAnimating];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
	
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
	ViewMarketMap *marketMap = [[ViewMarketMap alloc]initWithNibName:@"MapViewController" bundle:nil];
	
	MarketPlace *tmpMarket = [[AppDataCache shared].marketList objectAtIndex:indexPath.row];
	for(MarketPlace *tmp in [AppDataCache shared].marketList){
		if (tmp.marketID == tmpMarket.marketID ) {
			tmpMarket.selectedInList = YES;
		}
	}
	
	marketMap.marketplace = tmpMarket;
	[self.navigationController pushViewController:marketMap animated:YES];	
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