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

@property (nonatomic) BOOL cameraTriggered;
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
- (IBAction)cameraDoneButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
