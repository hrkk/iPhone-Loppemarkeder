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

@interface MenuNavigationViewController : UIViewController
{
    UIActivityIndicatorView *_activityIndicatorView;
	
    
}



@property (nonatomic, strong) IBOutlet AboutLoppeMarkedViewController *aboutLoppeMarkedViewController;
@property (nonatomic, strong) IBOutlet AboutAppViewController *aboutAppViewController;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (IBAction)alleMarkeder:(id)sender;
- (IBAction)nearBy:(id)sender;
- (IBAction)omMarkeder:(id)sender;
- (IBAction)omApp:(id)sender;

@end
