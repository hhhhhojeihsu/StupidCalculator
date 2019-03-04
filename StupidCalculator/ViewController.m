//
//  ViewController.m
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/4.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import "ViewController.h"
#define UPDATE_LABEL self.result.text = self.SCCalculator_.shownString

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.SCCalculator_ = [[SCCalculator alloc] init];
}

- (IBAction)acButton:(id)sender
{
  [_SCCalculator_.shownString setString:@"0"];
  _SCCalculator_.intResult = 0;
  _SCCalculator_.doubleResult = 0.0f;
  UPDATE_LABEL;
}

- (IBAction)pmButton:(id)sender {
}

- (IBAction)percentButton:(id)sender {
}

- (IBAction)divideButton:(id)sender {
}

- (IBAction)sevenButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"7"];
  UPDATE_LABEL;
}

- (IBAction)eightButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"8"];
  UPDATE_LABEL;
}

- (IBAction)nineButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"9"];
  UPDATE_LABEL;
}

- (IBAction)multiButton:(id)sender {
}

- (IBAction)fourButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"4"];
  UPDATE_LABEL;
}

- (IBAction)fiveButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"5"];
  UPDATE_LABEL;
}

- (IBAction)sixButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"6"];
  UPDATE_LABEL;
}

- (IBAction)minusButton:(id)sender
{
  
}

- (IBAction)oneButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"1"];
  UPDATE_LABEL;
}

- (IBAction)twoButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"2"];
  UPDATE_LABEL;
}

- (IBAction)threeButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"3"];
  UPDATE_LABEL;
}

- (IBAction)plusButton:(id)sender {
}

- (IBAction)zeroButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"0"];
  UPDATE_LABEL;
}

- (IBAction)twoZeroButton:(id)sender
{
  [self.SCCalculator_ inputNumber:@"00"];
  UPDATE_LABEL;
}

- (IBAction)dotButton:(id)sender {
}

- (IBAction)equalButton:(id)sender {
}
@end
