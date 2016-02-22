//
//  RTEEnumerations.h
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RTECountryCodeAll,
    RTECountryCodeUSA,
} RTECountryCode;

NSString *RTECountryCodeAsString(RTECountryCode code);

typedef enum : NSUInteger {
    RTEProfileDriving,
    RTEProfileWalking,
    RTEProfileCycling,
} RTEProfile;

NSString *RTEProfileAsString(RTEProfile profile);

