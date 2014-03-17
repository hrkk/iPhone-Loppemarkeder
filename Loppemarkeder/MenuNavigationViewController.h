//
//  MenuNavigationViewController.h
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/14/13.
//
//

#import <UIKit/UIKit.h>
#import "AboutLoppeMarkedViewController.h"
#import "AboutAppViewController.h"
#import "OpretMarkedViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MenuNavigationViewController : UIViewController <CLLocationManagerDelegate>
{
    UIActivityIndicatorView *_activityIndicatorView;
    CLLocationManager *locationManager;
	
    
}



@property (nonatomic, strong) IBOutlet AboutLoppeMarkedViewController *aboutLoppeMarkedViewController;
@property (nonatomic, strong) IBOutlet AboutAppViewController *aboutAppViewController;
@property (nonatomic, strong) IBOutlet OpretMarkedViewController *opretMarkedViewController;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (IBAction)alleMarkeder:(id)sender;
- (IBAction)nearBy:(id)sender;
- (IBAction)omMarkeder:(id)sender;
- (IBAction)omApp:(id)sender;
- (IBAction)opretMarked:(id)sender;

@end
