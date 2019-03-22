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
  
  // Copy context sent from segue to outlet
  self.gijoeName.text = [self.name componentsSeparatedByString:@" "][1];
  self.gijoeTimestamp.text = [NSString stringWithFormat:@"Timestamp: %@", self.timestamp];
  self.gijoeImage.image = [UIImage imageNamed:self.name];
}


@end
