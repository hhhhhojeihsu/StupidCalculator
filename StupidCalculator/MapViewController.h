//
//  MapViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/31.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MKMapViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void)backHandler:(id)sender;

@end

NS_ASSUME_NONNULL_END
