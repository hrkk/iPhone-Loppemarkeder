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
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];

    datePicker.datePickerMode = UIDatePickerModeDate;
    [_fromDate setInputView:datePicker];
    [_toDate setInputView:datePicker];
}


-(void)updateTextField:(id)sender
{
    NSLog(@"updateTextField");
    if([_fromDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_fromDate.inputView;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // change formatting format to the display format
        [formatter setDateFormat:@"dd-MM-yyyy"];
         NSString *formattedDateString = [formatter stringFromDate:picker.date];

        _fromDate.text = [NSString stringWithFormat:@"%@",formattedDateString];
    }
   // if([_editEndDate isFirstResponder]){
   //     UIDatePicker *picker = (UIDatePicker*)_editEndDate.inputView;
   //     _editEndDate.text = [NSString stringWithFormat:@"%@",picker.date];
   // }
}

- (IBAction) textFieldFinishedWithKeyBoard:(id)sender {
     [sender resignFirstResponder];
}

- (IBAction) setDate:(id)sender {
    NSLog(@"setDate");
    NSString *myString = _fromDate.text;
    NSRange rangeValue = [myString rangeOfString:@"dato" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        NSLog(@"dato felt contains dato");
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        _fromDate.text =dateString;
    }
}

- (IBAction) setTilDate:(id)sender {
    NSLog(@"setTilDate");
    NSString *myString = _toDate.text;
    NSRange rangeValue = [myString rangeOfString:@"dato" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        NSLog(@"dato felt contains dato");
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        _toDate.text =dateString;
    }
}

- (IBAction) setTestData:(id)sender {
    NSLog(@"setTestData");
    NSString *myString = _firstName.text;
    NSRange rangeValue = [myString rangeOfString:@"TEST" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        _firstName.text =@"TEST Jørgen";
        _lastName.text =@"TEST Jørgensen";
        _emailAdr.text =@"testmail@mail.dk";
        _phoneNumber.text=@"88223344";
        _markedName.text=@"TEST Marked ÆÅØ æøå";
        _address.text=@"Præstemarksvej";
        _houseNumber.text=@"7";
        _postalCode.text=@"4070";
        _fromDate.text =dateString;
        _toDate.text =dateString;
        _additionalOpenPeriode.text=@"altid åbent!";
        _entre.text = @"Entre info";
        _rules.text = @"og lidt flere regler";
        _markedInformation.text=@"Lidt markedsinformation...";
    }
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
    
    // 1. Validere markeds data -
    // 1.a er dato ok
    NSMutableString *errMsg = [[NSMutableString alloc] init];
    NSLog(@"errMsg %@", errMsg);
    
    if (![self validateFornavn:self.firstName.text]) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Fornavn' er ikke korret udfyldt"];
    };
    
    if (![self validateEfternavn:self.lastName.text]) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Efternavn' er ikke korret udfyldt"];
    };
    
    if (![self validateEmail:self.emailAdr.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'E-mail-adresse' er ikke korret udfyldt"];
    };
    
    if ((![self validateNumber:self.phoneNumber.text]) || ([self.phoneNumber.text length] <= 7) ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Telefon nummer' er ikke korret udfyldt"];
    };
    
    if (![self validateMarkedsnavn:self.markedName.text]) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Markedsnavn' er ikke korret udfyldt"];
    };
    
    if (![self validateVej:self.address.text]) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Vej' er ikke korret udfyldt"];
    };
    
    
    if (![self validateHusnummer:self.houseNumber.text]) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Husnummer' er ikke korret udfyldt"];
    };
    
    
    if ((![self validateNumber:self.postalCode.text]) || ([self.postalCode.text length] != 4) ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Postnummer' er ikke korret udfyldt"];
    };
    
    if (![self validateDate:self.fromDate.text] ) {
        if ([errMsg length] > 0) {
             [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Fra dato' er ikke korret udfyldt"];
    };
    if (![self validateDate:self.toDate.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Til dato' er ikke korret udfyldt"];
    };
    if (![self validateExtraInfo:self.additionalOpenPeriode.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Evt. åbent tidsrum' er ikke korret udfyldt"];
    };
    
    
    if (![self validateEntrepris:self.entre.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Entre pris' er ikke korret udfyldt"];
    };

    
    if (![self validateRegler:self.rules.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Regler' er ikke korret udfyldt"];
    };
    if (![self validateMarkedsinformation:self.markedInformation.text] ) {
        if ([errMsg length] > 0) {
            [errMsg appendString:@", "];
        }
        [errMsg appendString:@"'Markedsinformation' er ikke korret udfyldt"];
    };



    
    // 1.b er zip ok
    
   
    if ([errMsg length] > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valideringsfejl!" message:errMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    
    } else {
        MarketPlace *marketPlace = [[MarketPlace alloc] init];
        NSString *arrangoerName = [NSString stringWithFormat:@"%@ %@", self.firstName.text, self.lastName.text];
        self.confirmCreateMarkedViewController.arrangoerNavn = arrangoerName;
        self.confirmCreateMarkedViewController.arrangoerEmail = self.emailAdr.text;
        self.confirmCreateMarkedViewController.arrangoerPhone = self.phoneNumber.text;
    
            marketPlace.name = self.markedName.text;
        NSString *address = [NSString stringWithFormat:@"%@ %@, %@", self.address.text, self.houseNumber.text, self.postalCode.text];
        marketPlace.address1 = address;
        self.confirmCreateMarkedViewController.streetAndNumber =[NSString stringWithFormat:@"%@ %@", self.address.text, self.houseNumber.text];
        self.confirmCreateMarkedViewController.zip =[NSString stringWithFormat:@"%@", self.postalCode.text];
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
    
}
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL) validateDate: (NSString *) candidate {
    NSDateFormatter *dateFormatx = [[NSDateFormatter alloc]init];
    [dateFormatx setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateCheck = [dateFormatx dateFromString:candidate];
    
    NSLog(@"dateCheck %@",dateCheck);
   
    if(dateCheck== nil){
        return FALSE;
    }
      return TRUE;
    
}
- (BOOL) validateNumber: (NSString *) candidate {
    NSNumberFormatter *integerNumberFormatter = [[NSNumberFormatter alloc] init];
    [integerNumberFormatter setMaximumFractionDigits:0];
    
     NSNumber *proposedNumber = [integerNumberFormatter numberFromString:candidate];
    
    if(proposedNumber== nil){
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateFornavn: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Fornavn" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}


- (BOOL) validateEfternavn: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Efternavn" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateMarkedsnavn: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Markedsnavn" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    if ([candidate length] < 4) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateVej: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Vej"];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateHusnummer: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Husnummer" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL) validateExtraInfo: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Evt. åbent tidsrum" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL) validateEntrepris: (NSString *) candidate {
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateRegler: (NSString *) candidate {
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}

- (BOOL) validateMarkedsinformation: (NSString *) candidate {
    NSRange rangeValue = [candidate rangeOfString:@"Markedsinformation"];
    
    if (rangeValue.length > 0){
        return FALSE;
    }
    
    if ([candidate length] < 2) {
        return FALSE;
    }
    return TRUE;
}
@end
