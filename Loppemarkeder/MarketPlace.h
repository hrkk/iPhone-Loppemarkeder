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
	NSDate *fromDate;
	NSString *markedInformation;
	NSString *markedRules;
	NSDate *toDate;
	CLLocation *currentLocation;
	CGFloat distance;
}
@property (nonatomic) BOOL selectedInList;
@property (nonatomic,copy) NSString *dateXtraInfo;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) NSInteger marketID;
@property (nonatomic,copy) NSDate *toDate;
@property (nonatomic,copy) NSString *entreInfo;
@property (nonatomic,copy) NSString *address1;
@property (nonatomic,copy) NSDate *fromDate;
@property (nonatomic,copy) NSString *markedInformation;
@property (nonatomic,copy) NSString *markedRules;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) CLLocation *currentLocation;
// Constructor
- (id) initWithDictionary:(NSDictionary *) dict;

//Instance (-) method
- (CGFloat) getDistance;
- (NSString*)getFormattedDate;
-(CGFloat) getDistance;

@end
