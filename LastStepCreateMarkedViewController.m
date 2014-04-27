//
//  LastStepCreateMarkedViewController.m
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//

#import "LastStepCreateMarkedViewController.h"
#import "AppDataCache.h"

@interface LastStepCreateMarkedViewController ()

@end

@implementation LastStepCreateMarkedViewController

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
    self.title = @"Kvittering: 3/3";
    self.navigationItem.hidesBackButton = YES;
    BOOL reload = [AppDataCache shared].reload;
    if(reload) {
        confimText.text = @"Tak for din oprettelse. Dit nye marked er tilføjet til listen. Kontakt info@markedsbooking.dk, hvis du har rettelser eller vil have slettet dit marked.";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)afslut:(id)sender
{
    NSLog(@"Afslut");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
