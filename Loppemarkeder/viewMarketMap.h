//
//  viewMarketMap.h
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#import "MarketPlace.h"
@interface ViewMarketMap: UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
	CLLocationManager *locationManager;
	CLLocation *location;
	float latitude, longitude;
}

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet DetailViewController *detailViewController;

@property (nonatomic, strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) MarketPlace *marketplace;
@end
