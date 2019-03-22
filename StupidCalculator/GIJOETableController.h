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
@property (strong, nonatomic) UISearchController *searchController;

- (void)searchForText:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_END
