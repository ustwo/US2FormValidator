//
//  US2ConditionPasswordStrength.m
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

#import "US2ConditionPasswordStrength.h"

#pragma mark - US2ConditionpasswordStrength Private Interface

@interface US2ConditionPasswordStrength (Private)

- (NSUInteger)_numberOfNumericCharactersInString:(NSString *)string;

- (NSUInteger)_numberOfLowercaseCharactersInString:(NSString *)string;

- (NSUInteger)_numberOfUppercaseCharactersInString:(NSString *)string;

- (NSUInteger)_numberOfSpecialCharactersInString:(NSString *)string;

- (NSUInteger)_numberOfMatchesWithPattern:(NSString *)pattern inString:(NSString *)string;

- (NSUInteger)_strengthOfPasswordString:(NSString *)string;

@end


#pragma mark - US2ConditionpasswordStrength Implementation

@implementation US2ConditionPasswordStrength

@synthesize requiredStrength = _requiredStrength;


#pragma mark - Initilisation

- (id)init
{
    self = [super init];
    
    if(self != nil)
    {
        _requiredStrength = US2PasswordStrengthMedium; // default required strength
    }
    
    return self;
}

#pragma mark - Condition check

- (BOOL)check:(NSString *)string
{
    BOOL passed = NO;
    
    // If strength is more than or equal to the required strength to pass, the condition can pass
    if([self _strengthOfPasswordString:string] >= _requiredStrength)
    {
        passed = YES;
    }
    
    return passed;
}

#pragma mark - Allow violation

- (BOOL)shouldAllowViolation
{
    return YES;
}

#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return US2LocalizedString(@"US2KeyConditionViolationPasswordStrength", nil);
}

#pragma mark - Strength Check

- (NSUInteger)_strengthOfPasswordString:(NSString *)string
{
    
    NSUInteger strength = 0;
    
    // Run regex on string to check for matches of lowercase, uppercase, numeric and special chars
    NSUInteger numberMatchesCount = [self _numberOfNumericCharactersInString:string];
    NSUInteger lowercaseMatchesCount = [self _numberOfLowercaseCharactersInString:string];
    NSUInteger uppercaseMatchesCount = [self _numberOfUppercaseCharactersInString:string];
    NSUInteger specialCharacterMatchesCount = [self _numberOfSpecialCharactersInString:string];
    
    // For each match of each type, move the strength value up one (higher = stronger)
    if (numberMatchesCount > 0)	
    { 
        strength ++; 
    }
    
    if (lowercaseMatchesCount > 0)	
    { 
        strength ++; 
    }
    
    if (uppercaseMatchesCount > 0)	
    { 
        strength ++; 
    }
    
    if (specialCharacterMatchesCount > 0) 
    { 
        strength ++; 
    }
    
    // Move the strength up if the length is more than 8 characters and down if it is less
    if (string.length > 8) 
    { 
        strength ++; 
    }
    else if (strength > 0)
    {
        strength --;
    }
    
    return strength;
    
}

#pragma mark - Regular Expressions

- (NSUInteger)_numberOfNumericCharactersInString:(NSString *)string
{
    return [self _numberOfMatchesWithPattern:@"\\d" inString:string];
}

- (NSUInteger)_numberOfLowercaseCharactersInString:(NSString *)string
{
    return [self _numberOfMatchesWithPattern:@"[a-z]" inString:string];
}

- (NSUInteger)_numberOfUppercaseCharactersInString:(NSString *)string
{
    return [self _numberOfMatchesWithPattern:@"[A-Z]" inString:string];
}

- (NSUInteger)_numberOfSpecialCharactersInString:(NSString *)string
{
    return [self _numberOfMatchesWithPattern:@"[^a-zA-Z\\d]" inString:string];
}

- (NSUInteger)_numberOfMatchesWithPattern:(NSString *)pattern inString:(NSString *)string
{
    NSError *error      = NULL;
    NSUInteger matches  = 0;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if(!error)
    {
        matches =  [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    }
    
    return matches;
}

@end
