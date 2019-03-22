//
//  AuthFailedViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/10.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "AuthViewController.h"

@implementation AuthViewController

- (void) viewDidAppear:(BOOL)animated
{
  self.context = [[LAContext alloc] init];
  [self verify];
}

- (IBAction)retryButton:(id)sender
{
  [self verify];
}

- (BOOL) checkAvailibilty
{
  // Check if Biometrics are availible
  if([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
    return TRUE;
  return FALSE;
}

- (void) verify
{
  if(![self checkAvailibilty])
  {
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:@"Error!"
                                        message:@"This device does not support Face ID/Touch ID"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* doneButton =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:nil];
    [alert addAction:doneButton];
    [self presentViewController:alert
                       animated:TRUE
                     completion:nil];
    return;
  }
  
  self.context = [[LAContext alloc] init];
  [self.context
   evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
   localizedReason:@"Authentication is required for access"
   reply:^(BOOL success, NSError* error)
   {
     if(success)
     {
       dispatch_async(dispatch_get_main_queue(), ^{
         [self performSegueWithIdentifier:@"VerifySuccessSegue" sender:nil];
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
