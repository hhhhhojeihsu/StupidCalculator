//
//  GIJOETableController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/14.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOETableController.h"
#import "TableCell.h"

@interface GIJOETableController ()

@end

@implementation GIJOETableController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.nameTable = [NSArray arrayWithObjects:@"00 ㄟ", @"01 死小孩", @"02 蛤", @"03 你是在蛤三小", @"04 臭奶呆", @"05 X", @"06 阿囉哈", @"07 得修", @"08 超爽得", @"09 撿到一百塊", @"10 黑人給我閉嘴", @"11 歐巴馬", @"12 歐巴馬是誰", @"13 我才不告訴你哩", @"14 ㄟㄟ", nil];
  self.timeTable = [NSArray arrayWithObjects:@"2:03", @"2:05", @"2:06", @"2:07", @"2:08", @"2:09", @"2:13", @"2:16", @"2:21", @"2:22", @"2:27", @"2:28", @"2:30", @"2:32", @"2:35", nil];
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
  TableCell* cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.accessoryType = UITableViewCellAccessoryCheckmark;
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  self.view.userInteractionEnabled = FALSE;
  
  UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 256, 256)];
  pic.center = self.view.center;
  pic.image = [UIImage imageNamed:[self.nameTable objectAtIndex:indexPath.row]];
  pic.tag = 100;
  [pic setContentMode:UIViewContentModeScaleAspectFit];
  [self.view addSubview:pic];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [[self.view viewWithTag:100] removeFromSuperview];
    
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:@"GIJOE 語錄"
                                        message: cell.cellName.text
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* doneButton =
    [UIAlertAction actionWithTitle:@"Done"
                             style:UIAlertActionStyleDefault
                           handler:nil];
    [alert addAction:doneButton];
    [self presentViewController:alert
                       animated:TRUE
                     completion:nil];
    self.view.userInteractionEnabled = TRUE;
  });
  
  return;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
