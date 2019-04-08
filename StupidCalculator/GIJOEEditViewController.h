//
//  GIJOEEditViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/4/1.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIJOEEditViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *linkTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *timePicker;

- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;

@property (nonatomic) NSInteger min;
@property (nonatomic) NSInteger sec;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *link;

@end

NS_ASSUME_NONNULL_END
