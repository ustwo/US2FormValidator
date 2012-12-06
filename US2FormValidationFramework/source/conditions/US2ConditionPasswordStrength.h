//
//  US2ConditionPasswordStrength.h
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
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
