//
//  ConfirmCreateMarkedViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//

#import "ConfirmCreateMarkedViewController.h"
#import "AppDataCache.h"

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
   // NSLog(@"Name %@",self.marketplace.name);
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
    
    // 2. Find koordinater
    [self getLocation];
    
    [self adjustLabelsPosition];
}

// henter location
-(void)getLocation
{
    NSMutableDictionary *placeDictionary = [[NSMutableDictionary alloc] init];
    
    NSString *street =  self.streetAndNumber;
    //NSString *city = @"Kirke Hyllinge";
    NSString *zip = self.zip;
    
    [placeDictionary setValue:street forKey:@"Street"];
    // [self.placeDictionary setValue:city forKey:@"City"];
    // [self.placeDictionary setValue:self.stateOutlet.text forKey:@"State"];
    [placeDictionary setValue:zip forKey:@"ZIP"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressDictionary:placeDictionary completionHandler:^(NSArray *placemarks, NSError *error) {
        if([placemarks count]) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            //[self.mapView setCenterCoordinate:coordinate animated:YES];
            NSLog(@"coordinate %f", coordinate.latitude);
            NSLog(@"coordinate %f", coordinate.longitude);
            NSLog(@"debugDescription %@", placemark.description);
            NSLog(@"ISOcountryCode %@", placemark.ISOcountryCode);
            NSLog(@"locality %@", placemark.locality);
            NSLog(@"postalCode %@", placemark.postalCode);
            NSLog(@"administrativeArea %@", placemark.administrativeArea);
            NSLog(@"country %@", placemark.country);
            NSLog(@"name %@", placemark.name);
            NSLog(@"subLocality %@", placemark.subLocality);
            NSLog(@"%@", [[placemark addressDictionary] description]);
            
            
            NSArray *adressArray = [[placemark addressDictionary] objectForKey:@"FormattedAddressLines"];
            
            if ([adressArray count] >=3) {
                labelAddress.text = [NSString stringWithFormat:@"%@, %@, %@", [adressArray objectAtIndex:0], [adressArray objectAtIndex:1], [adressArray objectAtIndex:2]];
            }
            [self setWorking:YES];
            //placemark.ISOcountryCode
            [self adjustLabelsPosition];

        } else {
            NSLog(@"error");
            location=nil;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kan ikke finde koordinaterne til den valgte adresse" message:@"Gå tilbage og ret adressen? Hvis du forsætter vil oprettelsen gå til manuel behandling, og markedet tilføjes derfor IKKE med det samme." delegate:self cancelButtonTitle:@"Tilbage" otherButtonTitles:nil];
            [alert setTag:12];
            // optional - add more buttons:
            [alert addButtonWithTitle:@"Forsæt"];
            [alert show];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex %ld", (long)buttonIndex);
    if ([alertView tag] == 12) {
        if (buttonIndex == 0) {
            NSLog(@"alertView tag == 12, buttonIndex == 0, Cancel");
            // do nothing
            [self setWorking:NO];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        if (buttonIndex == 1) {
            NSLog(@"alertView tag == 12, buttonIndex == 1, Yes");
            // lav manuel oprettelse
            
            [self setWorking:YES];
           
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) replaceSpecielChars:(NSString *) candidate {
    NSString *res;
    res = [candidate stringByReplacingOccurrencesOfString:@"Ø" withString:@"::OE::"];
    res = [res stringByReplacingOccurrencesOfString:@"Æ" withString:@"::AE::"];
    res = [res stringByReplacingOccurrencesOfString:@"Å" withString:@"::AA::"];
    res = [res stringByReplacingOccurrencesOfString:@"ø" withString:@"::oe::"];
    res = [res stringByReplacingOccurrencesOfString:@"æ" withString:@"::ae::"];
    res = [res stringByReplacingOccurrencesOfString:@"å" withString:@"::aa::"];
    return res;
}
- (IBAction)godkend:(id)sender
{
   // NSLog(@"Godkend action!!");
   [NSThread detachNewThreadSelector:@selector(threadStartAnimating) toTarget:self withObject:nil];
    NSString *json;
    NSString *markedName = [self replaceSpecielChars: self.marketplace.name];
    
    NSString *additionalOpenTimePeriod = [self replaceSpecielChars: self.marketplace.dateXtraInfo];
    
    NSString *address= [self replaceSpecielChars: self.marketplace.address1];
    
    NSString *entreInfo =[self replaceSpecielChars: self.marketplace.entreInfo];
    
    NSString *markedRules=[self replaceSpecielChars: self.marketplace.markedRules];
    
    NSString *markedInformation=[self replaceSpecielChars: self.marketplace.markedInformation];
    
    NSString *organizerName=[self replaceSpecielChars: self.arrangoerNavn];
    
    if(location == nil) {
        NSLog(@"Manuel oprettelse!!");
        json = [NSString stringWithFormat:@"{%@,name:\"%@\",additionalOpenTimePeriod:\"%@\",entreInfo:\"%@\",markedRules:\"%@\",markedInformation:\"%@\",address:\"%@\",organizerName:\"%@\",organizerEmail:\"%@\",organizerPhone:\"%@\"}", @"class:dk.roninit.dk.MarkedItemView",markedName, labelDate.text, entreInfo, markedRules, markedInformation, address, organizerName, self.arrangoerEmail, self.arrangoerPhone];
    } else {
        NSLog(@"Autmatisk oprettelse!!");
        [AppDataCache shared].reload = YES;
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSString *fromDateString = [dateFormat stringFromDate:self.marketplace.fromDate];
        NSString *toDateString = [dateFormat stringFromDate:self.marketplace.toDate];
        
        json = [NSString stringWithFormat:@"{%@,name:\"%@\",additionalOpenTimePeriod:\"%@\",entreInfo:\"%@\",markedRules:\"%@\",markedInformation:\"%@\",address:\"%@\",organizerName:\"%@\",organizerEmail:\"%@\",organizerPhone:\"%@\",latitude:\"%f\",longitude:\"%f\",fromDate:\"%@\",toDate:\"%@\"}", @"class:dk.roninit.dk.MarkedItemView", markedName, additionalOpenTimePeriod, entreInfo, markedRules, markedInformation, address, organizerName, self.arrangoerEmail, self.arrangoerPhone, coordinate.latitude, coordinate.longitude, fromDateString, toDateString];
    }
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
   // NSLog(@"Tilbage action!!");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)jsonPostRequest:(NSData *)jsonRequestData {
    
    NSURL *url = [NSURL URLWithString:@"http://roninit.dk/LoppemarkederAdminApp/markedItemRest/saveJSONIPhone"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 60];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonRequestData length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:jsonRequestData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

-(void)adjustLabelsPosition
{
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(280, FLT_MAX);
    CGSize expectedLabelSize;
    CGRect newFrame;
    
    // Markedsarrangør
    expectedLabelSize = [labelArrangoerName.text sizeWithFont:labelArrangoerName.font constrainedToSize:maximumLabelSize lineBreakMode:labelArrangoerName.lineBreakMode];
   // NSLog(@"labelArrangoerName %@",labelArrangoerName.text );
   // NSLog(@"expectedLabelSize %f",expectedLabelSize.height );
     newFrame = labelArrangoerName.frame;
    newFrame.size.height = expectedLabelSize.height;
    labelArrangoerName.frame = newFrame;


    // heading E-mail adresse
    newFrame = headingEmail.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelArrangoerName.frame.origin.y +   labelArrangoerName.frame.size.height + 5;
    headingEmail.frame = newFrame;
    
    // E-mail adresse
    expectedLabelSize = [labelEmail.text sizeWithFont:labelEmail.font constrainedToSize:maximumLabelSize lineBreakMode:labelEmail.lineBreakMode];
    newFrame = labelEmail.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingEmail.frame.origin.y +   headingEmail.frame.size.height + 5;
    labelEmail.frame = newFrame;
    
    // heading telefonnummer
    newFrame = headingPhone.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelEmail.frame.origin.y +   labelEmail.frame.size.height + 5;
    headingPhone.frame = newFrame;
    
    // telefonnummer
    expectedLabelSize = [labelPhone.text sizeWithFont:labelPhone.font constrainedToSize:maximumLabelSize lineBreakMode:labelPhone.lineBreakMode];
    newFrame = labelPhone.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingPhone.frame.origin.y +   headingPhone.frame.size.height + 5;
    labelPhone.frame = newFrame;
    
    // heading markedsnavn
    newFrame = headingMarketName.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelPhone.frame.origin.y +   labelPhone.frame.size.height + 5;
    headingMarketName.frame = newFrame;

    // markedsnavn
    expectedLabelSize = [marketName.text sizeWithFont:marketName.font constrainedToSize:maximumLabelSize lineBreakMode:marketName.lineBreakMode];
    newFrame = marketName.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingMarketName.frame.origin.y +   headingMarketName.frame.size.height + 5;
    marketName.frame = newFrame;

    // heading adresse
    newFrame = headingAddress.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = marketName.frame.origin.y +   marketName.frame.size.height + 5;
    headingAddress.frame = newFrame;
    
    // adresse
    expectedLabelSize = [labelAddress.text sizeWithFont:labelAddress.font constrainedToSize:maximumLabelSize lineBreakMode:labelAddress.lineBreakMode];
    newFrame = labelAddress.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingAddress.frame.origin.y + headingAddress.frame.size.height + 5;
    labelAddress.frame = newFrame;
    
    // heading dato
    newFrame = headingDate.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelAddress.frame.origin.y + labelAddress.frame.size.height + 5;
    headingDate.frame = newFrame;
    
    // dato
    expectedLabelSize = [labelDate.text sizeWithFont:labelDate.font constrainedToSize:maximumLabelSize lineBreakMode:labelDate.lineBreakMode];
    newFrame = labelDate.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingDate.frame.origin.y + headingDate.frame.size.height + 5;
    labelDate.frame = newFrame;

    // heading entre
    newFrame = headingEntre.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelDate.frame.origin.y + labelDate.frame.size.height + 5;
    headingEntre.frame = newFrame;
    
    // entre
    expectedLabelSize = [labelEntre.text sizeWithFont:labelEntre.font constrainedToSize:maximumLabelSize lineBreakMode:labelEntre.lineBreakMode];
    newFrame = labelEntre.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingEntre.frame.origin.y + headingEntre.frame.size.height + 5;
    labelEntre.frame = newFrame;
    
    // heading regler
    newFrame = headingRegler.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelEntre.frame.origin.y + labelEntre.frame.size.height + 5;
    headingRegler.frame = newFrame;
    
    // regler
    expectedLabelSize = [labelRegler.text sizeWithFont:labelRegler.font constrainedToSize:maximumLabelSize lineBreakMode:labelRegler.lineBreakMode];
    newFrame = labelRegler.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingRegler.frame.origin.y + headingRegler.frame.size.height + 5;
    labelRegler.frame = newFrame;
    
    // heading markedsinformation
    newFrame = headingMarkedsinformation.frame;
    newFrame.origin.x = 20;
    newFrame.origin.y = labelRegler.frame.origin.y + labelRegler.frame.size.height + 5;
    headingMarkedsinformation.frame = newFrame;
    
    // markedsinformation
    expectedLabelSize = [labelMarkedsinformation.text sizeWithFont:labelMarkedsinformation.font constrainedToSize:maximumLabelSize lineBreakMode:labelMarkedsinformation.lineBreakMode];
    newFrame = labelMarkedsinformation.frame;
    newFrame.size.height = expectedLabelSize.height;
    newFrame.origin.x = 20;
    newFrame.origin.y = headingMarkedsinformation.frame.origin.y + headingMarkedsinformation.frame.size.height + 5;
    labelMarkedsinformation.frame = newFrame;
}


@end
