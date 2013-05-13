//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//


#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, retain) UINavigationController *navigationController;
@end
