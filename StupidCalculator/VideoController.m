//
//  VideoController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/11.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "VideoController.h"

@interface VideoController ()

@end

@implementation VideoController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:[UIDevice currentDevice]];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
  switch(deviceOrientation)
  {
    case UIDeviceOrientationLandscapeRight:
      [self playYTVideo:@"ooIudVs8IWg"];
      break;
    case UIDeviceOrientationLandscapeLeft:
      [self playLocalVideo:@"Yee" dot:@"mp4"];
      break;
    default:
      break;
  }
}

- (void) orientationChanged:(NSNotification *)note
{
  UIDevice * device = note.object;
  
  switch(device.orientation)
  {
    case UIDeviceOrientationPortrait:
      NSLog(@"Orientation: Portrait");
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
      [self dismissViewControllerAnimated:YES completion:nil];
      [self dismissViewControllerAnimated:YES completion:nil];
      break;
    case UIDeviceOrientationLandscapeRight:
      [self playYTVideo:@"ooIudVs8IWg"];
      break;
    case UIDeviceOrientationLandscapeLeft:
      [self playLocalVideo:@"Yee" dot:@"mp4"];
      break;
    default:
      break;
  };
}

- (void) playLocalVideo:(NSString *)name dot:(NSString *)ext
{
  NSString *videoPath = [[NSBundle mainBundle] pathForResource:name
                                                        ofType:ext];
  NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
  AVPlayer *player = [AVPlayer playerWithURL:videoURL];
  player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(playerItemDidReachEnd:)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:[player currentItem]];
  AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = player;
  [playerViewController.player play];
  [self presentViewController:playerViewController animated:YES completion:nil];
}

- (void) playerItemDidReachEnd:(NSNotification *)notification
{
  AVPlayerItem *p = [notification object];
  [p seekToTime:kCMTimeZero completionHandler:nil];
  return;
}

- (void) playYTVideo:(NSString *)vidID
{
  YTPlayerView* ytView = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  [ytView loadWithVideoId:vidID];
  [self.view addSubview:ytView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
