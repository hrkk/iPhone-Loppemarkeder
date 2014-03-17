//
//  ConfirmCreateMarkedViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//

#import "ConfirmCreateMarkedViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

@interface ConfirmCreateMarkedViewController ()

- (void)jsonPostRequest:(NSData *)jsonRequestData;

@end

@implementation ConfirmCreateMarkedViewController

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
    self.title = @"Godkend: 2/3";
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:(CGSizeMake(0, 920))];

    // Setting Up Activity Indicator View
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.hidesWhenStopped = YES;
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    
   }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Name %@",self.marketplace.name);
    labelArrangoerName.text = self.arrangoerNavn;
    labelEmail.text = self.arrangoerEmail;
    labelPhone.text = self.arrangoerPhone;
    marketName.text = self.marketplace.name;
    labelAddress.text = self.marketplace.address1;
    // adds extra info
    if (self.marketplace.dateXtraInfo != nil) {
        NSString *dateAdd = [NSString stringWithFormat:@"%@, %@", self.stringDate, self.marketplace.dateXtraInfo];
        labelDate.text =dateAdd;
    } else {
        labelDate.text = self.stringDate;
    }
    // entre
    labelEntre.text =self.marketplace.entreInfo;
    // regler
    labelRegler.text = self.marketplace.markedRules;
    
    // markedsinformation
    labelMarkedsinformation.text = self.marketplace.markedInformation;

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)godkend:(id)sender
{
    NSLog(@"Godkend action!!");
   [NSThread detachNewThreadSelector:@selector(threadStartAnimating) toTarget:self withObject:nil];
    NSString *json = [NSString stringWithFormat:@"{%@,name:\"%@\",additionalOpenTimePeriod:\"%@\",entreInfo:\"%@\",markedRules:\"%@\",markedInformation:\"%@\",address:\"%@\",organizerName:\"%@\",organizerEmail:\"%@\",organizerPhone:\"%@\"}", @"class:dk.roninit.dk.MarkedItemView",self.marketplace.name, labelDate.text, self.marketplace.entreInfo, self.marketplace.markedRules, self.marketplace.markedInformation, self.marketplace.address1, self.arrangoerNavn, self.arrangoerEmail, self.arrangoerPhone];
    NSData *postData = [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
       //NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"class", json, nil];
    
   //     NSData *result = [NSJSONSerialization dataWithJSONObject:dict  options:NSJSONWritingPrettyPrinted error:&error];
        
         NSLog(@"JSON request %@", json);
        if(postData != nil) {
            NSLog(@"Call post!!!");
            [self.activityIndicatorView startAnimating];
            [self jsonPostRequest:postData];
            [self.activityIndicatorView stopAnimating];
        }
      [self.navigationController pushViewController:self.lastStepCreateMarkedViewController animated:YES];
}

- (void) threadStartAnimating {
    [self.activityIndicatorView startAnimating];
}

- (IBAction)tilbage:(id)sender
{
    NSLog(@"Tilbage action!!");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)jsonPostRequest:(NSData *)jsonRequestData {
    
    NSURL *url = [NSURL URLWithString:@"http://roninit.dk/LoppemarkederAdminApp/markedItemRest/saveJSONIPhone"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 60];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonRequestData length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:jsonRequestData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}



@end
