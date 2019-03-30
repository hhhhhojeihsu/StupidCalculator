//
//  LocationViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/30.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController


#pragma mark - View

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // Regist image with gesture
  self.singleTap = [[UITapGestureRecognizer alloc]
                    initWithTarget:self action:@selector(fbiImageTapped:)];
  [self.singleTap setNumberOfTapsRequired:1];
  [self.fbiImage addGestureRecognizer:self.singleTap];
  
  
  // Init CoreLocation
  self.locationManager = [[CLLocationManager alloc] init];
  self.geocoder = [[CLGeocoder alloc] init];
  [self getLocation];
}

// Override. Set the calcuation screen's status bar to white
- (UIStatusBarStyle) preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

- (void) fbiImageTapped:(UIGestureRecognizer *)recognizer
{
  (void)recognizer;
  [self dismissViewControllerAnimated:TRUE completion:nil];
}


#pragma mark - Location

- (void) getLocation
{
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  
  // Reference: https://stackoverflow.com/a/29692921
  if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    [self.locationManager requestWhenInUseAuthorization];
  
  [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  // Reset label
  self.longtitude.text = @"";
  self.latitude.text = @"";
  self.address.text = @"";
  
  // Show up alert
  UIAlertController* alert =
  [UIAlertController alertControllerWithTitle:@"Error!"
                                      message:@"FBI cannot get your location"
                               preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* doneButton =
  [UIAlertAction actionWithTitle:@"Damn it!!"
                           style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action){
                           [self dismissViewControllerAnimated:TRUE completion:nil];
                         }];
  [alert addAction:doneButton];
  [self presentViewController:alert
                     animated:TRUE
                   completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
  CLLocation *currentLocation = [locations lastObject];
  
  if(currentLocation == nil)
    return;
  
  // Stop updating to conserve power
  [self.locationManager stopUpdatingLocation];
  
  // Update view
  self.longtitude.text = [NSString stringWithFormat:@"%.4f", currentLocation.coordinate.longitude];
  self.latitude.text = [NSString stringWithFormat:@"%.4f", currentLocation.coordinate.latitude];
  
  // Convert coordinate to address
  [self.geocoder reverseGeocodeLocation:currentLocation
                      completionHandler:^(NSArray * placemarks, NSError *  error){
    if(error == nil && [placemarks count] > 0)
    {
      self.placemark = [placemarks lastObject];
      self.address.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                           self.placemark.subThoroughfare,
                           self.placemark.thoroughfare,
                           self.placemark.postalCode,
                           self.placemark.locality,
                           self.placemark.administrativeArea,
                           self.placemark.country
                           ];
    }
  }];
}

@end
