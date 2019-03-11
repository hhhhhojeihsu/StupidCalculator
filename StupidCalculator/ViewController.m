//
//  ViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "ViewController.h"
#define UPDATE_LABEL self.result.text = self.SCCalculator_.shownString;
#define CHECK_EXCEPTION_RESULT \
        [self checkException];\
        [self checkResult];
#define SET_C_DETECT_LENGTH [self.acOutlet setTitle:@"C" forState:UIControlStateNormal]; [self checkLength];

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.SCCalculator_ = [[SCCalculator alloc] init];
  self.context = [[LAContext alloc] init];
  [self verifyIdentity];
}

- (IBAction)acButton:(id)sender
{
  if([self.acOutlet.titleLabel.text isEqualToString:@"C"])
  {
    self.result.text = @"0";
    [self.SCCalculator_.shownString setString:@""];
    [self.acOutlet setTitle:@"AC" forState:UIControlStateNormal];
  }
  else
  {
    self.result.text = @"0";
    [self.SCCalculator_ reset];
  }
}

- (IBAction)pmButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:PM])
    UPDATE_LABEL;
}

- (IBAction)percentButton:(id)sender
{
  [self.SCCalculator_ inputOperator:PERCENT];
  UPDATE_LABEL;
  CHECK_EXCEPTION_RESULT;
}

- (IBAction)divideButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:DIVIDE])
  {
    UPDATE_LABEL;
    CHECK_EXCEPTION_RESULT;
  }
  [self.SCCalculator_.shownString setString:@""];
}

- (IBAction)sevenButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"7"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)eightButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"8"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)nineButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"9"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)multiButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:MULTI])
    UPDATE_LABEL;
    CHECK_EXCEPTION_RESULT;
  [self.SCCalculator_.shownString setString:@""];
}

- (IBAction)fourButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"4"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)fiveButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"5"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)sixButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"6"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)minusButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:MINUS])
    UPDATE_LABEL;
    CHECK_EXCEPTION_RESULT;
  [self.SCCalculator_.shownString setString:@""];
}

- (IBAction)oneButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"1"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)twoButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"2"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)threeButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"3"];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)plusButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:PLUS])
    UPDATE_LABEL;
    CHECK_EXCEPTION_RESULT;
  [self.SCCalculator_.shownString setString:@""];
}

- (IBAction)zeroButton:(id)sender
{
  if([self.SCCalculator_ inputFromView:@"0"])
  {
    UPDATE_LABEL;
    SET_C_DETECT_LENGTH;
  }
  else if(![self.result.text isEqualToString:@"0"])
  {
    self.result.text = @"0";
  }
}

- (IBAction)twoZeroButton:(id)sender
{
  if([self.SCCalculator_ inputFromView:@"00"])
  {
    UPDATE_LABEL;
    SET_C_DETECT_LENGTH;
  }
  else if(![self.result.text isEqualToString:@"0"])
  {
    self.result.text = @"0";
  }
}

- (IBAction)dotButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"."];
  UPDATE_LABEL;
  SET_C_DETECT_LENGTH;
}

- (IBAction)equalButton:(id)sender
{
  if([self.SCCalculator_ inputOperator:EQUAL])
  {
    UPDATE_LABEL;
    CHECK_EXCEPTION_RESULT;
  }
}

- (void) checkException
{
  if(self.SCCalculator_.divideException)
  {
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:@"阿囉哈"
                                        message:@"國小生都知道不能除以 0 了，除非你是國小生"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* doneButton =
    [UIAlertAction actionWithTitle:@"朕知道了"
                             style:UIAlertActionStyleDefault
                           handler:nil];
    [alert addAction:doneButton];
    [self presentViewController:alert
                       animated:TRUE
                     completion:nil];
    [self.SCCalculator_ reset];
    self.result.text = @"0";
  }
}

- (void) itemDidFinishPlaying:(NSNotification*) notification
{
  [self dismissViewControllerAnimated:YES completion:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}


- (void) checkLength
{
  if([self.result.text length] <= 12)
    return;
  
  NSLog(@"Stahp");
  
  self.result.text = @"0";
  [self.SCCalculator_ reset];
  
  NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"Stahp" ofType:@"mp4"];
  NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
  AVPlayer *player = [AVPlayer playerWithURL:videoURL];
  AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = player;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
  
  [playerViewController.player play];
  [self presentViewController:playerViewController animated:YES completion:nil];
}

- (void) checkResult
{
  /*
  if(self.SCCalculator_.lastOperator == EMPTY)
    return;
   */
  switch([self.result.text intValue])
  {
  case 5566:
  {
    WKWebViewConfiguration* webConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView* webView = [[WKWebView alloc]
                          initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70)
                          configuration:webConfiguration];
    NSURL* webURL = [NSURL URLWithString:@"https://zh.wikipedia.org/zh-tw/5566"];
    NSURLRequest* request = [NSURLRequest requestWithURL:webURL];
    webView.tag = 5566;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect doneButtonFrame = CGRectMake(0, 25, 100, 44);
    doneButton.frame = doneButtonFrame;
    doneButton.tag = 5567;
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(doneButtonClicked)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    break;
  }
  case 66:
  {
    UIImageView *order66 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 307, 212)];
    order66.center = self.view.center;
    order66.image = [UIImage imageNamed:@"order66"];
    order66.tag = 66;
    [self.view addSubview:order66];
    [UIImageView animateWithDuration:5 animations:^{
      order66.alpha = 0.0f;
    } completion:^(BOOL finished){
      [[self.view viewWithTag:66] removeFromSuperview];
      [self.SCCalculator_ reset];
      self.result.text = @"0";
    }];
    break;
  }
  default:
    break;
  }
  return;
}

- (void) doneButtonClicked
{
  [[self.view viewWithTag:5566] removeFromSuperview];
  [[self.view viewWithTag:5567] removeFromSuperview];
  [self.SCCalculator_ reset];
  self.result.text = @"0";
  return;
}

- (void) verifyIdentity
{
  if(![self checkAvailibilty])
    return;
  [self.context
   evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
   localizedReason:@"Authentication is required for access"
   reply:^(BOOL success, NSError* error)
   {
     if(success)
     {
       dispatch_async(dispatch_get_main_queue(), ^{
         [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
         [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(orientationChanged:)
                                                      name:UIDeviceOrientationDidChangeNotification
                                                    object:[UIDevice currentDevice]];
       });
       NSLog(@"Verified");
     }
     else
     {
       dispatch_async(dispatch_get_main_queue(), ^{
         [self performSegueWithIdentifier:@"identificationFailed" sender:nil];
       });
       NSLog(@"Failed");
     }
   }];
  return;
}

- (BOOL) checkAvailibilty
{
  if(@available(iOS 11.0, *))
  {
    if([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil])
      return self.context.biometryType == LABiometryTypeFaceID;
  }
  return FALSE;
}

- (void) orientationChanged:(NSNotification *)note
{
  UIDevice * device = note.object;
  switch(device.orientation)
  {
    case UIDeviceOrientationPortrait:
      NSLog(@"Orientation: Portrait");
      break;
    case UIDeviceOrientationLandscapeLeft:
      NSLog(@"Orientation: Left");
      [self performSegueWithIdentifier:@"orientationChangedDetected" sender:nil];
      break;
    case UIDeviceOrientationLandscapeRight:
      NSLog(@"Orientation: Right");
      [self performSegueWithIdentifier:@"orientationChangedDetected" sender:nil];
      break;
    default:
      break;
  };
}


@end
