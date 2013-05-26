
#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDateFormatter *dateFormatx = [[NSDateFormatter alloc]init];
    [dateFormatx setDateFormat:@"yyyy-MM-dd"];
    self.title = _marketplace.name;
    _addressLabel.text = _marketplace.address1;

    _dateLabel.text = _marketplace.getFormattedDate;
    _entranceLabel.text = _marketplace.entreInfo;
    _rulesLabel.text = _marketplace.markedRules;
    _marketInfo.text = _marketplace.markedInformation;
    NSLog(@"DetailViewController %@",_marketplace);
    
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	// Create an instance of CLLocation
	location=[locationManager location];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
#endif

- (IBAction)showRoute:(id)sender {
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    float ver_float = [ver floatValue];
    CLLocationCoordinate2D startCoordinate = location.coordinate;
    
    NSString *theUrl;
    
    if(ver_float < 6.0) {
        theUrl = [[NSString stringWithFormat:@"maps:maps.google.com/maps?f=d&saddr=%f,%f&daddr=%f,%f",startCoordinate.latitude,startCoordinate.longitude,_marketplace.currentLocation.coordinate.latitude,_marketplace.currentLocation.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",theUrl);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];       
        
    }
    else {
        CLLocationCoordinate2D endingCoord = CLLocationCoordinate2DMake(_marketplace.currentLocation.coordinate.latitude,_marketplace.currentLocation.coordinate.longitude);
        MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:endingCoord addressDictionary:nil];
        MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
        
        NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
        [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
        
        [endingItem openInMapsWithLaunchOptions:launchOptions];
    }
}
@end
