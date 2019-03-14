//
//  GIJOETableController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/14.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOETableController.h"

@interface GIJOETableController ()

@end

@implementation GIJOETableController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.table = [NSArray arrayWithObjects:@"00 ㄟ", @"01 死小孩", @"02 蛤", @"03 你是在蛤三小", @"04 臭奶呆", @"05 幹", @"06 阿囉哈", @"07 得修", @"08 超爽得", @"09 撿到一百塊", @"10 黑人給我閉嘴", @"11 歐巴馬d", @"12 是誰", @"13 我才不告訴你哩", @"14 ㄟㄟ", nil];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.table count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString* tableIdentifier = @"GIJOETableItem";
  
  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
  
  if(cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
  }
  
  cell.textLabel.text = [self.table objectAtIndex:indexPath.row];
  cell.imageView.image = [UIImage imageNamed:cell.textLabel.text];
  return cell;
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
