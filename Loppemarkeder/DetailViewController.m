
#import "DetailViewController.h"

#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation DetailViewController {
    FBSDKShareButton *shareButton;
}

- (void)viewDidLoad
{
    // FB share
    
    NSURL *contentURL = [[NSURL alloc] initWithString: @"https://fb.me/943851492403349"];
  //  https://fb.me/943851492403349
  //  https://fb.me/308059602873236?mID=3
  //  http://itunes.apple.com/app/id662561579
   // contentURL.absoluteString = @"myApp://?mID=3";
   // http://itunes.apple.com/app/id662561579
    
   
    NSURL *imageURL =[NSURL URLWithString: @"http://www.roninit.dk/LoppemarkederAdminApp/image"];
   
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc ] init ];
    content.contentURL = contentURL;
    content.contentTitle =  _marketplace.name;
    content.contentDescription = _marketplace.linkDescription;
    content.imageURL = imageURL;
    shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    
  // shareButton.center = self.view.center;
    [self.view addSubview:shareButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = _marketplace.name;
    _addressLabel.text = _marketplace.address1;

    _dateLabel.text = _marketplace.getFormattedDateXtraInfo;
    _entranceLabel.text = _marketplace.entreInfo;
    _rulesLabel.text = _marketplace.markedRules;
    _marketInfo.text = _marketplace.markedInformation;
    NSLog(@"DetailViewController %@",_marketplace);
    locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	// Create an instance of CLLocation
	location=[locationManager location];
           
    [self adjustLabelsPosition];
    [self checkIfLinkShow];

}

// Vi skal check om man skal kunne booke
-(void)checkIfLinkShow
{
    _bookingHeadline.hidden = YES;
    _bookingTextViewInfo.hidden = YES;
    if (_marketplace.enableBooking) {
        _bookingHeadline.hidden = NO;
        _bookingTextViewInfo.hidden = NO;
    }
}

-(void)adjustLabelsPosition
{
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize;
    CGRect newFrame;
    
    //AdressInfo
    maximumLabelSize = CGSizeMake(185, FLT_MAX); // Være kortere da der ligger ruteknap
    expectedLabelSize = [_addressLabel.text sizeWithFont:_addressLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_addressLabel.lineBreakMode];
    newFrame = _addressLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    _addressLabel.frame = newFrame;
    
    maximumLabelSize = CGSizeMake(293, FLT_MAX);
    
    //Datoheadling
    newFrame = _dateHeadline.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = _addressLabel.frame.origin.y +   _addressLabel.frame.size.height + 5;
    _dateHeadline.frame = newFrame;

    //Datolabel
    expectedLabelSize = [_dateLabel.text sizeWithFont:_dateLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_dateLabel.lineBreakMode];
    newFrame = _dateLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = _dateHeadline.frame.origin.y +   _dateHeadline.frame.size.height;
    _dateLabel.frame = newFrame;
    
    //EntreHeadline
    newFrame = _entranceHeadline.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = _dateLabel.frame.origin.y +   _dateLabel.frame.size.height + 5;
    _entranceHeadline.frame = newFrame;
    
    //Entrelabel
    expectedLabelSize = [_entranceLabel.text sizeWithFont:_entranceLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_entranceLabel.lineBreakMode];
    newFrame = _entranceLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = _entranceHeadline.frame.origin.y +   _entranceHeadline.frame.size.height;
    _entranceLabel.frame = newFrame;

    //ReglerHeadling
    newFrame = _rulesHeadline.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = _entranceLabel.frame.origin.y +   _entranceLabel.frame.size.height + 5;
    _rulesHeadline.frame = newFrame;
    
    //ReglerLabel
    expectedLabelSize = [_rulesLabel.text sizeWithFont:_rulesLabel.font constrainedToSize:maximumLabelSize lineBreakMode:_rulesLabel.lineBreakMode];
    newFrame = _rulesLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = _rulesHeadline.frame.origin.y +   _rulesHeadline.frame.size.height;
    _rulesLabel.frame = newFrame;
    
    //MarketHeadling
    newFrame = _marketHeadline.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = _rulesLabel.frame.origin.y +   _rulesLabel.frame.size.height + 5;
    _marketHeadline.frame = newFrame;
    
    //Markedsinfomation
    expectedLabelSize = [_marketInfo.text sizeWithFont:_marketInfo.font constrainedToSize:maximumLabelSize lineBreakMode:_marketInfo.lineBreakMode];
    newFrame = _marketInfo.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = _marketHeadline.frame.origin.y +   _marketHeadline.frame.size.height;
    _marketInfo.frame = newFrame;
        
    //Bookingheadling
    newFrame = _bookingHeadline.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = _marketInfo.frame.origin.y +   _marketInfo.frame.size.height +10;
    _bookingHeadline.frame = newFrame;

    //BookingINfo
    newFrame = _bookingTextViewInfo.frame;
    newFrame.origin.x = 12;
    newFrame.origin.y = _bookingHeadline.frame.origin.y +   _bookingHeadline.frame.size.height -8;
    _bookingTextViewInfo.frame = newFrame;
    
    // FB
    shareButton.center = self.view.center;
    newFrame = shareButton.frame;
   // newFrame.origin.x = 12;
    if (_marketplace.enableBooking) {
        newFrame.origin.y = _bookingTextViewInfo.frame.origin.y +   _bookingTextViewInfo.frame.size.height;
    } else {
        newFrame.origin.y = _bookingTextViewInfo.frame.origin.y +   _bookingTextViewInfo.frame.size.height-40;
    }

    shareButton.frame = newFrame;
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
- (void)viewDidUnload {
    [self setBookingTextViewInfo:nil];
    [super viewDidUnload];
}
@end
