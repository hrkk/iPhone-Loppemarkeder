//
//  ConfirmCreateMarkedViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//
#import "LastStepCreateMarkedViewController.h"
#import "MarketPlace.h"
#import <UIKit/UIKit.h>

@interface ConfirmCreateMarkedViewController : UIViewController {
    UIActivityIndicatorView *_activityIndicatorView;
    IBOutlet UILabel *labelArrangoerName;
    IBOutlet UILabel *labelEmail;
    IBOutlet UILabel *labelPhone;
    IBOutlet UILabel *marketName;
    IBOutlet UILabel *labelAddress;
    IBOutlet UILabel *labelDate;
    IBOutlet UILabel *labelEntre;
    IBOutlet UILabel *labelRegler;
    IBOutlet UILabel *labelMarkedsinformation;
    
    IBOutlet UILabel *headingMarkedsinformation;
    IBOutlet UILabel *headingRegler;
    IBOutlet UILabel *headingEntre;
    IBOutlet UILabel *headingDate;
    IBOutlet UILabel *headingAddress;
    IBOutlet UILabel *headingMarketName;
    IBOutlet UILabel *headingPhone;
    IBOutlet UILabel *headingEmail;
    IBOutlet UILabel *headingArrangoerName;
    CLLocation *location;
}
@property (nonatomic, strong) IBOutlet LastStepCreateMarkedViewController *lastStepCreateMarkedViewController;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) MarketPlace *marketplace;
@property (nonatomic,copy) NSString *stringDate;
@property (nonatomic,copy) NSString *arrangoerNavn;
@property (nonatomic,copy) NSString *arrangoerEmail;
@property (nonatomic,copy) NSString *arrangoerPhone;
@property (nonatomic,copy) NSString *streetAndNumber;
@property (nonatomic,copy) NSString *zip;
@property (nonatomic, assign) BOOL working;
- (IBAction)godkend:(id)sender;
- (IBAction)tilbage:(id)sender;

@end
