//
//  OpretMarkedViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//
#import "ConfirmCreateMarkedViewController.h"
#import "MarketPlace.h"
#import <UIKit/UIKit.h>

@interface OpretMarkedViewController : UIViewController {
   
}
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *emailAdr;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *markedName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *markedInformation;

@property (strong, nonatomic) IBOutlet UITextField *houseNumber;
@property (strong, nonatomic) IBOutlet UITextField *postalCode;
@property (strong, nonatomic) IBOutlet UITextField *toDate;
@property (strong, nonatomic) IBOutlet UITextField *additionalOpenPeriode;
@property (strong, nonatomic) IBOutlet UITextField *rules;
@property (strong, nonatomic) IBOutlet UITextField *entre;

@property (strong, nonatomic) IBOutlet UITextField *fromDate;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet ConfirmCreateMarkedViewController *confirmCreateMarkedViewController;
@property (nonatomic, strong) MarketPlace *marketPlace;

- (IBAction)next:(id)sender;

@end
