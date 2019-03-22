//
//  ReplaceSegue.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/22.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "ReplaceSegue.h"

@implementation ReplaceSegue


// Reference: https://stackoverflow.com/a/26478478
- (void) perform
{
  // Grab Variables for readability
  UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
  UIViewController *destinationController = (UIViewController*)[self destinationViewController];
  UINavigationController *navigationController = sourceViewController.navigationController;
  
  // Get a changeable copy of the stack
  NSMutableArray *controllerStack = [NSMutableArray arrayWithArray:navigationController.viewControllers];
  
  // Replace the source controller with the destination controller, wherever the source may be
  [controllerStack replaceObjectAtIndex:[controllerStack indexOfObject:sourceViewController] withObject:destinationController];
  
  // Assign the updated stack with animation
  [navigationController setViewControllers:controllerStack animated:YES];
}

@end
