//
//  ViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <WebKit/WebKit.h>
#import "SCCalculator.h"
#import <LocalAuthentication/LAContext.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel* result;
@property (weak, nonatomic) IBOutlet UIButton* acOutlet;

- (IBAction)acButton:(id)sender;
- (IBAction)pmButton:(id)sender;
- (IBAction)percentButton:(id)sender;
- (IBAction)divideButton:(id)sender;
- (IBAction)sevenButton:(id)sender;
- (IBAction)eightButton:(id)sender;
- (IBAction)nineButton:(id)sender;
- (IBAction)multiButton:(id)sender;
- (IBAction)fourButton:(id)sender;
- (IBAction)fiveButton:(id)sender;
- (IBAction)sixButton:(id)sender;
- (IBAction)minusButton:(id)sender;
- (IBAction)oneButton:(id)sender;
- (IBAction)twoButton:(id)sender;
- (IBAction)threeButton:(id)sender;
- (IBAction)plusButton:(id)sender;
- (IBAction)zeroButton:(id)sender;
- (IBAction)twoZeroButton:(id)sender;
- (IBAction)dotButton:(id)sender;
- (IBAction)equalButton:(id)sender;

@property (strong, nonatomic) SCCalculator* SCCalculator_;

- (void) checkException;
- (void) itemDidFinishPlaying:(NSNotification*) notification;
- (void) checkLength;
- (void) checkResult;
- (void) doneButtonClicked;
- (void) orientationChanged:(NSNotification *)note;
- (void) easterEgg5566;
- (void) easterEgg66;
- (void) easterEgg8612;
- (void) easterEgg100;
- (void) easterEgg10;
- (void) easterEgg1011;


@end

