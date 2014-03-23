//
//  OpretMarkedViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//

#import "OpretMarkedViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];


@interface OpretMarkedViewController ()

@end

@implementation OpretMarkedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Opret nyt marked: 1/3";
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:(CGSizeMake(0, 920))];
    
    // create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	
    temporaryBarButtonItem.title = @"Tilbage";
    temporaryBarButtonItem.tintColor = [UIColor blackColor];
    
    NSString *customYellow = @"FFCD05";
    // ios sætter backBtn text til sort
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        customYellow = @"000000";
    }
    int b =0;
    sscanf([customYellow UTF8String],"%x",&b);
    UIColor* btnColor = UIColorFromRGB(b);
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                btnColor,UITextAttributeTextColor,
                                nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
    
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;

}

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
     [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender
{
    /*
    NSLog(@"Gå videre til godkendelse");
    NSLog(@"Firstname %@",self.firstName.text);
    NSLog(@"Lastname %@",self.lastName.text);
    NSLog(@"Email %@",self.emailAdr.text);
    NSLog(@"phoneNumber %@",self.phoneNumber.text);
    
    NSLog(@"markedName %@",self.markedName.text);
    NSLog(@"address %@",self.address.text);
    NSLog(@"postalCode %@",self.postalCode.text);
    NSLog(@"fromDate %@",self.fromDate.text);
    NSLog(@"toDate %@",self.toDate.text);
    NSLog(@"additionalOpenPeriode %@",self.additionalOpenPeriode.text);
    NSLog(@"entre %@",self.entre.text);
    NSLog(@"rules %@",self.rules.text);
    NSLog(@"markedInformation %@",self.markedInformation.text);
    */
    MarketPlace *marketPlace = [[MarketPlace alloc] init];
    NSString *arrangoerName = [NSString stringWithFormat:@"%@ %@", self.firstName.text, self.lastName.text];
    self.confirmCreateMarkedViewController.arrangoerNavn = arrangoerName;
    self.confirmCreateMarkedViewController.arrangoerEmail = self.emailAdr.text;
     self.confirmCreateMarkedViewController.arrangoerPhone = self.phoneNumber.text;
    
    marketPlace.name = self.markedName.text;
    NSString *address = [NSString stringWithFormat:@"%@ %@, %@", self.address.text, self.houseNumber.text, self.postalCode.text];
    marketPlace.address1 = address;
    
    // stringDate
    if (self.toDate!= nil) {
        NSString *fromAndToDate = [NSString stringWithFormat:@"%@-%@", self.fromDate.text, self.toDate.text];
        self.confirmCreateMarkedViewController.stringDate=fromAndToDate;
    } else {
        self.confirmCreateMarkedViewController.stringDate=self.fromDate.text;
    }
    // addition
    marketPlace.dateXtraInfo =self.additionalOpenPeriode.text;
    
    // entre
    marketPlace.entreInfo = self.entre.text;
    
    // regler
    marketPlace.markedRules =self.rules.text;
    
    // markedsinfo
    marketPlace.markedInformation =self.markedInformation.text;
    
   // NSLog(@"marketPlace.name %@",marketPlace.name);
    
    self.confirmCreateMarkedViewController.marketplace = marketPlace;
    
    [self.navigationController pushViewController:self.confirmCreateMarkedViewController animated:YES];
    
    
    
}


@end
