//
//  MarkedTableViewController.h
//  Loppemarkeder
//
//  Created by Kasper Odgaard on 10/06/2018.
//

#import <UIKit/UIKit.h>

@interface MarkedTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIButton *sortByDatoButton;
@property (strong, nonatomic) IBOutlet UIButton *sortByNameButton;
@property (strong, nonatomic) IBOutlet UIButton *sortByAfstandButton;

@property (nonatomic,copy) NSString *currentSort;

@property (nonatomic,strong) NSArray *vcMarketList;
@end
