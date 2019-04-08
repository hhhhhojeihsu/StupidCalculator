//
//  GIJOEEditViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/4/1.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOEEditViewController.h"
#import "AppDelegate.h"
#import "GIVid.h"
#import "GIJOETableController.h"

@interface GIJOEEditViewController ()

@end

@implementation GIJOEEditViewController


#pragma mark - View

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.timePicker.delegate = self;
  self.timePicker.dataSource = self;
}

- (IBAction)cancelButton:(id)sender
{
  [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)saveButton:(id)sender
{
  AppDelegate * delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  NSManagedObjectContext * context = [[delegate persistentContainer] viewContext];
  
  NSManagedObject * newVid = [NSEntityDescription insertNewObjectForEntityForName:@"Video"
                                                           inManagedObjectContext:context];
  [newVid setValue:[[NSString alloc] initWithFormat:@"%@", self.nameTextField.text] forKey:@"name"];
  [newVid setValue:self.nameTextField.text forKey:@"imgUrl"];
  [newVid setValue:[GIVid timeToString:self.min and:self.sec] forKey:@"timestamp"];
  
  [context save:nil];
  
  // Ask parent to reload the table
  //!OCLint Reference: https://stackoverflow.com/questions/32372600/accessing-parent-view-from-modal-segue-swift#comment52617868_32372907
  GIJOETableController * tableController = ((GIJOETableController *)
                                            self.presentingViewController.childViewControllers[0]);
  [tableController loadCusTable];
  [tableController.tableView reloadData];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIPickerViewDataSource

// Reference: https://stackoverflow.com/a/47844789

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  // Video is 11:31 long
  switch(component)
  {
  case 0:
    return 12;
  case 2:
    return 60;
  case 1:
  case 3:
  default:
    return 1;
  }
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
  return pickerView.frame.size.width / 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  switch(component)
  {
  case 1:
    return @"Min";
  case 3:
    return @"Sec";
  case 0:
  case 2:
  default:
    return [[NSString alloc] initWithFormat:@"%ld", row];
  }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
  if(component == 0)
    self.min = row;
  else if(component == 2)
    self.sec = row;
}

@end
