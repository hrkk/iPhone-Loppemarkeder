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
        
        NSDateFormatter *dateFormatx = [[NSDateFormatter alloc]init];
        [dateFormatx setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		self.address1 = [dict objectForKey:@"address"];
		self.dateXtraInfo = [dict objectForKey:@"dateExtraInfo"];
		self.entreInfo = [dict objectForKey:@"entreInfo"];
		self.fromDate = [dateFormatx dateFromString:[dict objectForKey:@"fromDate"]];
     	CGFloat latitude = [[dict objectForKey:@"latitude"] floatValue];
		CGFloat longitude = [[dict objectForKey:@"longitude"] floatValue];
		self.markedInformation = [dict objectForKey:@"markedInformation"];
		self.markedRules = [dict objectForKey:@"markedRules"];
		self.name = [dict objectForKey:@"name"];
        NSString *emptyString = [dict objectForKey:@"toDate"];
        if (![emptyString isKindOfClass:[NSNull class]]) {
            self.toDate = [dateFormatx dateFromString:[dict objectForKey:@"toDate"]];
        }
		_marketID = [[dict objectForKey:@"id"] integerValue];
		self.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
	}
	return self;
}

-(NSString*)getFormattedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // change formatting format to the display format
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *formattedDateString = nil;
    
    if (toDate != nil && ![fromDate isEqualToDate:toDate])
    {
        formattedDateString = [formatter stringFromDate:toDate];
        [formatter setDateFormat:@"dd"];
        NSString *fromDay = [formatter stringFromDate:fromDate];
        return [NSString stringWithFormat:@"%@-%@", fromDay, formattedDateString];
    }
    else
        return [formatter stringFromDate:fromDate];
}

- (NSString*)getFormattedDateXtraInfo {
    if (dateXtraInfo!= nil) {
       return [NSString stringWithFormat:@"%@, %@", self.getFormattedDate, dateXtraInfo];
    }
    return self.getFormattedDate;
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
