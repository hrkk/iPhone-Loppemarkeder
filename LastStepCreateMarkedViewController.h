//
//  LastStepCreateMarkedViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 09/02/14.
//
//

#import <UIKit/UIKit.h>

@interface LastStepCreateMarkedViewController : UIViewController {
     IBOutlet UILabel *confimText;
    
    IBOutlet UILabel *stadeText;
}

- (IBAction)afslut:(id)sender;

@end
