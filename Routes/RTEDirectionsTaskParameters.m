//
//  RTEDirectionsTaskParameters.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsTaskParameters.h"

@implementation RTEDirectionsTaskParameters

+ (instancetype)paramsWithOrigin:(CLLocationCoordinate2D)origin
                     destination:(CLLocationCoordinate2D)destination
{
    RTEDirectionsTaskParameters *params = [[RTEDirectionsTaskParameters alloc] init];
    [params.waypoints addPoint:origin];
    [params.waypoints addPoint:destination];
    return params;
}

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
    return @[];
}

@end
