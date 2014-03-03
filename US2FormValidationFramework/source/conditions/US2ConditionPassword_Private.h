//
//  US2ConditionPassword_Private.h
//  US2FormValidationFramework
//
//  Created by Martin Stolz on 28/11/2013.
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


@interface US2ConditionPassword ()

/**
 @methodName us2_strengthOfPasswordString:
 @param string The string to check for password strength
 @return Strength of password
 */
- (US2PasswordStrength)us2_strengthOfPasswordString:(NSString *)string;

/**
 @methodName us2_numberOfNumericCharactersInString:
 @param string The string to check for numbers
 @return Number of contained numbers
 */
- (NSUInteger)us2_numberOfNumericCharactersInString:(NSString *)string;

/**
 @methodName us2_numberOfLowercaseCharactersInString:
 @param string The string to check for lowercaser letters
 @return Number of contained lowercase letters
 */
- (NSUInteger)us2_numberOfLowercaseCharactersInString:(NSString *)string;

/**
 @methodName us2_numberOfUppercaseCharactersInString:
 @param string The string to check for uppercase letters
 @return Number of contained uppercase letters
 */
- (NSUInteger)us2_numberOfUppercaseCharactersInString:(NSString *)string;

/**
 @methodName us2_numberOfSpecialCharactersInString:
 @param string The string to check for symbols
 @return Number of contained symbols
 */
- (NSUInteger)us2_numberOfSpecialCharactersInString:(NSString *)string;

/**
 @methodName us2_numberOfMatchesWithPattern:
 @param pattern The pattern to check numbers of matches for
 @param string The string to check for a pattern
 @return Number of matches
 */
- (NSUInteger)us2_numberOfMatchesWithPattern:(NSString *)pattern inString:(NSString *)string;

@end
