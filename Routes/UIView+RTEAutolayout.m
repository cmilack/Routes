//
//  UIView+RTEAutolayout.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "UIView+RTEAutolayout.h"

@implementation UIView (RTEAutolayout)

- (void)rte_fitInSuperViewFromTop:(float)top
                             left:(double)left
                            right:(double)right
                           bottom:(double)bottom
{
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.superview
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:top];
    
    
    
    [self.superview addConstraint:topConstraint];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:NSLayoutAttributeLeading
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.superview
                                                                      attribute:NSLayoutAttributeLeading
                                                                     multiplier:1
                                                                       constant:left];
    
    
    
    [self.superview addConstraint:leftConstraint];
    

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.superview
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1
                                                                      constant:right];
    
    
    
    [self.superview addConstraint:rightConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.superview
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:bottom];
    
    
    
    [self.superview addConstraint:bottomConstraint];
}

@end
