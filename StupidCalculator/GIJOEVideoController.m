//
//  GIJOEVideoController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/18.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "GIJOEVideoController.h"
#import "GIJOEViewController.h"
#import "GIVid.h"

@interface GIJOEVideoController ()

@end

@implementation GIJOEVideoController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // Access the timestamp of another tab bar page
  GIJOEViewController* gijoeViewController;
  gijoeViewController = [self.tabBarController.viewControllers objectAtIndex:0];
  NSString* time = gijoeViewController.timestamp;
  
  // Convert time to seconds
  NSArray* timeComponents = [time componentsSeparatedByString:@":"];
  
  // Load web page
  NSURL* webURL = [NSURL URLWithString:
                   [GIVid getVidURLMS:[((NSString *)timeComponents[0]) integerValue]
                                  and:[((NSString *)timeComponents[1]) integerValue]]];
  NSURLRequest* request = [NSURLRequest requestWithURL:webURL];
  [self.gijoeWebVideo loadRequest:request];
}


@end
