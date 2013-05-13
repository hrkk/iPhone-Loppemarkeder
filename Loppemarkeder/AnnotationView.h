//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface AnnotationView : MKAnnotationView {
	UILabel *price;
	UIImageView *backgroundImage;
	bool background;
//	NSString *title;
//	NSString *subtitle;
	CLLocationCoordinate2D startCoordinate;
	CLLocationCoordinate2D endCoordinate;

}

@property (nonatomic,assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic,assign) CLLocationCoordinate2D endCoordinate;

@property (nonatomic,assign) bool background;
@property (nonatomic,strong) UILabel *price;
@property (nonatomic,strong) UIImageView *backgroundImage;
//@property (nonatomic,copy) NSString *title;
//@property (nonatomic,copy) NSString *subtitle;

- (void) navigate:(id)sender;


@end
