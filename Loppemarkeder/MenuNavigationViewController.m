//
//  MenuNavigationViewController.m
//  Loppemarkeder
//
//  Created by Thomas H. Sandvik on 5/14/13.
//
//

#import "MenuNavigationViewController.h"
#import "ViewController.h"
#import "AppDataCache.h"

@interface MenuNavigationViewController ()

@end

@implementation MenuNavigationViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Tilbage";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

- (IBAction)alleMarkeder:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)nearBy:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)omMarkeder:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:NO];
}
- (IBAction)omApp:(id)sender
{
	ViewController *vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
	
	[self.navigationController pushViewController:vc animated:NO];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
