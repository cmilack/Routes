//
//  RTEDirectionsRequestFactory.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDirectionsRequestFactory.h"
#import "RTEDirectionsTaskParameters.h"
#import "RTEEnumerations.h"
#import "MGLAccountManager+RTEExtensions.h"
#import "RTECoordinateCollection.h"

@implementation RTEDirectionsRequestFactory

// https://api.mapbox.com/v4/directions/mapbox.driving/-122.42,37.78;-77.03,38.91.json?
// access_token=pk.eyJ1IjoiY21pbGFjayIsImEiOiJtdUxlQmlNIn0.bDID_agbnwa76H5oWf7idQ
//
+ (NSURLRequest *)urlRequestWithParameters:(RTEDirectionsTaskParameters *)params
{
    // Add the query items generated from parameters
    //
    NSMutableArray *queryItems = [NSMutableArray array];
    [queryItems addObjectsFromArray:[params queryItems]];
    
    // Ad the client access security item
    //
    NSURLQueryItem *securityItem = [MGLAccountManager rte_clientAccessQueryItem];
    if (securityItem) {
        [queryItems addObject:securityItem];
    }

    NSString *profile = RTEProfileAsString(params.profile);
    NSString *waypointsText = [self urlFormattedWaypoints:params.waypoints];
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/v4/directions/mapbox.%@/%@.json",profile, waypointsText];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = queryItems;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:components.URL];
    return request;
}

+ (NSString *)urlFormattedWaypoints:(RTECoordinateCollection *)waypoints
{
    NSMutableArray *coordinates = [NSMutableArray array];
    for (NSInteger i= 0; i < waypoints.count; i++) {
        
        CLLocationCoordinate2D coordinate = [waypoints pointAtIndex:i];
        NSString *formattedCoordinate = [NSString stringWithFormat:@"%f,%f",coordinate.longitude, coordinate.latitude];
        [coordinates addObject:formattedCoordinate];
    }
    return [coordinates componentsJoinedByString:@";"];
}

@end
