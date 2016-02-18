//
//  UIView+RTEAutolayout.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RTEAutolayout)

- (void)rte_fitInSuperViewFromTop:(float)top
                             left:(double)left
                            right:(double)right
                           bottom:(double)bottom;

@end
