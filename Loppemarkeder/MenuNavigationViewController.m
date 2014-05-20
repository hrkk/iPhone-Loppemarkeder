//
//  MenuNavigationViewController.m
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/14/13.
//
//

#import "MenuNavigationViewController.h"
#import "ViewController.h"
#import "AppDataCache.h"
#import "AboutLoppeMarkedViewController.h"
#import "OpretMarkedViewController.h"
#import "AFNetworking.h"
#import "ViewMarketMap.h"
#import "Utilities.h"
#import "MarketPlace.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


@interface MenuNavigationViewController ()

@end

@implementation MenuNavigationViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
    BOOL reload = [AppDataCache shared].reload;
    NSLog(@"%hhd",reload);
    if(reload) {
        [AppDataCache shared].reload = false;
        [self loadFeed];
        
        locationManager=[[CLLocationManager alloc] init];
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
}

-(void)loadFeed {
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    NSURL *url = [[NSURL alloc] initWithString:FEED_URL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		NSLog(@"%@",JSON);
		[AppDataCache shared].marketList = [Utilities loadFromJson:[JSON objectForKey:@"markedItemInstanceList"]];
		NSLog(@"%@",[AppDataCache shared].marketList);
        [self.activityIndicatorView stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	
    temporaryBarButtonItem.title = @"Tilbage";
    temporaryBarButtonItem.tintColor = [UIColor blackColor];
    
    NSString *customYellow = @"FFCD05";
    // ios sætter backBtn text til sort
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        customYellow = @"000000";
    }
    int b =0;
    sscanf([customYellow UTF8String],"%x",&b);
    UIColor* btnColor = UIColorFromRGB(b);
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                               btnColor,UITextAttributeTextColor,
                                nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
    
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    // adds info button
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [button addTarget:self
               action:@selector(omApp)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
     if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
          button.frame = CGRectMake(280, 6.0, 30.0, 60.0);
     } else {
         button.frame = CGRectMake(280, 6.0, 30.0, 30.0);
     }
    [button setTintColor:[UIColor blackColor]];
    [self.view addSubview:button];
    [self loadFeed];
}

-(void)omApp {
    [self.navigationController pushViewController:self.aboutAppViewController animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    // Handle location updates
    NSLog(@"MenuNavigationViewController oldLocation latitude %f",oldLocation.coordinate.latitude);
    NSLog(@"MenuNavigationViewController oldLocation longitude %f",oldLocation.coordinate.longitude);
    
    NSLog(@"MenuNavigationViewController newLocation latitude %f",newLocation.coordinate.latitude);
    NSLog(@"MenuNavigationViewController newLocation longitude %f",newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];

}

- (IBAction)alleMarkeder:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)nearBy:(id)sender
{
	ViewMarketMap *marketMap = [[ViewMarketMap alloc]initWithNibName:@"MapViewController" bundle:nil];
	
	[self.navigationController pushViewController:marketMap animated:YES];
}

- (IBAction)omMarkeder:(id)sender
{
	  [self.navigationController pushViewController:self.aboutLoppeMarkedViewController animated:YES];
}

- (IBAction)omApp:(id)sender
{
    [self.navigationController pushViewController:self.aboutAppViewController animated:YES];

}

- (IBAction)opretMarked:(id)sender
{
    [self.navigationController pushViewController:self.opretMarkedViewController animated:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
