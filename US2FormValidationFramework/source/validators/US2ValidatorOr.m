//
//  US2ValidatorOr.m
//  US2FormValidationFramework
//
//  Created by Matthew Purland on 10/10/12.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2ValidatorOr.h"

@implementation US2ValidatorOr

@synthesize validators;

- (id) initWithValidators: (NSArray *) validators {
    if (self = [super init]) {
        self.validators = [NSArray arrayWithArray: validators];
    }
    
    return self;
}

- (id) initWithValidatorOne: (id<US2ValidatorProtocol>) validatorOne two: (id<US2ValidatorProtocol>) validatorTwo {
    if (self = [self initWithValidators: [NSArray arrayWithObjects: validatorOne, validatorTwo, nil]]) {
        
    }
    
    return self;
}

@end
