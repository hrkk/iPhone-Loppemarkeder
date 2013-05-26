//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "MarketPlace.h"


@implementation MarketPlace

@synthesize  entreInfo,address1, fromDate, markedInformation, markedRules;
@synthesize name,subtitle,currentLocation;
@synthesize distance;
@synthesize toDate;
@synthesize dateXtraInfo;



- (id) initWithDictionary:(NSDictionary *) dict{
	NSLog(@"%@",dict);
	if (self = [super init]) {
        NSDateFormatter *dateFormatx = [[NSDateFormatter alloc]init];
        [dateFormatx setDateFormat:@"yyyy-MM-dd"];
        
		self.address1 = [dict objectForKey:@"address"];
		self.dateXtraInfo = [dict objectForKey:@"dateExtraInfo"];
		self.entreInfo = [dict objectForKey:@"entreInfo"];
		self.fromDate = [dateFormatx dateFromString:[dict objectForKey:@"stringFromDate"]];
        NSLog(@"%@",[dict objectForKey:@"fromDate"]);
		CGFloat latitude = [[dict objectForKey:@"latitude"] floatValue];
		CGFloat longitude = [[dict objectForKey:@"longitude"] floatValue];
		self.markedInformation = [dict objectForKey:@"markedInformation"];	
		self.markedRules = [dict objectForKey:@"markedRules"];
		self.name = [dict objectForKey:@"name"];		
		self.toDate = [dateFormatx dateFromString:[dict objectForKey:@"stringToDate"]];
		_marketID = [[dict objectForKey:@"id"] integerValue];
		self.currentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];		
	}
	return self;
}


-(NSString *) getYear:(NSString * ) fullDate {
    // TODO build formatted date
    NSString *value = [fullDate substringWithRange:NSMakeRange(0, 4)];
    return value;
}

-(NSString*)description
{
	return [NSString stringWithFormat:@"%@ %f, %f distance: %f",self.address1,self.currentLocation.coordinate.longitude, self.currentLocation.coordinate.latitude, self.distance];
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
@end
