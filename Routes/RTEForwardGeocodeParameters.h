//
//  RTEForwardGeocodeParameters.h
//  Routes
//
//  Created by Christopher Milack on 2/18/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RTEQueryItemProvider.h"

@protocol RTEQueryItemProvider;

typedef enum : NSUInteger {
    RTECountryCodeAll,
    RTECountryCodeUSA,
} RTECountryCode;


@interface RTEForwardGeocodeParameters : NSObject <RTEQueryItemProvider>

// Optional: Support for country basd searches
//
@property (nonatomic) RTECountryCode countryCode;

// Optional: Support for proximity based searches
//
@property (nonatomic) CLLocationCoordinate2D proximityCoordiante;

@end
