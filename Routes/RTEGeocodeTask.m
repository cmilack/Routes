//
//  RTEGeocodeTask.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEGeocodeTask.h"
#import "RTEGeocodeTaskParameters.h"
#import "RTEGeocodeResult.h"
#import "MGLAccountManager+RTEExtensions.h"

@implementation RTEGeocodeTask

- (NSURLSessionTask *)executeGeocodeWithQuery:(NSString *)query
                            completion:(RTEGeocodeTaskCompletionBlock)completion;
{
    return [self executeGeocodeWithQuery:query parameters:nil completion:completion];
}

- (NSURLSessionTask *)executeGeocodeWithQuery:(NSString *)query
                            parameters:(RTEGeocodeTaskParameters *)params
                            completion:(RTEGeocodeTaskCompletionBlock)completion
{
    __block NSURLSessionDataTask *task;
    
    void (^serviceCompletion)(NSData *, NSURLResponse *, NSError *);
    serviceCompletion = ^(NSData *data, NSURLResponse * response, NSError * error){
        
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil,error);
            });
            return;
        }
        
        NSError *jsonError;
        id jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!jsonResult) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(task, nil,jsonError);
            });
            
            return;
        }
        
        NSMutableArray *results = [NSMutableArray array];
        for (NSDictionary *json in [jsonResult objectForKey:@"features"]){
            
            RTEGeocodeResult *result = [[RTEGeocodeResult alloc] initWithJsonResult:json];
            [results addObject:result];
        }
        
        // We have valid json - convert that into geocode result objects
        //
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(task, results, nil);
        });
    };
    
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    query = [query stringByReplacingOccurrencesOfString:@"," withString:@"+"];
    query = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"https://api.mapbox.com/geocoding/v5/mapbox.places/%@.json",query];
    
    NSURLComponents *components = [NSURLComponents componentsWithString:urlString];
    
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSURLQueryItem *securityItem = [MGLAccountManager rte_clientAccessQueryItem];
    if (securityItem) {
        [queryItems addObject:securityItem];
    }

    if (params) {
        [queryItems addObjectsFromArray:[params queryItems]];
    }
    
    components.queryItems = queryItems;
    
    task = [[NSURLSession sharedSession] dataTaskWithURL:components.URL completionHandler:serviceCompletion];
    [task resume];
    
    return task;
}


- (NSURLSessionTask *)executeReverseGeocodeWithLocation:(CLLocationCoordinate2D)location
                                             completion:(RTEReverseGeocodeTaskCompletionBlock)completion
{
    NSAssert(NO, @"Not Yet Implemented");
    return nil;
}


@end
