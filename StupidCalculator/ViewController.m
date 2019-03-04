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
  self.result.text = @"0";
  [_SCCalculator_.shownString setString:@""];
  _SCCalculator_.intResult = 0;
  _SCCalculator_.doubleResult = 0.0f;
}

- (IBAction)pmButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"-"];
  UPDATE_LABEL;
}

- (IBAction)percentButton:(id)sender {
}

- (IBAction)divideButton:(id)sender {
}

- (IBAction)sevenButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"7"];
  UPDATE_LABEL;
}

- (IBAction)eightButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"8"];
  UPDATE_LABEL;
}

- (IBAction)nineButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"9"];
  UPDATE_LABEL;
}

- (IBAction)multiButton:(id)sender {
}

- (IBAction)fourButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"4"];
  UPDATE_LABEL;
}

- (IBAction)fiveButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"5"];
  UPDATE_LABEL;
}

- (IBAction)sixButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"6"];
  UPDATE_LABEL;
}

- (IBAction)minusButton:(id)sender
{
  
}

- (IBAction)oneButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"1"];
  UPDATE_LABEL;
}

- (IBAction)twoButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"2"];
  UPDATE_LABEL;
}

- (IBAction)threeButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"3"];
  UPDATE_LABEL;
}

- (IBAction)plusButton:(id)sender {
}

- (IBAction)zeroButton:(id)sender
{
  if([self.SCCalculator_ inputFromView:@"0"])
    UPDATE_LABEL;
}

- (IBAction)twoZeroButton:(id)sender
{
  if([self.SCCalculator_ inputFromView:@"00"])
    UPDATE_LABEL;
}

- (IBAction)dotButton:(id)sender
{
  [self.SCCalculator_ inputFromView:@"."];
  UPDATE_LABEL;
}

- (IBAction)equalButton:(id)sender {
}
@end
