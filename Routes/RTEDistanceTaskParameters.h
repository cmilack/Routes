//
//  RTEDistanceTaskParameters.h
//  Routes
//
//  Created by Christopher Milack on 2/19/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RTEEnumerations.h"
#import "RTECoordinateCollection.h"

@interface RTEDistanceTaskParameters : NSObject

// Static initialize for the most basic case - the distance from A to B
// Defaults to RTEDistanceProfileDriving
//
+ (instancetype)paramsWithStart:(CLLocationCoordinate2D)start end:(CLLocationCoordinate2D)end;

@property (nonatomic,readonly) RTECoordinateCollection *coordinates;

@property (nonatomic) RTEProfile profile;

@end
