//
//  RTEForwardGeocodeParameters.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEForwardGeocodeParameters.h"

@implementation RTEForwardGeocodeParameters

- (NSArray *)queryItems
{
    NSMutableArray *queryItems = [NSMutableArray array];
    
    if (self.countryCode != RTECountryCodeAll) {
        
        NSString *code = [self queryStringForCountryCode:self.countryCode];
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:@"cc" value:code];
        [queryItems addObject:item];
    }
    
    if (CLLocationCoordinate2DIsValid(self.proximityCoordiante)) {
        
        NSString *location = [NSString stringWithFormat:@"%f,%f", self.proximityCoordiante.latitude, self.proximityCoordiante.longitude];
        NSURLQueryItem *item = [NSURLQueryItem queryItemWithName:@"proximity" value:location];
        [queryItems addObject:item];
    }
    
    return queryItems;
}

- (NSString *)queryStringForCountryCode:(RTECountryCode)code
{
    switch (code) {
        case RTECountryCodeUSA:
            return @"US";
        default:
            return nil;
    }
}

@end
