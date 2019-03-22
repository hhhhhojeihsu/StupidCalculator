//
//  GIJOETableController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/14.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOETableController.h"
#import "TableCell.h"
#import "GIJOEViewController.h"

@interface GIJOETableController ()

@end

@implementation GIJOETableController


#pragma mark - View

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // Load GIJOE dictionary from plist
  NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"GIJOE" ofType:@"plist"];
  NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
  self.nameTable = [NSMutableArray arrayWithArray:dict[@"Name"]];
  self.timeTable = [NSMutableArray arrayWithArray:dict[@"Timestamp"]];
  
  // Init search controller
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.delegate = self;
  self.searchController.searchBar.placeholder = @"探索 GIJOE";
  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.definesPresentationContext = TRUE;
}


#pragma mark - Interface

- (IBAction)backButton:(id)sender
{
  // Back to calculator interface
  [self dismissViewControllerAnimated:TRUE completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  // Based on search or actual table
  if(self.searchController.active)
    return [self.filteredResult count];
  return [self.nameTable count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* tableIdentifier = @"TableCell";
  
  TableCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
  NSString* name = [self.nameTable objectAtIndex:indexPath.row];
  
  // If the cell is not loaded from nib, then load the first time
  if(cell == nil)
  {
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    cell = nib[0];
  }

  if(self.searchController.active)
  {
    name = [self.filteredResult objectAtIndex:indexPath.row];
  }
  cell.cellImage.image = [UIImage imageNamed:name];
  cell.cellName.text = [name componentsSeparatedByString:@" "][1];
  
  cell.cellTime.text = [self.timeTable objectAtIndex:[self.nameTable indexOfObject:name]];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  return cell;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Remove both name and time table from mutable array
  [self.nameTable removeObjectAtIndex:indexPath.row];
  [self.timeTable removeObjectAtIndex:indexPath.row];
  [tableView reloadData];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"gijoeCellSegue" sender:nil];

  TableCell* cell = [tableView cellForRowAtIndexPath:indexPath];
  
  // Checkmark only shown in actual table but not search result
  if(!self.searchController.active)
  {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
  
  return;
}


#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
  NSString *searchString = searchController.searchBar.text;
  [self searchForText:searchString];
  [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar*)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
  // Search whenever the search context changed
  [self updateSearchResultsForSearchController:self.searchController];
  return;
}


#pragma mark - Search

- (void)searchForText:(NSString *)searchText
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
  self.filteredResult = [self.nameTable filteredArrayUsingPredicate:predicate];
  return;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if(![segue.identifier isEqualToString:@"gijoeCellSegue"])
    return;
  
  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  
  // Destination is UITabBarController. Need to access its view controllers
  UITabBarController* destTabBarController = segue.destinationViewController;
  GIJOEViewController* destViewController = destTabBarController.viewControllers[0];
  
  if(self.searchController.active)
  {
    destViewController.name = [self.filteredResult objectAtIndex:indexPath.row];
    destViewController.timestamp = [self.timeTable
                                    objectAtIndex:
                                    [self.nameTable indexOfObject:destViewController.name]];
  }
  else
  {
    destViewController.name = [self.nameTable objectAtIndex:indexPath.row];
    destViewController.timestamp = [self.timeTable objectAtIndex:indexPath.row];
  }
}

@end
