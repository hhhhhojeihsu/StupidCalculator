//
//  ViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#pragma mark - Macro

#define UPDATE_LABEL self.result.text = self.SCCalculator_.shownString;

#define CHECK_EXCEPTION_RESULT \
[self checkException];\
[self checkResult];

#define SET_C_DETECT_LENGTH [self.acOutlet setTitle:@"C" forState:UIControlStateNormal];\
[self checkLength];


#pragma mark - View

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.SCCalculator_ = [[SCCalculator alloc] init];
  
  // Start monitor orientation change
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(orientationChanged:)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:[UIDevice currentDevice]];
}

// Override. Set the calcuation screen's status bar to white
- (UIStatusBarStyle) preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

#pragma mark - Button Action

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


#pragma mark - Divide Exception

- (void) checkException
{
  // Invoke when executing divide
  if(self.SCCalculator_.divideException)
  {
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:@"阿囉哈"
                                        message:@"國小生都知道不能除以 0 了，除非你是國小生" //!OCLINT Chinese
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


#pragma mark - Stahp Video

- (void) itemDidFinishPlaying:(NSNotification*) notification //!OCLINT
{
  // When video is done playing, dismiss video controller and remove observer
  [self dismissViewControllerAnimated:YES completion:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:AVPlayerItemDidPlayToEndTimeNotification
                                                object:nil];
}

- (void) checkLength
{
  if([self.result.text length] <= 12)
    return;
  
  NSLog(@"Stahp");
  
  self.result.text = @"0";
  [self.SCCalculator_ reset];
  
  // Load video
  NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"Stahp" ofType:@"mp4"];
  NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
  AVPlayer *player = [AVPlayer playerWithURL:videoURL];
  AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
  playerViewController.player = player;
  
  // Regist observer
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(itemDidFinishPlaying:)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                             object:nil];
  
  // Play video
  [playerViewController.player play];
  [self presentViewController:playerViewController animated:YES completion:nil];
}


#pragma mark - Easter Egg Entry

- (void) checkResult
{
  switch([self.result.text intValue])
  {
  case 5566:
    [self easterEgg5566];
    break;
  case 66:
    [self easterEgg66];
    break;
  case 8612:
    [self easterEgg8612];
    break;
  case 100:
    [self easterEgg100];
    break;
  case 10:
    [self easterEgg10];
    break;
  case 1010:
    [self easterEgg1010];
    break;
  default:
    break;
  }
  return;
}


#pragma mark - Easter Egg Implementation

- (void) easterEgg5566
{
  // Create and represent webview
  WKWebViewConfiguration* webConfiguration = [[WKWebViewConfiguration alloc] init];
  WKWebView* webView = [[WKWebView alloc]
                        initWithFrame:CGRectMake(0,
                                                 70,
                                                 self.view.frame.size.width,
                                                 self.view.frame.size.height - 70)
                        configuration:webConfiguration];
  NSURL* webURL = [NSURL URLWithString:@"https://zh.wikipedia.org/zh-tw/5566"];
  NSURLRequest* request = [NSURLRequest requestWithURL:webURL];
  webView.tag = 5566;
  [webView loadRequest:request];
  [self.view addSubview:webView];
  
  // Create done button
  UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  CGRect doneButtonFrame = CGRectMake(0, 25, 100, 44);
  doneButton.frame = doneButtonFrame;
  doneButton.tag = 5567;
  [doneButton setTitle:@"Done" forState:UIControlStateNormal];
  [doneButton addTarget:self
                 action:@selector(doneButtonClicked)
       forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:doneButton];
}

- (void) doneButtonClicked
{
  // Done button pressed in 5566 webview
  [[self.view viewWithTag:5566] removeFromSuperview];
  [[self.view viewWithTag:5567] removeFromSuperview];
  [self.SCCalculator_ reset];
  self.result.text = @"0";
  return;
}

- (void) easterEgg66
{
  // Create image
  UIImageView *order66 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 307, 212)];
  order66.center = self.view.center;
  order66.image = [UIImage imageNamed:@"order66"];
  order66.tag = 66;
  [self.view addSubview:order66];
  
  // Set dim animation
  [UIImageView animateWithDuration:5 animations:
   ^{
     order66.alpha = 0.0f;
   }
                        completion:^(BOOL finished)
   {
     [[self.view viewWithTag:66] removeFromSuperview];
     [self.SCCalculator_ reset];
     self.result.text = @"0";
   }];
}

- (void) easterEgg8612
{
  // Enter camera view
  [self performSegueWithIdentifier:@"cameraSegue" sender:nil];
}

- (void) easterEgg100
{
  [self performSegueWithIdentifier:@"gijoeTableSegue" sender:nil];
}

- (void) easterEgg10
{
  if([MFMailComposeViewController canSendMail])
  {
    MFMailComposeViewController* mailCompose = [[MFMailComposeViewController alloc] init];
    mailCompose.mailComposeDelegate = self;
    [mailCompose setSubject:@"Error report"];
    [mailCompose setMessageBody:@"<h2>鍾山曉</h2>" isHTML:TRUE];
    [mailCompose setToRecipients:@[@"help@example.com"]];
    
    [self presentViewController:mailCompose animated:TRUE completion:nil];
  }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) easterEgg1010
{
  [self performSegueWithIdentifier:@"LocationViewSegue" sender:nil];
}

#pragma mark - Orientation

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
