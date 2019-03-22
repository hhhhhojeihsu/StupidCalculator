//
//  GIJOEViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/18.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOEViewController.h"

@interface GIJOEViewController ()

@end

@implementation GIJOEViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.gijoeName.text = [self.name componentsSeparatedByString:@" "][1];
  self.gijoeTimestamp.text = [NSString stringWithFormat:@"Timestamp: %@", self.timestamp];
  self.gijoeImage.image = [UIImage imageNamed:self.name];
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
