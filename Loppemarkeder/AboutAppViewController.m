
#import "AboutAppViewController.h"

@implementation AboutAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"Om App";
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:(CGSizeMake(300, 1100))];
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

- (IBAction)openAipopsWWW:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.aipops.com"]];
}

- (IBAction)openRoninItWWW:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.roninit.dk"]];
}

- (IBAction)openMeDesignWWW:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.medesign.dk"]];
}

- (void)viewDidUnload {
    [self setScroller:nil];
    [super viewDidUnload];
}
@end
