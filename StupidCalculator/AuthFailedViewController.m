//
//  AuthFailedViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/10.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "AuthFailedViewController.h"

@implementation AuthFailedViewController

- (IBAction)retryButton:(id)sender
{
  self.context = [[LAContext alloc] init];
  [self.context
   evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
   localizedReason:@"Authentication is required for access"
   reply:^(BOOL success, NSError* error)
   {
     if(success)
     {
       dispatch_async(dispatch_get_main_queue(), ^{
         [self dismissViewControllerAnimated:YES completion:nil];
       });
       NSLog(@"Identity verified");
     }
     else
     {
       NSLog(@"Identity verify failed");
     }
   }];
}

@end
