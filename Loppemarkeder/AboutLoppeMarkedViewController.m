
#import "AboutLoppeMarkedViewController.h"

@implementation AboutLoppeMarkedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Om Loppemarked";
        
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];	
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
#endif

@end
