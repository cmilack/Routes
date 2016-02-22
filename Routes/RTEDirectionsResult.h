//
//  RTEDirectionsResult.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>
#import "RTECoordinateCollection.h"

@interface RTEDirectionsResult : NSObject

// Origin and destination positions
//
@property (nonatomic,readonly) CLLocationCoordinate2D origin;
@property (nonatomic,readonly) CLLocationCoordinate2D destination;

// The input coordinates used to generate the route
//
@property (nonatomic,readonly) RTECoordinateCollection *waypoints;

// A collection of RTERoute objects
//
@property (nonatomic,readonly) NSArray *routes;

@end
