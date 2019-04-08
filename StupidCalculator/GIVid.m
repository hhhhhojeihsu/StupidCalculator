//
//  GIVid.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/4/5.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIVid.h"

@implementation GIVid

+(NSString *)getVidURLMS:(NSInteger)min and:(NSInteger)sec
{
  return [[NSString alloc]
          initWithFormat:@"https://www.youtube.com/watch?v=ooIudVs8IWg&t=%ld",
          min * 60 + sec];
}

+(NSString *)timeToString:(NSInteger)min and:(NSInteger)sec
{
  return [[NSString alloc] initWithFormat:@"%ld:%02ld", min, sec];
}

@end
