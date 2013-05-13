//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "ViewMarketMap.h"
#import "MarketPlace.h"
#import "AnnotationView.h"

@implementation ViewMarketMap
@synthesize marketsArray;

- (void)viewDidLoad {
	[super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setmarketsArray:(NSMutableArray *)dataArray{
	NSArray *ann = [myMapView annotations];
	if(ann != nil)
		[myMapView removeAnnotations:ann];
	if (dataArray != marketsArray) {
		marketsArray = dataArray;
	}
	
	CLLocation *cur = [MyCLController sharedInstance].theLocation;
	for(MarketPlace *eachSRPengeAutomat in marketsArray){
		eachSRPengeAutomat.distance = [cur distanceFromLocation:eachSRPengeAutomat.currentLocation];
	}
	if([marketsArray count]>1){
		[myMapView addAnnotations:marketsArray];
		myMapView.centerCoordinate = ((MarketPlace*)[marketsArray objectAtIndex:1]).coordinate;
		myMapView.region = MKCoordinateRegionMake(((MarketPlace*)[marketsArray objectAtIndex:1]).coordinate, MKCoordinateSpanMake(.009, 0.009));
	}
	else{
		myMapView.centerCoordinate = [MyCLController sharedInstance].theLocation.coordinate;
		myMapView.region = MKCoordinateRegionMake([MyCLController sharedInstance].theLocation.coordinate, MKCoordinateSpanMake(.009, 0.009));
		if([marketsArray count] > 0)
			[myMapView addAnnotations:marketsArray];
		
	}
	myMapView.delegate = self;
	
	

    
	myMapView.showsUserLocation = YES;
}


#pragma mark -
#pragma mark MyCLController delegates
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
	if(![annotation isKindOfClass:[MarketPlace class]])
		return nil;
	annotationView = (AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:((MarketPlace *) annotation).name];
	if(annotationView == nil) {
		annotationView = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:((MarketPlace *) annotation).name];//@"priceView"];
		annotationView.frame = CGRectMake(0,0, 50,50);
		annotationView.canShowCallout =YES;
	}
	
	[annotationView setEnabled:YES];
	return annotationView;
}

#pragma mark -
#pragma mark location methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	MKCoordinateRegion region;
	region.center=newLocation.coordinate;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	
	span.latitudeDelta=.002;
	span.longitudeDelta=.002;
	region.span = span;
	
	[myMapView setRegion:region animated:TRUE];
	[myMapView regionThatFits:region];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

- (void)didUpdateHeading:(CLHeading *)newHeading
{	
}

- (void)newLocationUpdate:(CLLocation *)location
{	
}


@end
