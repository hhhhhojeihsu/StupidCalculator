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

- (void) inputFromView:(NSString *)input
{
  if([input isEqualToString:@"-"])
  {
    if([@"-" isEqualToString:[self.shownString substringWithRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]]])
     [self.shownString deleteCharactersInRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]];
    else
      [self.shownString insertString:@"-" atIndex:0];
  }
  else
    [self.shownString appendFormat:@"%@", input];
  return;
}

@end
