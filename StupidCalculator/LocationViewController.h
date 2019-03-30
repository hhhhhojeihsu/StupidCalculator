//
//  LocationViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/30.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longtitude;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *fbiImage;

@property (strong, nonatomic) UITapGestureRecognizer *singleTap;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic) CLGeocoder * geocoder;
@property (strong, nonatomic) CLPlacemark * placemark;

- (void) getLocation;
- (void) fbiImageTapped:(UIGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END
