//
//  RTEDirectionsTaskParameters.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsTaskParameters.h"

@implementation RTEDirectionsTaskParameters

- (instancetype)init
{
    self = [super init];
    if (self) {
        _waypoints = [[RTECoordinateCollection alloc] init];
    }
    return self;
}

- (NSArray *)queryItems
{
    NSAssert(NO, @"Not yet implemented");
    return nil;
}

@end
