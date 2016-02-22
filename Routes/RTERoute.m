//
//  RTERoute.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTERoute.h"
#import "RTERouteStep.h"

@implementation RTERoute

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self setPropertiesWithJson:json];
    }
    return self;
}

- (void)setPropertiesWithJson:(NSDictionary *)json
{
    _summary = [json objectForKey:@"summary"];
    
    NSNumber *distance = [json objectForKey:@"distance"];
    _distance = distance.doubleValue;
    
    NSNumber *duration = [json objectForKey:@"duration"];
    _duration = duration.doubleValue;
    
    NSMutableArray *steps = [NSMutableArray array];
    NSArray *stepsJson = [json objectForKey:@"steps"];
    for (NSDictionary *stepJson in stepsJson){
        
        RTERouteStep *step = [[RTERouteStep alloc] initWithJson:stepJson];
        [steps addObject:step];
    }
    _steps = steps;

    NSDictionary *geometry = [json objectForKey:@"geometry"];
    NSArray *coordinatesJson = [geometry objectForKey:@"coordinates"];
    
    CLLocationCoordinate2D polylineCoordiantes[coordinatesJson.count];
    
    for (int i = 0; i < coordinatesJson.count; i++){

        NSArray *coordinateJson = [coordinatesJson objectAtIndex:i];
        NSNumber *longitude = coordinateJson.firstObject;
        NSNumber *latitude = coordinateJson.lastObject;
        polylineCoordiantes[i] = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    }
    _geometry = [MGLPolyline polylineWithCoordinates:polylineCoordiantes count:coordinatesJson.count];
}

@end
