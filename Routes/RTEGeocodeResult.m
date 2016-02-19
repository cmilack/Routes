//
//  RTEGeocodeResult.m
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEGeocodeResult.h"

@implementation RTEGeocodeResult

- (instancetype)initWithDictionary:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        [self loadFromJson:json];
    }
    return self;
}

- (void)loadFromJson:(NSDictionary *)json
{
    NSArray *centerCoordinates = [json objectForKey:@"center"];
    NSNumber *longitude = centerCoordinates.firstObject;
    NSNumber *latitude = centerCoordinates.lastObject;
    
    self.center = CLLocationCoordinate2DMake(longitude.doubleValue, latitude.doubleValue);
    
    self.text = [json objectForKey:@"text"];
    self.placeName = [json objectForKey:@"place_name"];
    self.featureId = [json objectForKey:@"id"];
}

@end
