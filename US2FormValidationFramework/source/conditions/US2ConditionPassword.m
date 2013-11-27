//
//  US2ConditionPassword.m
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

#import "US2ConditionPassword.h"


@implementation US2ConditionPassword


#pragma mark - Initilisation

- (id)init
{
    self = [super init];
    if(self != nil)
    {
        _requiredStrength = US2PasswordStrengthMedium;
    }
    
    return self;
}


#pragma mark - Condition check

- (BOOL)check:(NSString *)string
{
    BOOL passed = NO;
    
    if([self US2__strengthOfPasswordString:string] >= _requiredStrength)
    {
        passed = YES;
    }
    
    return passed;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return US2LocalizedString(@"US2KeyConditionViolationPassword", nil);
}


#pragma mark - Strength check

- (NSUInteger)US2__strengthOfPasswordString:(NSString *)string
{
    NSUInteger strength = 0;
    
    // Run regex on string to check for matches of lowercase, uppercase, numeric and special chars
    NSUInteger numberMatchesCount = [self US2__numberOfNumericCharactersInString:string];
    NSUInteger lowercaseMatchesCount = [self US2__numberOfLowercaseCharactersInString:string];
    NSUInteger uppercaseMatchesCount = [self US2__numberOfUppercaseCharactersInString:string];
    NSUInteger specialCharacterMatchesCount = [self US2__numberOfSpecialCharactersInString:string];
    
    // For each match of each type, move the strength value up one (higher = stronger)
    if (numberMatchesCount > _minimalNumbers)
    { 
        strength++;
    }
    
    if (lowercaseMatchesCount > _minimalLowerCase)
    { 
        strength++;
    }
    
    if (uppercaseMatchesCount > _minimalUpperCase)
    { 
        strength++;
    }
    
    if (specialCharacterMatchesCount > _minimalSymbols)
    { 
        strength++;
    }
    
    if (string.length >= _minimalLength)
    {
        strength++;
    }
    else if (strength > 0)
    {
        strength--;
    }
    
    return strength;
}


#pragma mark - Regular expressions

- (NSUInteger)US2__numberOfNumericCharactersInString:(NSString *)string
{
    return [self US2__numberOfMatchesWithPattern:@"\\d" inString:string];
}

- (NSUInteger)US2__numberOfLowercaseCharactersInString:(NSString *)string
{
    return [self US2__numberOfMatchesWithPattern:@"[a-z]" inString:string];
}

- (NSUInteger)US2__numberOfUppercaseCharactersInString:(NSString *)string
{
    return [self US2__numberOfMatchesWithPattern:@"[A-Z]" inString:string];
}

- (NSUInteger)US2__numberOfSpecialCharactersInString:(NSString *)string
{
    return [self US2__numberOfMatchesWithPattern:@"[^a-zA-Z\\d]" inString:string];
}

- (NSUInteger)US2__numberOfMatchesWithPattern:(NSString *)pattern inString:(NSString *)string
{
    NSError *error = NULL;
    NSUInteger matches = 0;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if(!error)
    {
        matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    }
    
    return matches;
}

@end
