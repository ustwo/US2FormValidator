//
//  US2ConditionPasswordStrength.h
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2Condition.h"

#pragma mark - Strength Enumerator

typedef enum {
    US2PasswordStrengthVeryWeak     = 0,
    US2PasswordStrengthWeak         = 1,
    US2PasswordStrengthMedium       = 2,
    US2PasswordStrengthStrong       = 3,
    US2PasswordStrengthVeryStrong   = 4,
} US2PasswordStrength;


#pragma mark - US2ConditionPasswordStrength Interface

/**
 The US2ConditionPasswordStrength checks for the strength of a password string.
 
 The strength is measured on five simple criteria:
 * contains lower case characters
 * contains upper case characters
 * contains numeric characters
 * contains special characters (e.g /';~)
 * is more than 8 characters long
 
 Each of these matched criteria moves the password strength of the string up one strength, strength is measured on five levels:
 
 US2PasswordStrengthVeryWeak     = 0,
 US2PasswordStrengthWeak         = 1,
 US2PasswordStrengthMedium       = 2,
 US2PasswordStrengthStrong       = 3,
 US2PasswordStrengthVeryStrong   = 4,
 
 If the password strength matches or is above the required strength than the condition will pass. 
 
 */
@interface US2ConditionPasswordStrength : US2Condition

@property (nonatomic, assign) US2PasswordStrength requiredStrength;

@end
