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

// Route distance in meters
//
@property (nonatomic,readonly) NSUInteger distance;

// Estimated travel time in seconds
//
@property (nonatomic,readonly) NSUInteger travelTime;

@property (nonatomic,readonly) MGLPolyline *geometry;



@end
