//
//  VideoController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/11.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoController : UIViewController

- (void) orientationChanged:(NSNotification *)note;
- (void) playLocalVideo:(NSString *)name dot:(NSString *)ext;

@end

NS_ASSUME_NONNULL_END
