//
//  CameraController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/12.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "CameraController.h"

@interface CameraController ()

@end

@implementation CameraController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.cameraTriggered = FALSE;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  if(!self.cameraTriggered)
  {
    self.cameraTriggered = TRUE;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
  }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
  self.cameraView.image= info[UIImagePickerControllerOriginalImage];
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cameraDoneButton:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
  return;
}

@end
