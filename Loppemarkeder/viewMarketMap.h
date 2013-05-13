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
#import "MyCLController.h"

@interface ViewMarketMap: UIViewController <SRPostionDelegate,MKMapViewDelegate>{
	IBOutlet MKMapView *myMapView;
	NSMutableArray *pengeAutomaterArray;
}

@property(nonatomic,strong) NSMutableArray *pengeAutomaterArray;

- (void)didUpdateHeading:(CLHeading *)newHeading;

@end
