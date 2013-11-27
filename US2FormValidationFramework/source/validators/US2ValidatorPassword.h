//
//  US2ValidatorPassword.h
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Modified by Martin Stolz on 27/11/2013.
//  Copyright (C) 2012 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "US2Validator.h"
#import "US2ConditionPassword.h"


/**
 The password strength validator contains a password strength condition (see US2ConditionPasswordStrength).
 A valid string matches or is above the required strength.
 */
@interface US2ValidatorPassword : US2Validator

/**
 How many lower case characters the password should contain.
 */
@property (nonatomic) NSUInteger minimalLowerCase;

/**
 How many upper case characters the password should contain.
 */
@property (nonatomic) NSUInteger minimalUpperCase;

/**
 How many numbers the password should contain.
 */
@property (nonatomic) NSUInteger minimalNumbers;

/**
 How many symbols the password should contain.
 */
@property (nonatomic) NSUInteger minimalSymbols;

/**
 How many characters the password should contain.
 */
@property (nonatomic) NSUInteger minimalLength;

/**
 How strong the password needs to be to be valid.
 
 The required password strength of the validator, options are:
 
 * US2PasswordStrengthVeryWeak
 * US2PasswordStrengthWeak
 * US2PasswordStrengthMedium (Default Value)
 * US2PasswordStrengthStrong
 * US2PasswordStrengthVeryStrong (All criteria is matched)
 
 */
@property (nonatomic) US2PasswordStrength requiredStrength;

@end
