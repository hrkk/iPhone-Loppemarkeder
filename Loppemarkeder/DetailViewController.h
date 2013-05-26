#import <UIKit/UIKit.h>
#import "MarketPlace.h"

@interface DetailViewController : UIViewController<MKMapViewDelegate>
{
	CLLocationManager *locationManager;
	CLLocation *location;
	float latitude, longitude;
}

@property (nonatomic, strong) MarketPlace *marketplace;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *entranceLabel;
@property (strong, nonatomic) IBOutlet UILabel *rulesLabel;

@property (strong, nonatomic) IBOutlet UILabel *marketInfo;
- (IBAction)showRoute:(id)sender;
@end
