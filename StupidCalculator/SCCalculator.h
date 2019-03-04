//
//  SCCalculator.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCCalculator : NSObject

@property (nonatomic) int intResult;
@property (nonatomic) double doubleResult;
@property (nonatomic, strong) NSMutableString* shownString;

- (SCCalculator*)init;
- (void) inputFromView:(NSString *)input;


@end

NS_ASSUME_NONNULL_END
