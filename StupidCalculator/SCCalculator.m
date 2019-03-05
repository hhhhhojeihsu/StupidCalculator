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
    self.doubleResult = 0.0f;
    self.lastOperator = EMPTY;
    self.SCOperator_ = [[SCOperator alloc] init];
  }
  return self;
}

- (BOOL) inputFromView:(NSString *)input
{
  if([input isEqualToString:@"-"])
  {
    if([@"-" isEqualToString:[self.shownString substringWithRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]]])
     [self.shownString deleteCharactersInRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]];
    else
      [self.shownString insertString:@"-" atIndex:0];
  }
  else if(([input isEqualToString:@"0"] || [input isEqualToString:@"00"]) && [self.shownString isEqualToString:@""])
    return FALSE;
  else
    [self.shownString appendFormat:@"%@", input];
  return TRUE;
}

- (BOOL) inputOperator:(int)operatorType
{
  BOOL retval;
  // Execute old operation
  switch(self.lastOperator)
  {
    case EMPTY:
      [self saveToResult];
      retval = FALSE;
      break;
    case CLEAR:
    case PM:
    case PERCENT:
    case DIVIDE:
    case MULTI:
    case MINUS:
    case PLUS:
      self.doubleResult = [self.SCOperator_ plus:self.doubleResult with:[self.shownString doubleValue]];
      [self.shownString setString:@""];
      [self.shownString appendFormat:@"%lg", self.doubleResult];
      retval = TRUE;
      break;
    case EQUAL:
    default:
      break;
  }
  // Queue new operation
  self.lastOperator = operatorType;
  return retval;
}

- (void) saveToResult
{
  self.doubleResult = [self.shownString doubleValue];
  return;
}

@end
