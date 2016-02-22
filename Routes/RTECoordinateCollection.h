//
//  RTECoordinateCollection.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// A collection of CLLocationCoordinate2D. We use this wrapper class as a convenience
// when working this struct data type (that can't be added directly to NSArray)
//
@interface RTECoordinateCollection : NSObject

// Input point API
//
- (CLLocationCoordinate2D)pointAtIndex:(NSUInteger)index;

- (void)addPoint:(CLLocationCoordinate2D)point;

- (void)insertPoint:(CLLocationCoordinate2D)point atIndex:(NSUInteger)index;

- (void)removePointAtIndex:(NSUInteger)index;

- (void)removeAllPoints;

- (NSUInteger)count;

@end
