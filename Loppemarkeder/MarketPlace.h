//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MarketPlace : NSObject <MKAnnotation> {

	NSString *dateXtraInfo;	
	NSString *entreInfo;
	
	NSString *address1;
	NSString *fromDate;
	NSString *markedInformation;
	NSString *markedRules;
	NSString *toDate;
	CLLocation *currentLocation;
	CGFloat distance;
	
}
@property (nonatomic) BOOL selectedInList;
@property (nonatomic,copy) NSString *dateXtraInfo;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) NSInteger marketID;
@property (nonatomic,copy) NSString *toDate;
@property (nonatomic,copy) NSString *entreInfo;
@property (nonatomic,copy) NSString *address1;
@property (nonatomic,copy) NSString *fromDate;
@property (nonatomic,copy) NSString *markedInformation;
@property (nonatomic,copy) NSString *markedRules;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) CLLocation *currentLocation;

- (id) initWithDictionary:(NSDictionary *) dict;

-(CGFloat) getDistance;

@end
