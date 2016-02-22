//
//  RTEDistanceTaskParameters.m
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceTaskParameters.h"

@implementation RTEDistanceTaskParameters

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coordinates = [[RTECoordinateCollection alloc] init];
    }
    return self;
}

+ (instancetype)paramsWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end
{
    RTEDistanceTaskParameters *params = [[RTEDistanceTaskParameters alloc] init];
    
    // Add points to the array
    //
    [params.coordinates addPoint:start];
    [params.coordinates addPoint:end];

    return params;
}

@end
