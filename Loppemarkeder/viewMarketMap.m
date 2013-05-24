#import "ViewMarketMap.h"
#import "DetailViewController.h"

#import "SFAnnotation.h"        // annotation for the city of San Francisco
#import "BridgeAnnotation.h"    // annotation for the Golden Gate bridge

#import "CustomMapItem.h"
#import "CustomAnnotationView.h"
#import "AppDataCache.h"

typedef enum AnnotationIndex : NSUInteger
{
    kCityAnnotationIndex = 0,
    kBridgeAnnotationIndex,
    kTeaGardenAnnotationIndex
} AnnotationIndex;

#pragma mark -

#define kSimulatorLat			55.766338
#define kSimulatorlong			12.496262

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
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	// Create an instance of CLLocation
	
	location=[locationManager location];
    
#if TARGET_IPHONE_SIMULATOR
	location = [[CLLocation alloc] initWithLatitude:kSimulatorLat longitude:kSimulatorlong];
	
#endif
	
	// Set Center Coordinates of MapView
	self.mapView .centerCoordinate=CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
		
	// Setting Zoom Level on MapView
	
	MKCoordinateRegion coordinateRegion;
	
	coordinateRegion.center = self.mapView .centerCoordinate;
	coordinateRegion.span.latitudeDelta = 1;
	coordinateRegion.span.longitudeDelta = 1;
	
	[self.mapView  setRegion:coordinateRegion animated:YES];
	
    // Show userLocation (Blue Circle)	
	self.mapView.showsUserLocation=YES;
	
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
	for(MarketPlace *tmpMarket in [AppDataCache shared].marketList){
		tmpMarket.selectedInList = NO;
	}	
}

- (void)viewDidLoad
{
    // create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Tilbage";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
    // create out annotations array (in this example only 3)
    self.mapAnnotations = [[NSMutableArray alloc] init];
    [self.mapAnnotations addObjectsFromArray:[AppDataCache shared].marketList];
	[self gotoLocation];
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
    //id <MKAnnotation> annotation = [view annotation];
     
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
			if (marketTmp.selectedInList) {
				NSLog(@"%@", marketTmp);
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
//    else if ([annotation isKindOfClass:[SFAnnotation class]])   // for City of San Francisco
//    {
//        static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
//        
//        MKAnnotationView *flagAnnotationView =
//		[self.mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
//        if (flagAnnotationView == nil)
//        {
//            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//																			reuseIdentifier:SFAnnotationIdentifier];
//            annotationView.canShowCallout = YES;
//			
//            UIImage *flagImage = [UIImage imageNamed:@"flag.png"];
//            
//            // size the flag down to the appropriate size
//            CGRect resizeRect;
//            resizeRect.size = flagImage.size;
//            CGSize maxSize = CGRectInset(self.view.bounds,
//                                         [ViewMarketMap annotationPadding],
//                                         [ViewMarketMap annotationPadding]).size;
//            maxSize.height -= self.navigationController.navigationBar.frame.size.height + [ViewMarketMap calloutHeight];
//            if (resizeRect.size.width > maxSize.width)
//                resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
//            if (resizeRect.size.height > maxSize.height)
//                resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
//            
//            resizeRect.origin = CGPointMake(0.0, 0.0);
//            UIGraphicsBeginImageContext(resizeRect.size);
//            [flagImage drawInRect:resizeRect];
//            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            
//            annotationView.image = resizedImage;
//            annotationView.opaque = NO;
//			
//            UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFIcon.png"]];
//            annotationView.leftCalloutAccessoryView = sfIconView;
//            
//            // offset the flag annotation so that the flag pole rests on the map coordinate
//            annotationView.centerOffset = CGPointMake( annotationView.centerOffset.x + annotationView.image.size.width/2, annotationView.centerOffset.y - annotationView.image.size.height/2 );
//            
//            return annotationView;
//        }
//        else
//        {
//            flagAnnotationView.annotation = annotation;
//        }
//        return flagAnnotationView;
//    }
//    else if ([annotation isKindOfClass:[CustomMapItem class]])  // for Japanese Tea Garden
//    {
//        static NSString *TeaGardenAnnotationIdentifier = @"TeaGardenAnnotationIdentifier";
//        
//        CustomAnnotationView *annotationView =
//        (CustomAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:TeaGardenAnnotationIdentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:TeaGardenAnnotationIdentifier];
//        }
//        return annotationView;
//    }
    
    return nil;
}

@end
