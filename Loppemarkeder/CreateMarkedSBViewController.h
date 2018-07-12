//
//  CreateMarkedSBViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 12/07/2018.
//

#import <UIKit/UIKit.h>

@interface CreateMarkedSBViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *markedName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *houseNumber;
@property (strong, nonatomic) IBOutlet UITextField *postalCode;
@property (strong, nonatomic) IBOutlet UITextField *fromDate;
@property (strong, nonatomic) IBOutlet UITextField *toDate;
@property (strong, nonatomic) IBOutlet UITextField *additionalOpenPeriode;
@property (strong, nonatomic) IBOutlet UITextField *entre;
@property (strong, nonatomic) IBOutlet UITextField *rules;
@property (strong, nonatomic) IBOutlet UITextField *markedInformation;
@end
