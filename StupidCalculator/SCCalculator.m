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
    self.SCOperator_ = [[SCOperator alloc] init];
    [self reset];
  }
  return self;
}

- (void) reset
{
  self.doubleResult = 0.0f;
  self.lastOperator = EMPTY;
  [self.shownString setString:@""];
  self.divideException = FALSE;
}

- (BOOL) inputFromView:(NSString *)input
{
  // Ignore 0 or 00 if shownString is empty
  if(([input isEqualToString:@"0"] || [input isEqualToString:@"00"])
     && [self.shownString isEqualToString:@""])
    return FALSE;
  [self.shownString appendFormat:@"%@", input];
  return TRUE;
}

- (BOOL) inputOperator:(int)operatorType
{
  // Execute new operation (requires one operand)
  if(operatorType == PERCENT || operatorType == PM)
    return [self newOperation:operatorType];

  if(self.lastOperator == EMPTY)
  {
    [self saveToResult];
    if(operatorType == EQUAL)
      self.lastOperator = EMPTY;
    else
      self.lastOperator = operatorType;
    return FALSE;
  }
  
  // Execute old operation (requires two operand)
  [self oldOperation];
  
  // Queue new operation
  if(operatorType == EQUAL)
    self.lastOperator = EMPTY;
  else
    self.lastOperator = operatorType;
  return TRUE;
}

- (BOOL) newOperation:(int)operatorType
{
  if(operatorType == PERCENT)
  {
    double doubleTemp = [self.shownString doubleValue];
    [self.shownString setString:@""];
    [self.shownString appendFormat:@"%lg",
     [[self.SCOperator_ divide:doubleTemp with:100.0f][1] doubleValue]];
    return TRUE;
  }
  
  // operatorType == PM
  if([self.shownString length] == 0)
    return FALSE;
  if([@"-" isEqualToString:
      [self.shownString
       substringWithRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]]])
    [self.shownString
     deleteCharactersInRange:[self.shownString rangeOfComposedCharacterSequenceAtIndex:0]];
  else
    [self.shownString insertString:@"-" atIndex:0];
  return TRUE;
}

- (void) oldOperation
{
  switch(self.lastOperator)
  {
    case DIVIDE:
    {
      NSArray* result = [self.SCOperator_ divide:self.doubleResult
                                            with:[self.shownString doubleValue]];
      if([result[0] intValue])
        self.doubleResult = [result[1] doubleValue];
      else
        self.divideException = TRUE;
      [self setResultToShown];
      break;
    }
    case MULTI:
      self.doubleResult = [self.SCOperator_ multi:self.doubleResult
                                             with:[self.shownString doubleValue]];
      [self setResultToShown];
      break;
    case MINUS:
      self.doubleResult = [self.SCOperator_ minus:self.doubleResult
                                             with:[self.shownString doubleValue]];
      [self setResultToShown];
      break;
    case PLUS:
      self.doubleResult = [self.SCOperator_ plus:self.doubleResult
                                            with:[self.shownString doubleValue]];
      [self setResultToShown];
      break;
    default:
      break;
  }
}

- (void) setResultToShown
{
  [self.shownString setString:@""];
  [self.shownString appendFormat:@"%lg", self.doubleResult];
}

- (void) saveToResult
{
  self.doubleResult = [self.shownString doubleValue];
  return;
}


@end
