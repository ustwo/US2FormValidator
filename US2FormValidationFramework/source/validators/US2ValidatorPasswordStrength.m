//
//  US2ValidatorPasswordStrength.m
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2ValidatorPasswordStrength.h"


@implementation US2ValidatorPasswordStrength


- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[US2ConditionPasswordStrength alloc] init]];
    }
    
    return self;
}

#pragma mark - Strength

- (void)setRequiredStrength:(US2PasswordStrength)requiredStrength
{
    if(requiredStrength != _requiredStrength)
    {
        _requiredStrength = requiredStrength;
        
        // Remove all added password strength coniditons
        [self removeConditionOfClass:[US2ConditionPasswordStrength class]];
        
        // Add new strength condition
        US2ConditionPasswordStrength *strengthCondition = [[US2ConditionPasswordStrength alloc] init];
        strengthCondition.requiredStrength = _requiredStrength;
        [self addCondition:strengthCondition];
    }
}

@end
