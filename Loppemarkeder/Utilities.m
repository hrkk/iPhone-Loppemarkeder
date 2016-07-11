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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [locationManager requestWhenInUseAuthorization];
    }

    
#if TARGET_IPHONE_SIMULATOR
	location = [[CLLocation alloc] initWithLatitude:kSimulatorLat longitude:kSimulatorlong];
	
#endif
	
//	NSLog(@"current location: %f %f",location.coordinate.longitude, location.coordinate.latitude);
	
    // Iterate all and add distance from current location
	for(NSDictionary *eachStation in allMarkets) {
		MarketPlace *item = [[MarketPlace alloc] initWithDictionary:eachStation];
		item.distance = [location distanceFromLocation:item.currentLocation];
		[array addObject:item];
	//	NSLog(@"%f",item.distance);
	}
 
	NSArray *sortedArray = [self sortArrayByName:array];
	
	// Return first 400 – or all if there are less than 400 total
    NSRange top200 = NSMakeRange( 0, ([sortedArray count] > 600 ? 600 : [sortedArray count]) );
    return [[sortedArray subarrayWithRange:top200] mutableCopy];
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
    // sørger for det er sorteret i dato orden først
    nonSortedArr = [self sortArrayByDate: nonSortedArr];
    
    NSMutableArray *arr  = [NSMutableArray arrayWithArray:nonSortedArr];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [arr sortUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
   
    nonSortedArr = [NSArray arrayWithArray:arr];
   
    return nonSortedArr;
    
    
//    NSArray *sortedArray = [nonSortedArr sortedArrayUsingComparator:^NSComparisonResult(MarketPlace *obj1, MarketPlace *obj2) {
//		if (obj1.name > obj2.name)
//			return NSOrderedDescending;
//		else if (obj1.name < obj2.name)
//			return NSOrderedAscending;
//		return NSOrderedSame;
//	}];
//	
//	return sortedArray;
}

@end
