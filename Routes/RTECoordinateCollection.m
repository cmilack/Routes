//
//  RTECoordinateCollection.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTECoordinateCollection.h"

@interface RTECoordinateCollection()

@property (nonatomic) NSMutableArray *coordinates;

@end

@implementation RTECoordinateCollection

- (CLLocationCoordinate2D)pointAtIndex:(NSUInteger)index
{
    CLLocationCoordinate2D coordinate;
    NSValue *value = [self.coordinates objectAtIndex:index];
    [value getValue:&coordinate];
    
    return coordinate;
}

- (void)addPoint:(CLLocationCoordinate2D)point
{
    NSValue *startValue = [NSValue valueWithBytes:&point objCType:@encode(CLLocationCoordinate2D)];
    [self.coordinates addObject:startValue];
}

- (void)insertPoint:(CLLocationCoordinate2D)point atIndex:(NSUInteger)index
{
    NSValue *startValue = [NSValue valueWithBytes:&point objCType:@encode(CLLocationCoordinate2D)];
    [self.coordinates insertObject:startValue atIndex:index];
}

- (void)removePointAtIndex:(NSUInteger)index
{
    [self.coordinates removeObjectAtIndex:index];
}

- (void)removeAllPoints
{
    [self.coordinates removeAllObjects];
}

- (NSUInteger)count
{
    return self.coordinates.count;
}

@end
