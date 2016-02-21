//
//  RTEDirectionsResult.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>

@interface RTEDirectionsResult : NSObject

@property (nonatomic,readonly) CLLocationCoordinate2D origin;
@property (nonatomic,readonly) CLLocationCoordinate2D destination;

// We expose the count and wayPointAtIndex: to provide a means
// to access the way points. Since we can't have an array of
// CLLocationCoorindate2D, this is the cleaneast option for an API
//
@property (nonatomic,readonly) NSUInteger wayPointCount;
- (CLLocationCoordinate2D)wayPointAtIndex:(NSUInteger)index;

// A collection of RTERoute objects
//
@property (nonatomic,readonly) NSArray *routes;

@end
