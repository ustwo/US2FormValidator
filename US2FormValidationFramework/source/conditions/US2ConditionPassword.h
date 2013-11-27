//
//  US2ConditionPassword.h
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

#import "US2Condition.h"


#pragma mark - Strength enumerator

typedef enum
{
    US2PasswordStrengthVeryWeak   = 0,
    US2PasswordStrengthWeak       = 1,
    US2PasswordStrengthMedium     = 2,
    US2PasswordStrengthStrong     = 3,
    US2PasswordStrengthVeryStrong = 4,
    US2PasswordMatchesAll         = 5,
} US2PasswordStrength;


#pragma mark - US2ConditionPassword interface

/**
 The US2ConditionPassword checks for the strength of a password string.
 
 The strength is measured on five simple criteria:
 * contains X amount of lower case characters
 * contains X amount of upper case characters
 * contains X amount of numeric characters
 * contains X amount of special characters (e.g /';~)
 * is more than X characters long
 
 Each of these matched criteria moves the password strength of the string up one strength, strength is measured on five levels:
 
 US2PasswordStrengthVeryWeak     = 0,
 US2PasswordStrengthWeak         = 1,
 US2PasswordStrengthMedium       = 2,
 US2PasswordStrengthStrong       = 3,
 US2PasswordStrengthVeryStrong   = 4,
 US2PasswordMatchesAll           = 5, // All criteria is matched
 
 If the password strength matches or is above the required strength than the condition will pass.
 */
@interface US2ConditionPassword : US2Condition

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
 * US2PasswordStrengthVeryStrong
 * US2PasswordMatchesAll (All criteria is matched)
 
 */
@property (nonatomic) US2PasswordStrength requiredStrength;

@end
