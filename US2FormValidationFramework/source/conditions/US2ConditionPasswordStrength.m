//
//  US2ConditionPasswordStrength.m
//  US2FormValidationFramework
//
//  Created by Alex Fish on 07/05/2012.
//  Copyright (c) 2012 ustwo™. All rights reserved.
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

- (NSString *)localizedViolationString
{
    NSString *key = @"US2KeyConditionViolationPasswordStrength";
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Localization.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (bundle)
    {
        return [bundle localizedStringForKey:key value:key table:nil];
    }
    
    return nil;
}

#pragma mark - Strength Check

- (NSUInteger)_strengthOfPasswordString:(NSString *)string
{
    
    NSUInteger strength = 0;
    
    NSUInteger numberMatchesCount = [self _numberOfNumericCharactersInString:string];
    NSUInteger lowercaseMatchesCount = [self _numberOfLowercaseCharactersInString:string];
    NSUInteger uppercaseMatchesCount = [self _numberOfUppercaseCharactersInString:string];
    NSUInteger specialCharacterMatchesCount = [self _numberOfSpecialCharactersInString:string];
    
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
