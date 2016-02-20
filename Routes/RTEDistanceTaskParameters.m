//
//  RTEDistanceTaskParameters.m
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceTaskParameters.h"

@interface RTEDistanceTaskParameters()

@property (nonatomic) NSMutableArray *stops;

@end

@implementation RTEDistanceTaskParameters

- (instancetype)init
{
    self = [super init];
    if (self) {
        _stops = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)paramsWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end
{
    RTEDistanceTaskParameters *params = [[RTEDistanceTaskParameters alloc] init];
    
    // Add points to the array
    //
    [params addPoint:start];
    [params addPoint:end];

    return params;
}

- (CLLocationCoordinate2D)pointAtIndex:(NSUInteger)index
{
    CLLocationCoordinate2D coordinate;
    NSValue *value = [self.stops objectAtIndex:index];
    [value getValue:&coordinate];
    
    return coordinate;
}

- (void)addPoint:(CLLocationCoordinate2D)point
{
    NSValue *startValue = [NSValue valueWithBytes:&point objCType:@encode(CLLocationCoordinate2D)];
    [self.stops addObject:startValue];
}

- (void)insertPoint:(CLLocationCoordinate2D)point atIndex:(NSUInteger)index
{
    NSValue *startValue = [NSValue valueWithBytes:&point objCType:@encode(CLLocationCoordinate2D)];
    [self.stops insertObject:startValue atIndex:index];
}

- (void)removePointAtIndex:(NSUInteger)index
{
    [self.stops removeObjectAtIndex:index];
}

- (void)removeAllPoints
{
    [self.stops removeAllObjects];
}

- (NSUInteger)numberOfPoints
{
    return self.stops.count;
}

@end
