//
//  MainMenuViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 31/05/2018.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",@"viewWillAppear");
    BOOL reload = [AppDataCache shared].reload;
    NSLog(@"%hhd",reload);
    if(reload) {
         [AppDataCache shared].reload = false;
         [self loadFeed];
        
        locationManager=[[CLLocationManager alloc] init];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            // Use one or the other, not both. Depending on what you put in info.plist
            [locationManager requestWhenInUseAuthorization];
        }
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
        [AppDataCache shared].marketList = [Utilities loadFromJson:[JSON objectForKey:@"list"]];
        NSLog(@"%@",[AppDataCache shared].marketList);
        [self.activityIndicatorView stopAnimating];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    // Handle location updates
    NSLog(@"MainMenuViewController oldLocation latitude %f",oldLocation.coordinate.latitude);
    NSLog(@"MainMenuViewController oldLocation longitude %f",oldLocation.coordinate.longitude);
    
    NSLog(@"MainMenuViewController newLocation latitude %f",newLocation.coordinate.latitude);
    NSLog(@"MainMenuViewController newLocation longitude %f",newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
}

@end
