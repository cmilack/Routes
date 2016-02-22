//
//  RTERouteStep.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// An array of route steps, the smallest unit of a route. A step consists
// of a maneuver such as a turn or merge, followed by a distance of travel
// along a single way to the subsequent step.
//
@interface RTERouteStep : NSObject

- (instancetype)initWithJson:(NSDictionary *)json;

// Step distance in meters
//
@property (nonatomic,readonly) NSUInteger distance;

// Step duration in seconds
//
@property (nonatomic,readonly) NSUInteger duration;

// The mode of travel - ex. driving
//
@property (nonatomic,readonly) NSString *mode;

// The name of the way along which travel proceeds
//
@property (nonatomic,readonly) NSString *wayName;

// Could provide an enum here but simple to just use
// the string value of direction as we received it from the server.
// This also makes sense because the user will likely always want
// the direction as a string
//
@property (nonatomic,readonly) NSString *direction;

// The clockwise angle from true north to the direction of travel
// immediately following the maneuver.
//
@property (nonatomic,readonly) double heading;

#warning Add Maneuver support

//// Might be better as an enum...
////
//@property (nonatomic,readonly) NSString *manuever;
//
//@property (nonatomic,readonly) CLLocationCoordinate2D maneuverLocation;
//
//@property (nonatomic,readonly) CLLocationCoordinate2D maneuverInstruction;
//
//// Might be better as an enum...
////
//@property (nonatomic,readonly) NSString *manueverMode;

@end
