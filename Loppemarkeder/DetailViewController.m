
#import "DetailViewController.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    self.title = _marketplace.name;
    _addressLabel.text = _marketplace.address1;
    _dateLabel.text = _marketplace.getFormattedDate;
    _entranceLabel.text = _marketplace.entreInfo;
    _rulesLabel.text = _marketplace.markedRules;
    _marketInfo.text = _marketplace.markedInformation;
    NSLog(@"DetailViewController %@",_marketplace);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
#endif

@end
