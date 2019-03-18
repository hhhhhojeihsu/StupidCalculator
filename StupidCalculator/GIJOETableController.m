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
}

- (IBAction)backButton:(id)sender
{
  [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.nameTable count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* tableIdentifier = @"TableCell";
  
  TableCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
  
  if(cell == nil)
  {
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil];
    cell = [nib objectAtIndex:0];
  }
  cell.cellImage.image = [UIImage imageNamed:[self.nameTable objectAtIndex:indexPath.row]];
  cell.cellName.text = [[self.nameTable objectAtIndex:indexPath.row] componentsSeparatedByString:@" "][1];
  cell.cellTime.text = [self.timeTable objectAtIndex:indexPath.row];
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
  cell.accessoryType = UITableViewCellAccessoryCheckmark;
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  return;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.nameTable removeObjectAtIndex:indexPath.row];
  [self.timeTable removeObjectAtIndex:indexPath.row];
  [tableView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"gijoeCellSegue"])
  {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GIJOEViewController* destViewController = segue.destinationViewController;
    destViewController.name = [self.nameTable objectAtIndex:indexPath.row];
    destViewController.timestamp = [self.timeTable objectAtIndex:indexPath.row];
  }
  return;
}

@end
