//
//  US2ConditionEmpty.h
//  US2FormValidationFramework
//
//  Created by Matthew Purland on 10/10/12.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "US2Condition.h"

/**
    A condition to check if a string is empty or null.
 */
@interface US2ConditionEmpty : US2Condition {
    
}

@property (assign, nonatomic) BOOL allowsNull;

@end