//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//


#import <UIKit/UIKit.h>

@class MenuNavigationViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MenuNavigationViewController *viewController;

@property (nonatomic, retain) UINavigationController *navigationController;
@end
