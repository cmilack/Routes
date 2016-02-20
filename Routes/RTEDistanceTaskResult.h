//
//  RTEDistanceTaskResult.h
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RTEDistanceTaskResult : NSObject

// Get the coordinate for a specified stop index. This is the same as the input
// data stops defined in RTEDistanceTaskParameters but we provide access from here
// for convenience
//
- (CLLocationCoordinate2D)inputLocationAtIndex:(NSUInteger)index;

// Returns the distance between two stops
//
- (double)distanceFromStopAtIndex:(NSUInteger)start toIndex:(NSUInteger)end;

@end
