//
//  Created by Thomas H. Sandvik on 5/13/13.
//
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    UIActivityIndicatorView *_activityIndicatorView;
	
   
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@end