//
//  ViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *result;
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


@end

