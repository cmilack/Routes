//
//  RTEGeocodeResultViewController.h
//  Routes
//
//  Created by Christopher Milack on 2/20/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTEForwardGeocodeResult;

@interface RTEGeocodeResultViewController : UITableViewController

- (instancetype)initWithGeocodeResult:(RTEForwardGeocodeResult *)result;

@property (nonatomic,readonly) RTEForwardGeocodeResult *result;

@end
