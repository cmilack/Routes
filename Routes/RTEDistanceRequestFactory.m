//
//  RTEDistanceRequestFactory.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEDistanceRequestFactory.h"
#import "RTEDistanceTaskParameters.h"
#import "MGLAccountManager+RTEExtensions.h"
#import "RTEEnumerations.h"

@implementation RTEDistanceRequestFactory

+ (NSURLRequest *)urlRequestWithParameters:(RTEDistanceTaskParameters *)params
{
    NSString *profile = RTEProfileAsString(params.profile); // [self profileNameFromProfile:params.profile];
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/distances/v1/mapbox/%@",profile];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    components.queryItems = @[[MGLAccountManager rte_clientAccessQueryItem]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:components.URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    
    #warning handle this error - do we need a error param on this method?
    
    NSError *error;
    NSData *postData = [RTEDistanceRequestFactory requestDataFromParams:params error:&error];
    [request setHTTPBody:postData];

    return request;
}

+ (NSData *)requestDataFromParams:(RTEDistanceTaskParameters *)params error:(NSError **)error
{
    NSUInteger numOfStops = params.coordinates.count;
    NSMutableArray *stops = [NSMutableArray array];
    
    for (int i= 0; i< numOfStops; i++){
        
        CLLocationCoordinate2D point = [params.coordinates pointAtIndex:i];
        NSArray *coordinate = @[@(point.latitude),@(point.longitude)];
        [stops addObject:coordinate];
    }
    
    NSDictionary *coordinates = @{ @"coordinates" : stops };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:coordinates options:0 error:error];
    return postData;
}


@end
