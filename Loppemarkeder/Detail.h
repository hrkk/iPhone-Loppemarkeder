//
//  Detail.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 13/06/2018.
//

#import <UIKit/UIKit.h>
#import "MarketPlace.h"

@interface Detail : UIViewController<MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *location;
  //  float latitude, longitude;
}
@property (nonatomic, strong) MarketPlace *marketplace;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateHeadline;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *rulesLabel;
@property (strong, nonatomic) IBOutlet UILabel *marketInfo;

@property (strong, nonatomic) IBOutlet UILabel *entranceHeadline;
@property (strong, nonatomic) IBOutlet UILabel *entranceLabel;

@property (strong, nonatomic) IBOutlet UILabel *rulesHeadline;
@property (strong, nonatomic) IBOutlet UILabel *marketHeadline;
@property (strong, nonatomic) IBOutlet UILabel *bookingHeadline;

@property (strong, nonatomic) IBOutlet UITextView *bookingTextViewInfo;

@end
