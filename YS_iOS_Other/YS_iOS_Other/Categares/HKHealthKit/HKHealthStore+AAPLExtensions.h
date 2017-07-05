/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Contains shared helper methods on HKHealthStore that are specific to Fit's use cases.
*/

@import HealthKit;

@interface HKHealthStore (AAPLExtensions)

// Fetches the single most recent quantity of the specified type.
- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *mostRecentQuantity, NSError *error))completion;


- (void)aapl_saveSampleOfType:(HKQuantityType *)quantityType
                     quantity:(HKQuantity *)quantity
                    startDate:(NSDate *)startDate
                      endDate:(NSDate *)endDate
                   complition:(void (^)(BOOL success, NSError * error))complitionBlock;

@end
