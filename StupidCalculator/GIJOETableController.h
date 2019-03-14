//
//  GIJOETableController.h
//  StupidCalculator
//
//  Created by 賀傑許 on 2019/3/14.
//  Copyright © 2019 v2iruslab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GIJOETableController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray* table;

@end

NS_ASSUME_NONNULL_END
