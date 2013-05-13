
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "ViewController.h"

#import "AFNetworking.h"
#import "ViewMarketMap.h"
#import "Utilities.h"

@implementation ViewController

@synthesize tableView = _tableView, activityIndicatorView = _activityIndicatorView, marketItemsArray = _marketItemsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setting Up Table View
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 50, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    // Initializing Data Source
    self.marketItemsArray = [[NSArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://roninit.dk/LoppemarkederAdminApp/markedItem/listJSON"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		NSLog(@"%@",JSON);
		//self.marketItemsArray = [Utilities loadFromJson:[JSON objectForKey:@"markedItemInstanceList"]];
		self.marketItemsArray =[JSON objectForKey:@"markedItemInstanceList"];
		
        [self.activityIndicatorView stopAnimating];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

// Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.marketItemsArray && self.marketItemsArray.count) {
        return self.marketItemsArray.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDictionary *marketplace = [self.marketItemsArray objectAtIndex:indexPath.row];
	NSLog(@"%@",marketplace);
    cell.textLabel.text = [marketplace objectForKey:@"address"];
    cell.detailTextLabel.text = [marketplace objectForKey:@"dateExtraInfo"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
	ViewMarketMap *marketMap = [[ViewMarketMap alloc]initWithNibName:@"viewMarketMap" bundle:nil];
	//marketMap.nykNewsFeed = [self.mitNykreditNewsFeed objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:marketMap animated:YES];
}

@end