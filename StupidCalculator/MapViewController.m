//
//  MapViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/31.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize coordinate;

#pragma mark - View

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // Override default navigation back button action
  // Reference: https://stackoverflow.com/a/5085512
  UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Back"
                                         style:UIBarButtonItemStyleDone
                                        target:self
                                        action:@selector(backHandler:)];
  self.navigationItem.leftBarButtonItem = backButton;
  
  // Map related initialization
  self.mapView.delegate = self;
  
}

- (void)backHandler:(id)sender
{
  (void)sender;
  [self dismissViewControllerAnimated:TRUE completion:nil];
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  // Zoom to current location
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500);
  [self.mapView setRegion:[self.mapView regionThatFits:region] animated:TRUE];
  
  // Add annotation
  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
  point.coordinate = userLocation.coordinate;
  point.title = @"Your location";
  point.subtitle = @"Napalm ready to deploy";
  [self.mapView addAnnotation:point];
}

@end
