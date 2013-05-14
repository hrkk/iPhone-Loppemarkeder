//
//  Utilities.m
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "Utilities.h"
#import "MarketPlace.h"
#import "MyCLController.h"

#define kSimulatorLat			55.766338
#define kSimulatorlong			12.496262

@implementation Utilities

+ (NSMutableArray*) loadFromJson:(NSArray*)allMarkets {
	NSMutableArray *array = [[NSMutableArray alloc] init];
    
#if TARGET_IPHONE_SIMULATOR
	CLLocation *cur = [[CLLocation alloc] initWithLatitude:kSimulatorLat longitude:kSimulatorlong];
#else
	CLLocation *cur = [MyCLController sharedInstance].theLocation;
#endif
	
	NSLog(@"%f %f",cur.coordinate.longitude, cur.coordinate.latitude);
 
    // Iterate all and add distance from current location
	for(NSDictionary *eachStation in allMarkets) {
		MarketPlace *item = [[MarketPlace alloc] initWithDictionary:eachStation];
		item.distance = [cur distanceFromLocation:item.currentLocation];
		[array addObject:item];
	}
    
    // Sort by distance
	NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
	[array sortUsingDescriptors:[NSArray arrayWithObject:sorter] ];
	NSLog(@"%@",array);
	
	// Return first 100 – or all if there are less than 100 total
    NSRange top100 = NSMakeRange( 0, ([array count] > 100 ? 100 : [array count]) );
    return [[array subarrayWithRange:top100] mutableCopy];
}

@end
