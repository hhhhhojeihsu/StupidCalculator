//
//  SCCalculator.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "SCCalculator.h"

@implementation SCCalculator

- (SCCalculator*) init
{
  if(self = [super init])
  {
    self.shownString = [[NSMutableString alloc] init];
    self.intResult = 0;
    self.doubleResult = 0.0f;
  }
  return self;
}

- (void) inputNumber:(NSString *)input
{
  [self.shownString appendFormat:@"%@", input];
  return;
}

@end
