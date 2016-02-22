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

@implementation RTEDirectionsRequestFactory

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
    
    
    
    NSString *waypointsText = [self urlFormattedWaypoints];
    NSString *profile = RTEProfileAsString(params.profile);
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/v5/directions/%@/%@.json",profile, waypointsText];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = queryItems;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:components.URL];
    return request;
}

+ (NSString *)urlFormattedWaypoints
{
    return nil;
}

@end
