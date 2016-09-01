//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//


#import <UIKit/UIKit.h>
#import "AboutLoppeMarkedViewController.h"

@class MenuNavigationViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MenuNavigationViewController *viewController;

@property (nonatomic, strong) IBOutlet AboutLoppeMarkedViewController *aboutLoppeMarkedViewController;

@property (nonatomic, retain) UINavigationController *navigationController;
@end
