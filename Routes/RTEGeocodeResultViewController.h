//
//  RTEGeocodeResultViewController.h
//  Routes
//
//  Created by Christopher Milack on 2/20/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTEGeocodeResult;
@class RTEGeocodeResultViewController;

@protocol RTEGeocodeResultViewControllerDelegate <NSObject>

- (void)geocodeResultViewControllerDidSelectDirectionsOption:(RTEGeocodeResultViewController *)viewController;

@end

@interface RTEGeocodeResultViewController : UITableViewController

- (instancetype)initWithGeocodeResult:(RTEGeocodeResult *)result;

@property (nonatomic,readonly) RTEGeocodeResult *result;

@property (nonatomic,weak) id<RTEGeocodeResultViewControllerDelegate> delegate;

@end
