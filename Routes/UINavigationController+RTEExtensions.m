//
//  UINavigationController+UINavigationController_RTEExtensions.m
//  Routes
//
//  Created by Christopher Milack on 2/17/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "UINavigationController+RTEExtensions.h"

@implementation UINavigationController (RTEExtensions)

- (void)rte_toggleNavigationBarVisibility
{
    BOOL hidden = self.isNavigationBarHidden;
    [self setNavigationBarHidden:!hidden animated:YES];
}

@end
