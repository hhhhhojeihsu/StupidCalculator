//
//  SCOperator.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/5.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "SCOperator.h"

@implementation SCOperator

- (double) plus:(double)arg1 with:(double)arg2
{
  return arg1 + arg2;
}

- (double) minus:(double)arg1 with:(double)arg2
{
  return arg1 - arg2;
}

- (double) multi:(double)arg1 with:(double)arg2
{
  return arg1 * arg2;
}

- (NSArray *) divide:(double)arg1 with:(double)arg2
{
  // If divider is 0 set exception flag
  if(arg2 == 0)
    return @[@0];
  else
    return @[@1, @(arg1 / arg2)];
}

@end
