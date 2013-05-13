//
//  Utilities.m
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import "Utilities.h"
#import "MarketPlace.h"

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
	
 
    // Iterate all and add distance from current location
	for(NSDictionary *eachStation in allMarkets) {
		MarketPlace *eachSRPengeAutomat = [[MarketPlace alloc] initWithDictionary:eachStation];
		eachSRPengeAutomat.distance = [cur distanceFromLocation:eachSRPengeAutomat.currentLocation];
		[array addObject:eachSRPengeAutomat];
	}
    
    // Sort by distance
	NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
	[array sortUsingDescriptors:[NSArray arrayWithObject:sorter] ];
	
    // Find first item with name Nykredit
	int nr =0;
	for (MarketPlace *aut in array) {
		NSRange range = [[aut.name  lowercaseString] rangeOfString:@"nykredit"];
		if(range.location!=NSNotFound )
			break;
        
		nr++;
	}
    
	// Did we find one?
    if(nr != 0 && nr < [array count])
    {
        // Yes: move it to first position
		MarketPlace *aut = [array objectAtIndex:nr];
		[array removeObjectAtIndex:nr];
		[array insertObject:aut atIndex:0];
       
	}
    
	// Return first 100 – or all if there are less than 100 total
    NSRange top100 = NSMakeRange( 0, ([array count] > 100 ? 100 : [array count]) );
    return [[array subarrayWithRange:top100] mutableCopy];
}

@end
