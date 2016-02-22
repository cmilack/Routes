//
//  RTERoute.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapbox/Mapbox.h>

@interface RTERoute : NSObject

- (instancetype)initWithJson:(NSDictionary *)json;

@property (nonatomic,readonly) NSString *summary;

// Route distance in meters
//
@property (nonatomic,readonly) NSUInteger distance;

// Estimated travel time in seconds
//
@property (nonatomic,readonly) NSUInteger duration;

// The geometry for the route
//
@property (nonatomic,readonly) MGLPolyline *geometry;

// The steps (roads, maneuvers, etc.) involved in the route
//
@property (nonatomic,readonly) NSArray *steps;

@end
