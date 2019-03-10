//
//  AuthFailedViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/10.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LAContext.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthFailedViewController : UIViewController

- (IBAction)retryButton:(id)sender;
@property (strong, nonatomic) LAContext* context;

@end

NS_ASSUME_NONNULL_END
