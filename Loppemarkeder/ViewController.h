//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UIActivityIndicatorView *_activityIndicatorView;
	IBOutlet UITableView* tableView;	
   
}
@property (nonatomic, strong) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic, strong) IBOutlet UIButton* sortByDatoButton;
@property (nonatomic, strong) IBOutlet UIButton* sortByNameButton;
@property (nonatomic, strong) IBOutlet UIButton* sortByAfstandButton;
//@property (nonatomic, strong) IBOutlet UIView *buttonSubView;

@property (nonatomic,copy) NSString *currentSort;

- (IBAction)sortByDato:(id)sender;
- (IBAction)sortByName:(id)sender;
- (IBAction)sortByAfstand:(id)sender;

@end