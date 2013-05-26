 //
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "MarketPlace.h"


@implementation MarketPlace

@synthesize entreInfo,address1, fromDate, markedInformation, markedRules;
@synthesize name,subtitle,currentLocation;
@synthesize distance;
@synthesize toDate;
@synthesize dateXtraInfo;

- (id) initWithDictionary:(NSDictionary *) dict{
	if (self = [super init]) {
		self.address1 = [dict objectForKey:@"address"];		
		self.dateXtraInfo = [dict objectForKey:@"dateExtraInfo"];
		self.entreInfo = [dict objectForKey:@"entreInfo"];
		self.fromDate = [dict objectForKey:@"fromDate"];
		CGFloat latitude = [[dict objectForKey:@"latitude"] floatValue];
		CGFloat longitude = [[dict objectForKey:@"longitude"] floatValue];
		self.markedInformation = [dict objectForKey:@"markedInformation"];	
		self.markedRules = [dict objectForKey:@"markedRules"];
		self.name = [dict objectForKey:@"name"];		
		self.toDate = [dict objectForKey:@"toDate"];
		_marketID = [[dict objectForKey:@"id"] integerValue];
		self.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];		
	}
	return self;
}


-(NSString*)getFormattedDate {
    NSDate *fromDateDate;
    NSDate *toDateDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    // create date types from json string dates
    fromDateDate = [formatter dateFromString:fromDate];
    toDateDate = [formatter dateFromString:toDate];

    // change formatting format to the display format
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *formattedDateString = nil;
    
    if (toDate != nil && ![fromDate isEqualToString:toDate]) {
        formattedDateString = [formatter stringFromDate:toDateDate];
        NSString *fromDay = [fromDate substringWithRange:NSMakeRange(8, 2)];
        return [NSString stringWithFormat:@"%@-%@", fromDay, formattedDateString];
    } else {
        formattedDateString = [formatter stringFromDate:fromDateDate];
        return formattedDateString;
    }
    
}

-(CGFloat) getDistance
{
	CLLocationManager *locationManager;
	CLLocation *location;
	//float latitude, longitude;
	
	locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	// Create an instance of CLLocation
	
	location=[locationManager location];
	
	return [location distanceFromLocation:self.currentLocation];
}


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = self.currentLocation.coordinate.latitude;
    theCoordinate.longitude =self.currentLocation.coordinate.longitude;
    return theCoordinate;
}

- (NSString *)title
{
    return self.name;
}

// optional
- (NSString *)subtitle
{
    _selectedInList = YES;
	return self.markedInformation;
}

/* Overriding description (equivalent to toString in JAVA) */
- (NSString*)description {
    return [NSString stringWithFormat:@"<MarketPlace> name : %@, address1 : %@, fromDate : %@, toDate : %@", name, address1, fromDate, toDate];
}

@end
