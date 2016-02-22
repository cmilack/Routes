//
//  RTEEnumerations.m
//  Routes
//
//  Created by Christopher Milack on 2/21/16.
//  Copyright © 2016 Christopher Milack. All rights reserved.
//

#import "RTEEnumerations.h"

NSString *RTECountryCodeAsString(RTECountryCode code)
{
    return nil;
}

NSString *RTEProfileAsString(RTEProfile profile)
{
    switch (profile) {
        case RTEProfileDriving:
            return @"driving";
        case RTEProfileCycling:
            return @"cycling";
        case RTEProfileWalking:
            return @"walking";
        default:
            return nil;
    }
}