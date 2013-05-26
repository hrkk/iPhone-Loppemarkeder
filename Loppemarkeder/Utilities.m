//
//  Utilities.m
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "Utilities.h"
#import "MarketPlace.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define kSimulatorLat			55.766338
#define kSimulatorlong			12.496262

@implementation Utilities

+ (NSMutableArray*) loadFromJson:(NSArray*)allMarkets {
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	CLLocationManager *locationManager;
	CLLocation *location;
	//float latitude, longitude;
	
	locationManager=[[CLLocationManager alloc] init];
	locationManager.desiredAccuracy=kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	
	// Create an instance of CLLocation
	
	location=[locationManager location];
    
#if TARGET_IPHONE_SIMULATOR
	location = [[CLLocation alloc] initWithLatitude:kSimulatorLat longitude:kSimulatorlong];
	
#endif
	
	NSLog(@"%f %f",location.coordinate.longitude, location.coordinate.latitude);
	
    // Iterate all and add distance from current location
	for(NSDictionary *eachStation in allMarkets) {
		MarketPlace *item = [[MarketPlace alloc] initWithDictionary:eachStation];
		item.distance = [location distanceFromLocation:item.currentLocation];
		[array addObject:item];
		NSLog(@"%@",item);
	}
 
	NSArray *sortedArray = [self sortArrayByName:array];
	
	// Return first 100 – or all if there are less than 100 total
    NSRange top100 = NSMakeRange( 0, ([sortedArray count] > 100 ? 100 : [sortedArray count]) );
    return [[sortedArray subarrayWithRange:top100] mutableCopy];
}

+(NSArray*)sortArrayByDistance:(NSArray*)nonSortedArr
{
	NSArray *sortedArray = [nonSortedArr sortedArrayUsingComparator:^NSComparisonResult(MarketPlace *obj1, MarketPlace *obj2) {
		if (obj1.distance > obj2.distance)
			return NSOrderedDescending;
		else if (obj1.distance < obj2.distance)
			return NSOrderedAscending;
		return NSOrderedSame;
	}];
	
	return sortedArray;
}

+(NSArray*)sortArrayByDate:(NSArray*)nonSortedArr
{
	NSMutableArray *arr  = [NSMutableArray arrayWithArray:nonSortedArr];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"fromDate" ascending:YES];
    [arr sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    nonSortedArr = [NSArray arrayWithArray:arr];
    
    return nonSortedArr;
    
    
//    NSArray *sortedArray = [nonSortedArr sortedArrayUsingComparator:^NSComparisonResult(MarketPlace *obj1, MarketPlace *obj2) {
//		if (obj1.fromDate > obj2.fromDate)
//			return NSOrderedDescending;
//		else if (obj1.fromDate < obj2.fromDate)
//			return NSOrderedAscending;
//		return NSOrderedSame;
//	}];
	
	//return sortedArray;
}

+(NSArray*)sortArrayByName:(NSArray*)nonSortedArr
{
	NSArray *sortedArray = [nonSortedArr sortedArrayUsingComparator:^NSComparisonResult(MarketPlace *obj1, MarketPlace *obj2) {
		if (obj1.name > obj2.name)
			return NSOrderedDescending;
		else if (obj1.name < obj2.name)
			return NSOrderedAscending;
		return NSOrderedSame;
	}];
	
	return sortedArray;
}

@end
