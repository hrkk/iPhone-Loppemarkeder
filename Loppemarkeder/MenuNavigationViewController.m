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
    int b =0;
    sscanf([customYellow UTF8String],"%x",&b);
    UIColor* btnColor = UIColorFromRGB(b);
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                               btnColor,UITextAttributeTextColor,
                                nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
       
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    [self.activityIndicatorView startAnimating];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.roninit.dk/LoppemarkederAdminApp/markedItem/listJSON"];
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

- (IBAction)alleMarkeder:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:NO];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
