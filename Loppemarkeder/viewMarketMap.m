#import "ViewMarketMap.h"
#import "DetailViewController.h"

#import "CustomMapItem.h"
#import "CustomAnnotationView.h"
#import "AppDataCache.h"
#import "Utilities.h"

typedef enum AnnotationIndex : NSUInteger
{
    kCityAnnotationIndex = 0,
    kBridgeAnnotationIndex,
    kTeaGardenAnnotationIndex
} AnnotationIndex;

#pragma mark -

#define kSimulatorLat			55.766338
#define kSimulatorlong			12.496262

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@implementation ViewMarketMap

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}

+ (CGFloat)calloutHeight;
{
    return 40.0f;
}

- (void)gotoLocation
{
    
	locationManager=[[CLLocationManager alloc] init];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    // Create an instance of CLLocation
	
	location=[locationManager location];
    NSLog(@"MenuNavigationViewController location latitude %f",location.coordinate.latitude);
    NSLog(@"MenuNavigationViewController location longitude %f",location.coordinate.longitude);

    //#if TARGET_IPHONE_SIMULATOR
  //  	location = [[CLLocation alloc] initWithLatitude:kSimulatorLat longitude:kSimulatorlong];
    //#endif
	
	// Set Center Coordinates of MapView
	self.mapView.centerCoordinate=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
	// Setting Zoom Level on MapView
	
    //	MKCoordinateRegion coordinateRegion;
	
    //	coordinateRegion.center = self.mapView.centerCoordinate;
    //	coordinateRegion.span.latitudeDelta = 1;
    //	coordinateRegion.span.longitudeDelta = 1;
	
    //	[self.mapView setRegion:coordinateRegion animated:YES];
	
    // Show userLocation (Blue Circle)
	self.mapView.showsUserLocation=YES;
	
    MKCoordinateRegion region = {{0,0},{1.00,1.00}};
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    [self.mapView setRegion:region animated:YES];
    
    
	[self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
 	[self.mapView addAnnotations:self.mapAnnotations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	for(MarketPlace *tmpMarket in [AppDataCache shared].marketList)
    {
		tmpMarket.selectedInList = NO;
	}
}

- (void)viewDidLoad
{
    // this is used by the detailview, but the setup is done here
    
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
    self.title = @"I nærheden";
    

    // create out annotations array (in this example only 3)
    self.mapAnnotations = [[NSMutableArray alloc] init];
    
    // Hvis der er flere loppemarkeder med samme navn skal kun 1 vises og kun den som er den kommende (udfra fromDate)
    // Endvidere skal der via et billed angives at der er flere forekomster på samme lokation
    
    [self.mapAnnotations addObjectsFromArray:[self unikkeForekomsterArray]];
	[self gotoLocation];
}

// Hvis der er flere loppemarkeder med samme navn skal kun 1 vises og kun den som er den kommende (udfra fromDate)
// Endvidere skal der via et billed angives at der er flere forekomster på samme lokation
-(NSArray*)unikkeForekomsterArray
{
    //Sorter efter dato
    [AppDataCache shared].marketList = [Utilities sortArrayByDate:[AppDataCache shared].marketList];
    
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
                        NSLog(@"destinctArray adding %@",tmp.name);
                    }
                }
                
                if (antal > 1) { // Hvis mere end et loppemarkede med det navn
                    if([dict objectForKey:tmp.name]) {
                        tmp.selectedInList =YES;
                    }
                }         
            }
        }
    }
    
    // build a new list 
   NSMutableArray *arrayOfVariables = [NSMutableArray arrayWithArray:[dict allValues]];
   
    return [NSArray arrayWithArray:arrayOfVariables];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
#endif


#pragma mark - MKMapViewDelegate

// user tapped the disclosure button in the callout
//
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    id <MKAnnotation> annotation = [view annotation];
    MarketPlace *marketTmp = (MarketPlace *)annotation;
    self.detailViewController.marketplace = marketTmp;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
	// in case it's the user location, we already have an annotation, so just return nil
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    // handle our three custom annotations
    //
    if ([annotation isKindOfClass:[MarketPlace class]]) // for Golden Gate Bridge
    {
        // try to dequeue an existing pin view first
        static NSString *BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        
        MKPinAnnotationView *pinView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (pinView == nil)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]
												  initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
            MarketPlace *marketTmp = (MarketPlace *)annotation;
			if (marketTmp.selectedInList)
            {
				customPinView.pinColor = MKPinAnnotationColorGreen;
				customPinView.animatesDrop = YES;
				customPinView.canShowCallout = YES;
				
			}else
			{
				customPinView.pinColor = MKPinAnnotationColorPurple;
				customPinView.animatesDrop = YES;
				customPinView.canShowCallout = YES;
				
			}
			
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: when the detail disclosure button is tapped, we respond to it via:
            //       calloutAccessoryControlTapped delegate method
            //
            // by using "calloutAccessoryControlTapped", it's a convenient way to find out which annotation was tapped
            //
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    
    return nil;
}

@end
