//
//  GIVid.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/4/5.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIVid : NSObject

+(NSString *)getVidURLMS:(NSInteger)min and:(NSInteger)sec;
+(NSString *)timeToString:(NSInteger)min and:(NSInteger)sec;

@end

NS_ASSUME_NONNULL_END
