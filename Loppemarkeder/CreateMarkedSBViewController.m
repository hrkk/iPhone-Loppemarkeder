//
//  CreateMarkedSBViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 12/07/2018.
//

#import "CreateMarkedSBViewController.h"

@interface CreateMarkedSBViewController ()

@end

@implementation CreateMarkedSBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NSLog(@"CreateMarkedSBViewController viewDidLoad");
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
    
    if([_toDate isFirstResponder]){
        UIDatePicker *picker = (UIDatePicker*)_toDate.inputView;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // change formatting format to the display format
        [formatter setDateFormat:@"dd-MM-yyyy"];
        NSString *formattedDateString = [formatter stringFromDate:picker.date];
        
        _toDate.text = [NSString stringWithFormat:@"%@",formattedDateString];
    }
    
    // if([_editEndDate isFirstResponder]){
    //     UIDatePicker *picker = (UIDatePicker*)_editEndDate.inputView;
    //     _editEndDate.text = [NSString stringWithFormat:@"%@",picker.date];
    // }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)removeDefaultTextAddress:(id)sender {
    NSString *candidate = self.address.text;
    NSRange rangeValue = [candidate rangeOfString:@"Vej"];
    
    if (rangeValue.length > 0){
        self.address.text=@"";
    }
    
}

- (IBAction) fjernDefaultTekstMarkedsnavn:(id)sender {
    NSString *candidate = self.markedName.text;
    NSRange rangeValue = [candidate rangeOfString:@"Markedsnavn" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.markedName.text=@"";
    }
}


- (IBAction) fjernDefaultTekstHusnummer:(id)sender {
    NSString *candidate = self.houseNumber.text;
    NSRange rangeValue = [candidate rangeOfString:@"Husnummer" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.houseNumber.text=@"";
    }
}

- (IBAction) fjernDefaultTekstPostnummer:(id)sender {
    NSString *candidate = self.postalCode.text;
    NSRange rangeValue = [candidate rangeOfString:@"Postnummer" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.postalCode.text=@"";
    }
}

- (IBAction) fjernDefaultTekstExtraInfo:(id)sender {
    NSString *candidate = self.additionalOpenPeriode.text;
    NSRange rangeValue = [candidate rangeOfString:@"Evt. åbent tidsrum" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.additionalOpenPeriode.text=@"";
    }
}

- (IBAction) fjernDefaultTekstEntre:(id)sender {
    NSString *candidate = self.entre.text;
    NSRange rangeValue = [candidate rangeOfString:@"Entre pris" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.entre.text=@"";
    }
}

- (IBAction) fjernDefaultTekstRegler:(id)sender {
    NSString *candidate = self.rules.text;
    NSRange rangeValue = [candidate rangeOfString:@"Regler" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.rules.text=@"";
    }
}

- (IBAction) fjernDefaultTekstMarkedsInfo:(id)sender {
    NSString *candidate = self.markedInformation.text;
    NSRange rangeValue = [candidate rangeOfString:@"Markedsinformation" options:NSCaseInsensitiveSearch];
    
    if (rangeValue.length > 0){
        self.markedInformation.text=@"";
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"showConfirmMarked"]) {
         NSLog(@"prepareForSegue is equal to showConfirmMarked");
         // set a different back button for the navigation controller
         UIBarButtonItem *myBackButton = [[UIBarButtonItem alloc]init];
         myBackButton.title = @"Cancel";
         
         self.navigationItem.backBarButtonItem = myBackButton;
     }
}


@end
