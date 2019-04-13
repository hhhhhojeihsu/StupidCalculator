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
#import "AppDelegate.h"

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
  
  // Init context
  AppDelegate * delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  self.context = [[delegate persistentContainer] viewContext];
  
  [self loadCusTable];
  
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

- (IBAction)clearButton:(id)sender
{
  // Show confirmation alert
  UIAlertController* alert =
  [UIAlertController alertControllerWithTitle:@"Confirmation!"
                                      message:
   @"This will delete all the data you previously entered. \
   Are you sure you want to do it?"
                               preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* deleteButton =
  [UIAlertAction actionWithTitle:@"Delete"
                           style:UIAlertActionStyleDestructive
                         handler:^(UIAlertAction * action){
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"Video"];
    NSBatchDeleteRequest * delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    [self.context executeRequest:delete error:nil];
     
    // cusTable should be empty now
    self.cusTable = @[];
    [self.tableView reloadData];
  }];
  UIAlertAction* cancelButton =
  [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  [alert addAction:deleteButton];
  [alert addAction:cancelButton];
  [self presentViewController:alert
                     animated:TRUE
                   completion:nil];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  // Based on search or actual table
  if(self.searchController.active)
  {
    if(section == 0)
      return [self.filteredResult count];
    // else if(section == 1)
    return [self.filteredCusResult count];
  }
  // else
  if(section == 0)
    return [self.nameTable count];
  // else if(section == 1)
  return [self.cusTable count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
  if(section == 0)
    return @"Stock";
  // else if(section == 1)
  return @"Customized";
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* tableIdentifier = @"TableCell";
  
  TableCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
  NSString* name;
  
  // If the cell is not loaded from nib, then load the first time
  if(cell == nil)
  {
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    cell = nib[0];
  }

  if(indexPath.section == 0)
  {
    if(self.searchController.active)
    {
      name = [self.filteredResult objectAtIndex:indexPath.row];
      cell.cellTime.text = [self.timeTable objectAtIndex:[self.nameTable indexOfObject:name]];
    }
    else
    {
      name = [self.nameTable objectAtIndex:indexPath.row];
      cell.cellTime.text = [self.timeTable objectAtIndex:indexPath.row];
    }
    cell.cellName.text = name;
    cell.cellImage.image = [UIImage imageNamed:name];
  }
  else // if(indexPath.seciont == 1)
  {
    if(self.searchController.active)
    {
      name = [self.filteredCusResult objectAtIndex:indexPath.row];
      for(NSObject *element in self.cusTable)
      {
        if([[element valueForKey:@"name"] isEqualToString:name])
        {
          cell.cellTime.text = [element valueForKey:@"timestamp"];
          break;
        }
      }
    }
    else
    {
      name = [self.cusTable[indexPath.row] valueForKey:@"name"];
      cell.cellTime.text = [self.cusTable[indexPath.row] valueForKey:@"timestamp"];
    }
    cell.cellName.text = name;
    // TODO: Set custom picture
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.section == 0)
  {
    // Remove both name and time table from mutable array
    [self.nameTable removeObjectAtIndex:indexPath.row];
    [self.timeTable removeObjectAtIndex:indexPath.row];
  }
  else if(indexPath.section == 1)
  {
    // Save to Core Data
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"Video"];
    NSArray * arr = [self.context executeFetchRequest:request error:nil];
    [self.context deleteObject:arr[indexPath.row]];
    [self.context save:nil];
      
    // Reload cusTable from Core Data
    [self loadCusTable];
  }

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

  // cusTable is array of object of multiple value
  NSMutableArray *cusArr = [[NSMutableArray alloc] init];
  for(NSObject *element in self.cusTable)
  {
    [cusArr addObject:[element valueForKey:@"name"]];
  }
  self.filteredCusResult = [cusArr filteredArrayUsingPredicate:predicate];
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
    if(indexPath.section == 0)
    {
      destViewController.name = [self.filteredResult objectAtIndex:indexPath.row];
      destViewController.timestamp = [self.timeTable
                                      objectAtIndex:
                                      [self.nameTable indexOfObject:destViewController.name]];
    }
    else // indexPath.section == 1
    {
      destViewController.name = [self.filteredCusResult objectAtIndex:indexPath.row];
      for(NSObject *element in self.cusTable)
      {
        if([[element valueForKey:@"name"] isEqualToString:destViewController.name])
        {
          destViewController.timestamp = [element valueForKey:@"timestamp"];
          break;
        }
      }
    }

  }
  else // Regular table
  {
    if(indexPath.section == 0)
    {
      destViewController.name = [self.nameTable objectAtIndex:indexPath.row];
      destViewController.timestamp = [self.timeTable objectAtIndex:indexPath.row];
    }
    else // indexPath.section == 1
    {
      destViewController.name = [self.cusTable[indexPath.row] valueForKey:@"name"];
      destViewController.timestamp = [self.cusTable[indexPath.row] valueForKey:@"timestamp"];
    }
  }
}

#pragma mark - Misc.

- (void)loadCusTable
{
  // Load GIJOE list from core data
  NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:@"Video"];
  
  // Reference: https://stackoverflow.com/a/7304350
  // Object content will not be filled in debugger if not used.
  self.cusTable = [self.context executeFetchRequest:request error:nil];
  return;
}

@end
