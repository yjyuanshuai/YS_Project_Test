/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Contains shared helper methods on HKHealthStore that are specific to Fit's use cases.
*/

#import "HKHealthStore+AAPLExtensions.h"

@implementation HKHealthStore (AAPLExtensions)

// 查找
- (void)aapl_mostRecentQuantitySampleOfType:(HKQuantityType *)quantityType
                                  predicate:(NSPredicate *)predicate
                                 completion:(void (^)(HKQuantity *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:predicate limit:1 sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            
            return;
        }
        
        if (completion) {
            // If quantity isn't in the database, return nil in the completion block.
            HKQuantitySample *quantitySample = results.firstObject;
            HKQuantity *quantity = quantitySample.quantity;
            
            completion(quantity, error);
        }
    }];
    
    [self executeQuery:query];
}

// 存入
- (void)aapl_saveSampleOfType:(HKQuantityType *)quantityType
                     quantity:(HKQuantity *)quantity
                    startDate:(NSDate *)startDate
                      endDate:(NSDate *)endDate
                   complition:(void (^)(BOOL success, NSError * error))complitionBlock
{
    HKQuantitySample * sample = [HKQuantitySample quantitySampleWithType:quantityType
                                                                quantity:quantity
                                                               startDate:startDate
                                                                 endDate:endDate];

    [self saveObject:sample withCompletion:^(BOOL success, NSError * _Nullable error) {
        if (complitionBlock) {
            complitionBlock(success, error);
        }
    }];
}

@end
