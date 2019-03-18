//
//  GIJOEViewController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/18.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIJOEViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *gijoeImage;
@property (weak, nonatomic) IBOutlet UILabel *gijoeName;
@property (weak, nonatomic) IBOutlet UILabel *gijoeTimestamp;

// When calling prepareForSegue, View does not loaded yet. So we need to
// copy after viewDidLoad
@property (weak, nonatomic) NSString* name;
@property (weak, nonatomic) NSString* timestamp;

@end

NS_ASSUME_NONNULL_END
