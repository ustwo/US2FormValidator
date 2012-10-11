//
//  US2ValidatorPasswordStrength.h
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Copyright (c) 2012 ustwo™. All rights reserved.
//

#import "US2Validator.h"

#import "US2ConditionPasswordStrength.h"


/**
 The password strength validator contains a password strength condition (see US2ConditionPasswordStrength).
 A valid string matches or is above the required strength.
 */
@interface US2ValidatorPasswordStrength : US2ValidatorSingleCondition

/**
 The required password strength of the validator, options are:
 
 * US2PasswordStrengthVeryWeak
 * US2PasswordStrengthWeak
 * US2PasswordStrengthMedium (Default Value)
 * US2PasswordStrengthStrong
 * US2PasswordStrengthVeryStrong
 
 */
@property (nonatomic, assign) US2PasswordStrength requiredStrength; 

@end
