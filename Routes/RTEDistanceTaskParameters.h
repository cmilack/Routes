//
//  RTEDistanceTaskParameters.h
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum : NSUInteger {
    RTEDistanceTaskProfileDriving,
    RTEDistanceTaskProfileWalking,
    RTEDistanceTaskProfileCycling,
} RTEDistanceTaskProfile;

@interface RTEDistanceTaskParameters : NSObject

// Static initialize for the most basic case - the distance from A to B
// Defaults to RTEDistanceProfileDriving
//
+ (instancetype)paramsWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end;

// Input point API
//
- (CLLocationCoordinate2D)pointAtIndex:(NSUInteger)index;

- (void)addPoint:(CLLocationCoordinate2D)point;

- (void)insertPoint:(CLLocationCoordinate2D)point atIndex:(NSUInteger)index;

- (void)removePointAtIndex:(NSUInteger)index;

- (void)removeAllPoints;

- (NSUInteger)numberOfPoints;

@property (nonatomic) RTEDistanceTaskProfile profile;

@end
