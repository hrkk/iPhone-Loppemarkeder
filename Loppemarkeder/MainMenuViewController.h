//
//  MainMenuViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 31/05/2018.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Utilities.h"
#import "AppDataCache.h"
#import <CoreLocation/CoreLocation.h>

#define FEED_URL           @"https://loppemarkeder-admin.herokuapp.com/mobile/markeds"

@interface MainMenuViewController :  UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet UIActivityIndicatorView *activityIndi;
}

//@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@end
