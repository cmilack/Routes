//
//  RTEDirectionsTaskParameters.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTEEnumerations.h"
#import "RTEQueryItemProvider.h"
#import "RTECoordinateCollection.h"

typedef enum : NSUInteger {
    RTEDirectionsInstructionText,
    RTEDirectionsInstructionHTML
} RTEDirectionsInstruction;

@interface RTEDirectionsTaskParameters : NSObject <RTEQueryItemProvider>

+ (instancetype)paramsWithOrigin:(CLLocationCoordinate2D)origin
                     destination:(CLLocationCoordinate2D)destination;

@property (nonatomic,readonly) RTECoordinateCollection *waypoints;

// Defaults to RTECountryCodeAll
//
@property (nonatomic) RTEProfile profile;

// Defaults to NO
//
@property (nonatomic) BOOL includeAlternatives;

// Defaults to NO
//
@property (nonatomic) BOOL includeSteps;

// The API allows the user to select between GEOJson and Polyline but we will
// provide a simpler API that always give a user an MGLPolyline in the result
//
@property (nonatomic) BOOL returnGeometry;

// Defaults to RTEDirectionsInstructionText
//
@property (nonatomic) RTEDirectionsInstruction instructions;

@end
