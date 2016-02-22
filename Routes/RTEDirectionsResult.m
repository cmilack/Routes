//
//  RTEDirectionsResult.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsResult.h"
#import "RTERoute.h"

@implementation RTEDirectionsResult

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
    NSDictionary *destination = [json objectForKey:@"destination"];
    NSDictionary *geometry = [destination objectForKey:@"geometry"];
    NSArray *coordinates = [geometry objectForKey:@"coordinates"];
    NSNumber *longitude = coordinates.firstObject;
    NSNumber *latitude = coordinates.lastObject;
    _destination = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    
    NSDictionary *origin = [json objectForKey:@"origin"];
    geometry = [origin objectForKey:@"geometry"];
    coordinates = [geometry objectForKey:@"coordinates"];
    longitude = coordinates.firstObject;
    latitude = coordinates.lastObject;
    _origin = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
    
    NSMutableArray *routes = [NSMutableArray array];
    NSArray *routesJson = [json objectForKey:@"routes"];
    for (NSDictionary *routeJson in routesJson){
        
        RTERoute *route = [[RTERoute alloc] initWithJson:routeJson];
        [routes addObject:route];
    }
    _routes = routes;
}

@end
