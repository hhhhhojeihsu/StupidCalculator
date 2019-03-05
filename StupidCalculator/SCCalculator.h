//
//  SCCalculator.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCOperator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCCalculator : NSObject

typedef NS_ENUM(int, OPERATOR)
{
  EMPTY,
  CLEAR,
  PM,
  PERCENT,
  DIVIDE,
  MULTI,
  MINUS,
  PLUS,
  EQUAL
};

@property (nonatomic) double doubleResult;
@property (nonatomic, strong) NSMutableString* shownString;
@property (nonatomic) int lastOperator;
@property (strong, nonatomic) SCOperator* SCOperator_;

- (SCCalculator*)init;
- (BOOL) inputFromView:(NSString *)input;
- (BOOL) inputOperator:(int)operatorType;
- (void) saveToResult;


@end

NS_ASSUME_NONNULL_END
