//
//  GIJOETableController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/14.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIJOETableController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* nameTable;
@property (strong, nonatomic) NSMutableArray* timeTable;
@property (strong, nonatomic) NSArray* filteredResult;
@property (strong, nonatomic) NSArray* filteredCusResult;
@property (strong, nonatomic) NSArray* cusTable;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (IBAction)backButton:(id)sender;
- (IBAction)clearButton:(id)sender;

- (void)searchForText:(NSString *)searchText;
- (void)loadCusTable;

@end

NS_ASSUME_NONNULL_END
