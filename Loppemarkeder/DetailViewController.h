#import <UIKit/UIKit.h>
#import "MarketPlace.h"

@interface DetailViewController : UIViewController<MKMapViewDelegate,UIScrollViewDelegate>
{
	CLLocationManager *locationManager;
	CLLocation *location;
	float latitude, longitude;
}
@property (nonatomic, retain) IBOutlet UIScrollView *itemsContainerScroll;
@property (nonatomic, strong) MarketPlace *marketplace;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateHeadline;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *entranceHeadline;
@property (strong, nonatomic) IBOutlet UILabel *entranceLabel;
@property (strong, nonatomic) IBOutlet UILabel *rulesHeadline;
@property (strong, nonatomic) IBOutlet UILabel *rulesLabel;

@property (strong, nonatomic) IBOutlet UILabel *marketHeadline;
@property (strong, nonatomic) IBOutlet UILabel *marketInfo;
@property (strong, nonatomic) IBOutlet UILabel *bookingHeadline;
@property (strong, nonatomic) IBOutlet UILabel *bookingInfo;
- (IBAction)showRoute:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *bookingTextViewInfo;
@end
