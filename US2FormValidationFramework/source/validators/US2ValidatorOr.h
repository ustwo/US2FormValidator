//
//  US2ValidatorOr.h
//  US2FormValidationFramework
//
//  Created by Matthew Purland on 10/10/12.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "US2Validator.h"

/**
    A validator for testing if one or another validator validates.
 */
@interface US2ValidatorOr : US2Validator {
@private
}

@property (retain, nonatomic) NSArray *validators;

/**
    Initialize with an array of validators.
 */
- (id) initWithValidators: (NSArray *) validators;

/**
    Initialize with two validators and validate using an or condition.
 */
- (id) initWithValidatorOne: (id<US2ValidatorProtocol>) validatorOne two: (id<US2ValidatorProtocol>) validatorTwo;

@end
