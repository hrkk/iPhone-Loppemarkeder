//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "MyCLController.h"

@implementation MyCLController

@synthesize delegate, locationManager,theLocation,receivedData,locationAsText,positiondelegate;

@synthesize theConnection;

- (id) init {
	self = [super init];
	if (self != nil) {
		startedLocationLookup = NO;
		locationAvailable = NO;
		self.theLocation = nil;
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self; // Tells the location manager to send updates to this object
	}
	return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	[self.delegate didUpdateHeading:newHeading.magneticHeading];
}

// Called when the location is updated
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
	// Horizontal coordinates
	if (signbit(newLocation.horizontalAccuracy)){
		return;//[update appendString:LocStr(@"LatLongUnavailable")];
	}
	
	NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSinceDate:newLocation.timestamp ];
	if(abs(timeElapsed)>20)  {
			//		[self.locationManager stopUpdatingLocation];
			//		[self.locationManager startUpdatingLocation];
		return;
	} // latest update more than 20 second old - get new
	

	self.theLocation = newLocation;
	if (self.positiondelegate != nil)
		[self.positiondelegate doPostionReleatedMethods:newLocation];

	
	[self.delegate newLocationUpdate:newLocation];
}


// Called when there is an error getting the location
- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSMutableString *errorString = [[NSMutableString alloc] init];

	if ([error domain] == kCLErrorDomain) {

		// We handle CoreLocation-related errors here

		switch ([error code]) {
			// This error code is usually returned whenever user taps "Don't Allow" in response to
			// being told your app wants to access the current location. Once this happens, you cannot
			// attempt to get the location again until the app has quit and relaunched.
			//
			// "Don't Allow" on two successive app launches is the same as saying "never allow". The user
			// can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
			//
			case kCLErrorDenied:
				[errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationDenied", nil)];
				break;

			// This error code is usually returned whenever the device has no data or WiFi connectivity,
			// or when the location cannot be determined for some other reason.
			//
			// CoreLocation will keep trying, so you can keep waiting, or prompt the user.
			//
			case kCLErrorLocationUnknown:
				[errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationUnknown", nil)];
				break;

			// We shouldn't ever get an unknown error code, but just in case...
			//
			default:
				[errorString appendFormat:@"%@ %d\n", NSLocalizedString(@"GenericLocationError", nil), [error code]];
				break;
		}
	} else {
		// We handle all non-CoreLocation errors here
		// (we depend on localizedDescription for localization)
		[errorString appendFormat:@"Error domain: \"%@\"  Error code: %d\n", [error domain], [error code]];
		[errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
	}
	if (self.positiondelegate != nil) // this way rekalme still works
		[self.positiondelegate doPostionReleatedMethods:nil];

	// Send the update to our delegate
	//	if([delegate respondsToSelector:@selector(newError:)])
	//[self.delegate newError:errorString];
	//
	//   NO location found setting it to studeistræde
	
	self.theLocation = nil;//[[CLLocation alloc] initWithLatitude:55.678713 longitude:12.569942];
	
}

#pragma mark ---- singleton object methods ----

// See "Creating a Singleton Instance" in the Cocoa Fundamentals Guide for more info

static MyCLController *sharedInstance = nil;

+ (MyCLController *)sharedInstance
{

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    	sharedInstance = [MyCLController new];
		// Do any other initialisation stuff here, do not implement init
	});
	return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
	if (sharedInstance == nil)
		sharedInstance = [super allocWithZone:zone];
	return sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone { return self; }

//- (id)retain {
//	[super retain];
//    return self;
//}
//
//- (unsigned)retainCount {
//    return UINT_MAX;  // denotes an object that cannot be released
//}
//
//- (id)autorelease {
//    return self;
//}

#pragma mark -
#pragma mark <NSURLConnection> Methods

// create the request

- (void)loadLocationAsText {
	if(startedLocationLookup)
		return;
	startedLocationLookup=YES;
	
	NSString *url =[NSString stringWithFormat:@"http://ws.geonames.org/findNearby?lat=%f&lng=%f&featureClass=P&featureCode=PPLA&featureCode=PPL&featureCode=PPLC",theLocation.coordinate.latitude,theLocation.coordinate.longitude];

	NSURL *theurl = [NSURL URLWithString:url];
	
//	[[MyCLController sharedInstance].locationManager stopUpdatingLocation];
	
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:theurl
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	self.theConnection = connection;

	if (theConnection) {
		self.receivedData=[NSMutableData data];
	} else {
		// inform the user that the download could not be made
	}
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	
	/*	NSDictionary *eachElement;
	 NSString *thePath = [[NSBundle mainBundle]  pathForResource:@"Service" ofType:@"plist"];
	 
	 NSArray *rawElementsArray = [[NSArray alloc] initWithContentsOfFile:thePath];
	 // iterate over the values in the raw elements dictionary
	 for (eachElement in rawElementsArray)
	 {
	 // create an atomic element instance for each
	 WatchWrapper *anElement = [[WatchWrapper alloc] initWithDictionary:eachElement];
	 [self.monitoredStations addObject:anElement];
	 [anElement release];
	 
	 }
	 // release the raw element data
	 [rawElementsArray release];
	 */
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSXMLParser *currentLocationXML = [[NSXMLParser alloc] initWithData:self.receivedData];
	[currentLocationXML setDelegate:self];
	[currentLocationXML parse];
	return;
	
}

#pragma mark -
#pragma mark NSXMLParser delegates

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if(!self.locationAsText)
		self.locationAsText = [[NSMutableString alloc] initWithString:@"kunne ikke bestemmes"];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ( [elementName isEqualToString:@"name"] ) {
		foundLocation=YES;
	}
	else foundLocation=NO;
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if(foundLocation) {
		if (!self.locationAsText) 
			self.locationAsText = [[NSMutableString alloc] initWithCapacity:50];
		if( [string caseInsensitiveCompare:self.locationAsText]==0 )
			return;
		NSRange subStrRange = [locationAsText rangeOfString:string];
		if (subStrRange.location == NSNotFound)
			[self.locationAsText appendString:string];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	[self.delegate textLocationUpdate:locationAsText];
}

@end
