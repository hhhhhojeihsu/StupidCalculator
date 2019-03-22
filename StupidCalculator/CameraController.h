//
//  CameraController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/12.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cameraView;

- (IBAction)cameraDoneButton:(id)sender;

@property (nonatomic) BOOL cameraTriggered;

@end

NS_ASSUME_NONNULL_END
