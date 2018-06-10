//
//  MarkedTableViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 10/06/2018.
//

#import <UIKit/UIKit.h>

@interface MarkedTableViewController : UITableViewController

@property (nonatomic,copy) NSString *currentSort;

@property (nonatomic,strong) NSArray *vcMarketList;
@end
