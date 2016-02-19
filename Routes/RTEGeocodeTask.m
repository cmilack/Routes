//
//  RTEGeocodeTask.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEGeocodeTask.h"
#import "RTEForwardGeocodeParameters.h"
#import "RTEMapboxClientHelper.h"
#import "RTEGeocodeResult.h"

@implementation RTEGeocodeTask

- (NSURLSessionTask *)executeWithQuery:(NSString *)query
                            completion:(void(^)(NSURLSessionTask *task,NSArray *results, NSError *error))completion;
{
    return [self executeWithQuery:query parameters:nil completion:completion];
}

- (NSURLSessionTask *)executeWithQuery:(NSString *)query
                            parameters:(RTEForwardGeocodeParameters *)params
                            completion:(void(^)(NSURLSessionTask *task,NSArray *results, NSError *error))completion
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
            
            RTEGeocodeResult *result = [[RTEGeocodeResult alloc] initWithDictionary:json];
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
    
    NSURLQueryItem *securityItem = [RTEMapboxClientHelper clientAccessQueryItem];
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


@end
