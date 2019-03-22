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


#pragma mark - View

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.cameraTriggered = FALSE;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  // To prevent trigger camera whenever the view appear
  if(!self.cameraTriggered)
  {
    self.cameraTriggered = TRUE;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
  }
}

// Override. Set the calcuation screen's status bar to white
- (UIStatusBarStyle) preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}


#pragma mark - Action Button

- (IBAction)cameraDoneButton:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
  return;
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
  self.cameraView.image = info[UIImagePickerControllerOriginalImage];
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
  [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
