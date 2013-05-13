//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MarketPlace : NSObject <MKAnnotation> {

	NSString *atmId;	
	NSString *name;	
	NSString *address1;
	NSString *address2;
	NSString *city;
	NSString *zip;
	NSString *title;
	NSString *subtitle;
	NSString *openingHours;
	NSString *phoneNumber;
	UIImage *logo;
	CLLocationCoordinate2D coordinate;
	CLLocation *currentLocation;
	CGFloat distance;
	bool nykreditBranch;
	bool hasATM;
	bool isBank;
	NSString *imageName;
	NSString *webLink;
}
@property (nonatomic,copy) NSString *atmId;
@property (nonatomic,copy) NSString *webLink;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *openingHours;
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,assign) bool isBank;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *address1;
@property (nonatomic,copy) NSString *address2;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *zip;
@property (nonatomic,strong) UIImage *logo;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) bool nykreditBranch;
@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,assign) bool hasATM;
- (id) initWithMPXDictionary:(NSDictionary *) dict;
- (id) initWithDictionary:(NSDictionary *) dict;
- (NSDictionary *)automatAsDictionary;
- (bool)automatContainsSearchString:(NSString *)searchString;
-(CGFloat) getDistance;
@end
