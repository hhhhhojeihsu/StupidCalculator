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

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"GIJOE" ofType:@"plist"];

  NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
  self.nameTable = [NSMutableArray arrayWithArray:[dict objectForKey:@"Name"]];
  self.timeTable = [NSMutableArray arrayWithArray:[dict objectForKey:@"Timestamp"]];
  
  // Init search controller
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  self.searchController.searchBar.delegate = self;
  self.searchController.searchBar.placeholder = @"探索 GIJOE";
  self.tableView.tableHeaderView = self.searchController.searchBar;
  self.definesPresentationContext = TRUE;
}

- (IBAction)backButton:(id)sender
{
  [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  if(self.searchController.active)
    return [self.filteredResult count];
  else
    return [self.nameTable count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* tableIdentifier = @"TableCell";
  
  TableCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
  NSString* name = [self.nameTable objectAtIndex:indexPath.row];
  
  if(cell == nil)
  {
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self performSegueWithIdentifier:@"gijoeCellSegue" sender:nil];

  TableCell* cell = [tableView cellForRowAtIndexPath:indexPath];
  
  
  if(!self.searchController.active)
  {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
  
  return;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.nameTable removeObjectAtIndex:indexPath.row];
  [self.timeTable removeObjectAtIndex:indexPath.row];
  [tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
  NSString *searchString = searchController.searchBar.text;
  [self searchForText:searchString];
  [self.tableView reloadData];
}

- (void)searchForText:(NSString *)searchText
{
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
  
  self.filteredResult = [self.nameTable filteredArrayUsingPredicate:predicate];
  return;
}

- (void)searchBar:(UISearchBar*)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
  [self updateSearchResultsForSearchController:self.searchController];
  return;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"gijoeCellSegue"])
  {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    // Destination is UITabBarController. Need to access its view controllers
    UITabBarController* destTabBarController = segue.destinationViewController;
    GIJOEViewController* destViewController = destTabBarController.viewControllers[0];
    
    if(self.searchController.active)
    {
      destViewController.name = [self.filteredResult objectAtIndex:indexPath.row];
      destViewController.timestamp = [self.timeTable objectAtIndex:[self.nameTable indexOfObject:destViewController.name]];
    }
    else
    {
      destViewController.name = [self.nameTable objectAtIndex:indexPath.row];
      destViewController.timestamp = [self.timeTable objectAtIndex:indexPath.row];
    }
  }
  return;
}

@end
